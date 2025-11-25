# ------------------------------------------------------------
# clz(x) for RV32I, binary-search unrolled (shift-only)
# ------------------------------------------------------------
clz:
    beq   a0, x0, clz_zero      # Handle special case: x == 0
    li    t0, 0                 # n = 0 (leading zero count)

    # 1. Check top 16 bits (bits 31-16)
    srli  t1, a0, 16            # t1 = x >> 16
    bnez  t1, check_8_bits      # If top 16 bits are set (t1 != 0), skip n update
    addi  t0, t0, 16            # Else, n += 16
    slli  a0, a0, 16            # x <<= 16 (mask out top 16 bits)
check_8_bits:
    
    # 2. Check top 8 bits (bits 23-16 of original, now 31-24)
    srli  t1, a0, 24            # t1 = x >> 24
    bnez  t1, check_4_bits      # If top 8 bits are set, skip n update
    addi  t0, t0, 8             # Else, n += 8
    slli  a0, a0, 8             # x <<= 8
check_4_bits:
    
    # 3. Check top 4 bits (bits 27-24 of original, now 31-28)
    srli  t1, a0, 28            # t1 = x >> 28
    bnez  t1, check_2_bits      # If top 4 bits are set, skip n update
    addi  t0, t0, 4             # Else, n += 4
    slli  a0, a0, 4             # x <<= 4
check_2_bits:

    # 4. Check top 2 bits (bits 29-28 of original, now 31-30)
    srli  t1, a0, 30            # t1 = x >> 30
    bnez  t1, check_1_bit       # If top 2 bits are set, skip n update
    addi  t0, t0, 2             # Else, n += 2
    slli  a0, a0, 2             # x <<= 2
check_1_bit:

    # 5. Check top 1 bit (bit 30 of original, now 31)
    srli  t1, a0, 31            # t1 = x >> 31
    bnez  t1, clz_finish        # If top 1 bit is set, skip n update
    addi  t0, t0, 1             # Else, n += 1
clz_finish:
    mv    a0, t0                # Set return value to n
    ret

clz_zero:
    li    a0, 32                # Return 32 if x was 0
    ret
# ------------------------------------------------------------