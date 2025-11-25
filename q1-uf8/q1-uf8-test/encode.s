.data
test_in:
    # .byte 0x00, 0x10, 0x1F, 0x20, 0x2F, 0x7F, 0xF0, 0xFF
    # .word 0, 1, 15, 16, 17, 31, 32, 111
    .word 1015792, 299, 495, 557040 
test_out:
    # .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0

.text
main:
    la   s0, test_in
    la   s1, test_out
    li   s2, 4

loop:
    beqz s2, halt
    lw  a0, 0(s0)          # load test_int -> a0
    addi s0, s0, 4
    jal  ra, uf8_encode     # a0 = uf8_encode(a0)
    sb   a0, 0(s1)          # store a0 -> test_out
    addi s1, s1, 1
    addi s2, s2, -1
    j    loop

halt:
    j    halt

# uf8_encode : encode a value into 1-byte uf8 encoding
# input a0 - uint32_t value
# return a0 - uf8 uf8_encode(value)
uf8_encode:
    li t3, 16
    bge a0, t3, e_!0         # if (a0 >= 16) e_!0
    ret
e_!0:                        # e != 0 
    addi sp, sp, -8
    sw a0, 0(sp)          # store a0 in stack
    sw ra, 4(sp)          # store ra in stack  

    jal  ra, clz            # a0 = clz(a0)
    li t3, 31
    sub t0, t3, a0          # msb = t0 = 31 - clz(a0)

    lw a0, 0(sp)            # restore a0 from stack
    lw ra, 4(sp)            # restore ra from stack
    addi sp, sp, 8

    li t1, 0                # exp = t1 = 0
    li t2, 0                # of = t2 = 0

    li t3, 5
    blt t0, t3, find_exa_exp         # if (msb < 5) find_exa_exp
    addi t1, t0, -4               # exp = msb - 4

    li t0, 0                    # t0 = cnt = 0
    li t3, 15                   # t3 = 15, cmp value
    ble t1, t3, calc_exp        # if (exp < 15) calc_exp
    li t1, 15                   # exp = 15

calc_exp:
    bge t0, t1, adj_exp         # if (cnt < exp) loop
    slli t2, t2, 1              # of = of << 1
    addi t2, t2, 16             # of = of + 16
    addi t0, t0, 1              # cnt++
    jal x0, calc_exp
    
adj_exp:
    ble t1, x0, find_exa_exp        # if (exp <= 0) find_exa_exp
    bge a0, t2, find_exa_exp        # if (a0 >= of) find_exa_exp 
    addi t2, t2, -16                # of = of - 16
    srli t2, t2, 1                  # of = of >> 1
    addi t1, t1, -1                 # exp--
    jal x0, adj_exp
    

    
find_exa_exp:
    bge t1, t3, calc_m         # if (exp >= 15) calc_m    
    slli t0, t2, 1              # t0 = of << 1
    addi t0, t0, 16             # t0 = (of << 1) + 16 = of_e+1
    blt a0, t0, calc_m         # if (a0 >= of_e) calc_m
    mv t2, t0                   # of = of_e
    addi t1, t1, 1              # exp++
    jal x0, find_exa_exp

calc_m:
    sub t0, a0, t2              # t0 = value - of
    srl t0, t0, t1             # t0 = (value - of) >> exp = m
    ble t0, t3, cmb_num        # if (m < 15) cmb_num
    li t0, 15                   # m = 15
cmb_num:    
    slli t1, t1, 4              # t1 = exp << 4
    or  a0, t1, t0              # a0 = (exp << 4) | m
    ret

# clz : count leading zeros
# input : a0 - uint32_t x
# return : a0 - uint32_t clz (x)
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