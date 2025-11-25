.data
str1: .string ": produces value "
.equ str1_len, . - str1 - 1
str2: .string " but encodes back to "
.equ str2_len, . - str2 - 1
str3: .string ": value "
.equ str3_len, . - str3 - 1
str4: .string " <= previous_value "
.equ str4_len, . - str4 - 1
str5: .string "\n"
.equ str5_len, . - str5 - 1
str6: .string "All tests passed\n"
.equ str6_len, . - str6 - 1

.text
.globl run_q1_uf8    # Declare global symbol
.extern print_dec    # Declare external C function

run_q1_uf8:
    # ABI: Allocate 32 bytes (16-byte aligned) for 6 registers
    addi sp, sp, -32
    sw   ra, 28(sp)       # Save ra (return address to C)
    sw   s0, 24(sp)       # Save s0
    sw   s1, 20(sp)       # Save s1
    sw   s2, 16(sp)       # Save s2
    sw   s3, 12(sp)       # Save s3
    sw   s5, 8(sp)        # Save s5

    li   s0, 0            # s0 = i / fl (0..255)
    li   s1, -1           # s1 = previous_value
    li   s2, 256          # s2 = remaining count
    li   s3, 1            # s3 = passed (1=ok, 0=fail)
    li   s5, 15           # s5 = cmp value
    jal  test             # run test
    bne a0, x0, print_suc_msg

main_c:
    # ABI: Restore all saved registers
    lw   ra, 28(sp)
    lw   s0, 24(sp)
    lw   s1, 20(sp)
    lw   s2, 16(sp)
    lw   s3, 12(sp)
    lw   s5, 8(sp)
    addi sp, sp, 32       # Restore stack
    ret 

# round-trip test
test:
    # ABI: 'test' is a callee, must save callee-saved registers (s4)
    addi sp, sp, -16      # 16-byte align
    sw   ra, 12(sp)       # Save ra
    sw   s4, 8(sp)        # Save s4

loop:
    beqz s2, test_end     
    andi a0, s0, 255      # load fl = (uint8_t)i
    
    # --- INLINED uf8_decode ---
    # This replaces 'jal uf8_decode' to save cycles
    srli t0, a0, 4        
    andi a0, a0, 0x0F     
    addi a0, a0, 16       
    sll  a0, a0, t0       
    addi a0, a0, -16
    # --- End Inlined uf8_decode ---

    addi s4, a0, 0        # s4 = value = uf8_decode(fl)
    jal  uf8_encode       # Call optimized uf8_encode
    andi a0, a0, 255      
    bne  s0, a0, set_fail # fl != fl2 ? fail 

check_mono_inc:
    blt  s1, s4, ok       # previous_value < value ? ok 
    li   s3, 0            # passed = 0
    li   t3, 1            # for debug
    jal  print_fail_msg   

ok:
    addi s1, s4, 0        # previous_value = value
    addi s0, s0, 1        # i++
    addi s2, s2, -1       # remaining--
    j    loop

set_fail:
    li   s3, 0            # passed = 0
    li   t3, 0            # for debug
    mv   t4, a0           # t4 = fl2
    jal  print_fail_msg   
    j    check_mono_inc

test_end:
    addi a0, s3, 0        # a0 = return value (1=pass, 0=fail)
    lw   ra, 12(sp)       # Restore ra
    lw   s4, 8(sp)        # Restore s4
    addi sp, sp, 16       # Restore sp
    ret
# ------------------------------------------------------------
# Note: uf8_decode function was removed and inlined into 'test'
# ------------------------------------------------------------
uf8_encode:
    li  t3, 16
    bge a0, t3, e_not_zero         
    ret
e_not_zero:
    # We must save 'ra' because we 'jal clz'.
    # We use 't4' to save 'a0', avoiding sw/lw for it.
    addi sp, sp, -16      
    sw   ra, 12(sp)       
    
    mv   t4, a0           
    jal  ra, clz          
    li   t3, 31
    sub  t0, t3, a0       
    mv   a0, t4           

    lw   ra, 12(sp)       
    addi sp, sp, 16       

    li t1, 0                
    li t2, 0                

    li   t3, 5
    blt  t0, t3, find_exa_exp         
    addi t1, t0, -4               

    # Replaced O(n) loop with O(1) formula & removed s5 dependency.
    sltiu t3, t1, 16
    beqz  t3, set_exp_15    # if (t1 >= 16), set exp = 15
    j     build_of_once
set_exp_15:
    li    t1, 15          
build_of_once:
    # Build 'of' using O(1) formula: of = ((1<<exp) - 1) << 4
    li   t2, 1
    sll  t2, t2, t1       
    addi t2, t2, -1       
    slli t2, t2, 4        
    j    adj_exp          
    
adj_exp:
    ble  t1, x0, find_exa_exp        
    bge  a0, t2, find_exa_exp         
    addi t2, t2, -16                
    srli t2, t2, 1                  
    addi t1, t1, -1                 
    j    adj_exp
    
find_exa_exp:
    bge  t1, s5, calc_m         
    slli t0, t2, 1              
    addi t0, t0, 16             
    blt  a0, t0, calc_m         
    mv   t2, t0                   
    addi t1, t1, 1              
    j    find_exa_exp

calc_m:
    sub t0, a0, t2              
    srl t0, t0, t1             
    ble t0, s5, cmb_num        
    li  t0, 15                   
cmb_num:    
    slli t1, t1, 4              
    or   a0, t1, t0              
    ret

# ------------------------------------------------------------
# clz(x) for RV32I, binary-search unrolled (shift-only)
# ------------------------------------------------------------
clz:
    beq   a0, x0, clz_zero      # Handle special case: x == 0
    li    t0, 0                 # n = 0 (leading zero count)

    # 1. Check top 16 bits (bits 31-16)
    srli  t1, a0, 16            
    bnez  t1, check_8_bits      
    addi  t0, t0, 16            
    slli  a0, a0, 16            
check_8_bits:
    
    # 2. Check top 8 bits (bits 23-16 of original, now 31-24)
    srli  t1, a0, 24            
    bnez  t1, check_4_bits      
    addi  t0, t0, 8             
    slli  a0, a0, 8             
check_4_bits:
    
    # 3. Check top 4 bits (bits 27-24 of original, now 31-28)
    srli  t1, a0, 28            
    bnez  t1, check_2_bits      
    addi  t0, t0, 4             
    slli  a0, a0, 4             
check_2_bits:

    # 4. Check top 2 bits (bits 29-28 of original, now 31-30)
    srli  t1, a0, 30            
    bnez  t1, check_1_bit       
    addi  t0, t0, 2             
    slli  a0, a0, 2             
check_1_bit:

    # 5. Check top 1 bit (bit 30 of original, now 31)
    srli  t1, a0, 31            
    bnez  t1, clz_finish        
    addi  t0, t0, 1             
clz_finish:
    mv    a0, t0                
    ret

clz_zero:
    li    a0, 32                
    ret
# --- End clz function ---

# ------------------------------------------------------------
# --- Helper Functions ---
# ------------------------------------------------------------

# Helper: printstr_asm(a0 = string_addr, a1 = string_len)
# Uses ecall 64 (sys_write)
printstr_asm:
    mv   t1, a0             
    mv   t2, a1             
    li   a7, 64             
    li   a0, 1              
    mv   a1, t1
    mv   a2, t2
    ecall
    ret

# Helper: void print_fail_msg(void)
print_fail_msg:
    # ABI: 'test' relies on s0, s1, s4.
    # Must save them before calling C function 'print_dec'.
    addi sp, sp, -16      
    sw   ra, 12(sp)
    sw   s0, 8(sp)        
    sw   s1, 4(sp)        
    sw   s4, 0(sp)        

    bnez t3, t3_1

# Error 0: fl != fl2 (t3 = 0)
    mv  a0, s0
    jal print_dec           
    
    la  a0, str1
    li  a1, str1_len
    jal printstr_asm

    mv  a0, s4
    jal print_dec

    la  a0, str2
    li  a1, str2_len
    jal printstr_asm

    mv  a0, t4              
    jal print_dec
    
    la  a0, str5
    li  a1, str5_len
    jal printstr_asm
    j   print_fail_end

t3_1:
# Error 1: previous_value >= value (t3 = 1)
    mv  a0, s0
    jal print_dec
    
    la  a0, str3
    li  a1, str3_len
    jal printstr_asm

    mv  a0, s4
    jal print_dec

    la  a0, str4
    li  a1, str4_len
    jal printstr_asm

    mv  a0, s1
    jal print_dec
    
    la  a0, str5
    li  a1, str5_len
    jal printstr_asm

print_fail_end:
    lw   ra, 12(sp)       
    lw   s0, 8(sp)        
    lw   s1, 4(sp)        
    lw   s4, 0(sp)        
    addi sp, sp, 16
    ret

# Helper: void print_suc_msg(void)
print_suc_msg:
    la  a0, str6
    li  a1, str6_len
    jal printstr_asm
    j main_c