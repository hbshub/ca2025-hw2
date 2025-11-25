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
# val = uf8_decode(fl)
# fl2 = uf8_encode(val)
test:
    # ABI: 'test' is a callee, must save callee-saved registers (s4)
    addi sp, sp, -16      # 16-byte align
    sw   ra, 12(sp)       # Save ra
    sw   s4, 8(sp)        # Save s4

loop:
    beqz s2, test_end     # remaining == 0 ? test_end 
    andi a0, s0, 255      # load fl = (uint8_t)i
    jal  uf8_decode

    addi s4, a0, 0        # s4 = value = uf8_decode(fl)
    jal  uf8_encode   
    andi a0, a0, 255      # a0 = (uint8_t)fl2 = uf8_encode(value)
    bne  s0, a0, set_fail # fl != fl2 ? fail 

check_mono_inc:
    blt  s1, s4, ok       # previous_value < value ? ok 
    li   s3, 0            # passed = 0
    li   t3, 1            # for debug
    jal  print_fail_msg   # Call print_fail_msg


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
uf8_decode:
    srli t0, a0, 4        # t0 = e
    andi a0, a0, 0x0F     # a0 = m
    addi a0, a0, 16       # a0 = m + 16
    sll  a0, a0, t0       # a0 = (m + 16) << e
    addi a0, a0, -16      # a0 = a0 - 16
    ret
# ------------------------------------------------------------
uf8_encode:
    li  t3, 16
    bge a0, t3, e_not_zero         # if (a0 >= 16) e_not_zero
    ret
e_not_zero:                        # e != 0 
    addi sp, sp, -16      # 16-byte align
    sw   a0, 8(sp)        # Save a0
    sw   ra, 12(sp)       # Save ra

    jal   ra, clz            # a0 = clz(a0)
    li  t3, 31
    sub t0, t3, a0          # msb = t0 = 31 - clz(a0)

    lw   a0, 8(sp)        # Restore a0
    lw   ra, 12(sp)       # Restore ra
    addi sp, sp, 16       # Restore sp

    li t1, 0                # exp = t1 = 0
    li t2, 0                # of = t2 = 0

    li   t3, 5
    blt  t0, t3, find_exa_exp         # if (msb < 5) find_exa_exp
    addi t1, t0, -4               # exp = msb - 4

    li  t0, 0                    # t0 = cnt = 0
    ble t1, s5, calc_exp        # if (exp < 15) calc_exp
    li  t1, 15                   # exp = 15

calc_exp:
    bge  t0, t1, adj_exp         # if (cnt < exp) loop
    slli t2, t2, 1              # of = of << 1
    addi t2, t2, 16             # of = of + 16
    addi t0, t0, 1              # cnt++
    j    calc_exp
    
adj_exp:
    ble  t1, x0, find_exa_exp        # if (exp <= 0) find_exa_exp
    bge  a0, t2, find_exa_exp        # if (a0 >= of) find_exa_exp 
    addi t2, t2, -16                # of = of - 16
    srli t2, t2, 1                  # of = of >> 1
    addi t1, t1, -1                 # exp--
    j    adj_exp
    
find_exa_exp:
    bge  t1, s5, calc_m         # if (exp >= 15) calc_m    
    slli t0, t2, 1              # t0 = of << 1
    addi t0, t0, 16             # t0 = (of << 1) + 16 = of_e+1
    blt  a0, t0, calc_m         # if (a0 < of_e) calc_m
    mv   t2, t0                   # of = of_e
    addi t1, t1, 1              # exp++
    j    find_exa_exp

calc_m:
    sub t0, a0, t2              # t0 = value - of
    srl t0, t0, t1             # t0 = (value - of) >> exp = m
    ble t0, s5, cmb_num        # if (m < 15) cmb_num
    li  t0, 15                   # m = 15
cmb_num:    
    slli t1, t1, 4              # t1 = exp << 4
    or   a0, t1, t0              # a0 = (exp << 4) | m
    ret
# ------------------------------------------------------------
clz:
    li   t0, 32              # n = 32
    li   t1, 16              # c = 16

clz_loop:
    srl  t2, a0, t1          # y = x >> c
    beq  t2, x0, skip_update # if (y == 0) skip update
    sub  t0, t0, t1          # n = n - c
    mv   a0, t2              # x = y

skip_update:
    srli t1, t1, 1           # c = c / 2
    bgtz t1, clz_loop        # while (c) loop
    sub  a0, t0, a0          # return n - x
    ret


# ------------------------------------------------------------
# --- Helper Functions ---
# ------------------------------------------------------------

# Helper: printstr_asm(a0 = string_addr, a1 = string_len)
# Uses ecall 64 (sys_write)
printstr_asm:
    mv   t1, a0             # t1 = string_addr
    mv   t2, a1             # t2 = string_len
    li   a7, 64             # a7 = syscall write (0x40)
    li   a0, 1              # a0 = stdout
    mv   a1, t1
    mv   a2, t2
    ecall
    ret

# Helper: void print_fail_msg(void)
print_fail_msg:
    # ABI: 'test' relies on s0, s1, s4.
    # Must save them before calling C function 'print_dec'.
    # Need 3 (s) + 1 (ra) = 4 regs
    addi sp, sp, -16      # 16-byte align
    sw   ra, 12(sp)
    sw   s0, 8(sp)        # Save s0
    sw   s1, 4(sp)        # Save s1
    sw   s4, 0(sp)        # Save s4

    bnez t3, t3_1

# Error 0: fl != fl2 (t3 = 0)
    mv  a0, s0
    jal print_dec           # Call C function (now safe)
    
    la  a0, str1
    li  a1, str1_len
    jal printstr_asm

    mv  a0, s4
    jal print_dec

    la  a0, str2
    li  a1, str2_len
    jal printstr_asm

    mv  a0, t4              # (t4 = fl2 saved in set_fail)
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
    lw   ra, 12(sp)       # Restore ra
    lw   s0, 8(sp)        # Restore s0
    lw   s1, 4(sp)        # Restore s1
    lw   s4, 0(sp)        # Restore s4
    addi sp, sp, 16
    ret

# Helper: void print_suc_msg(void)
print_suc_msg:
    la  a0, str6
    li  a1, str6_len
    jal printstr_asm
    j main_c
