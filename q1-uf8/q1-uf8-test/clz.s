.data
.text
main:
    li a0, 0x00200000   # test data
    jal ra, clz
    # result in a0
halt:
    j halt
# uint32_t clz(uint32_t x)
# a0: x (input/output)
# return a0 = count of leading zeros
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
    bnez t1, clz_loop        # while (c) loop
    sub  a0, t0, a0          # return n - x
    ret












