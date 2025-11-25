.data
test_in:
    .byte 0x00, 0x10, 0x1F, 0x20, 0x2F, 0x7F, 0xF0, 0xFF
test_out:
    .word 0,0,0,0,0,0,0,0

.text
main:
    la   s0, test_in
    la   s1, test_out
    li   s2, 8

loop:
    beqz s2, halt
    lbu  a0, 0(s0)          # load test_int -> a0
    addi s0, s0, 1
    jal  ra, uf8_decode     # a0 = uf8_decode(a0)
    sw   a0, 0(s1)          # store a0 -> test_out
    addi s1, s1, 4
    addi s2, s2, -1
    j    loop

halt:
    j    halt

# by simplify the decode foumula
# => (m ≪ e) + offset
# => (m≪e) + ((2^e − 1)⋅16)
# => (m≪e) + (16<<e) - 16
# => ((m+16) << e) - 16 = a0
uf8_decode:
    srli t0, a0, 4      # t0 = e
    andi a0, a0, 0x0F   # a0 = m
    addi a0, a0, 16     # a0 = m + 16
    sll  a0, a0, t0     # a0 = (m + 16) << e
    addi a0, a0, -16    # a0 = a0- 16
    ret