.text
.global clz

# -----------------------------------------------------------------------
# clz (Count Leading Zeros)
# Input:  a0 
# Output: a0
# -----------------------------------------------------------------------

clz:
    # 1. Handle special case: input is 0
    beqz    a0, is_zero         # If a0 == 0, jump to is_zero

    # 2. Initialize counter (t0)
    li      t0, 0

    # --- Check upper 16 bits ---
    srli    t1, a0, 16
    bnez    t1, check_8         # If upper 16 bits are not zero, go check upper 8 bits
    addi    t0, t0, 16          # Otherwise n += 16
    slli    a0, a0, 16          # x <<= 16

check_8:
    # --- Check upper 8 bits ---
    srli    t1, a0, 24
    bnez    t1, check_4
    addi    t0, t0, 8
    slli    a0, a0, 8

check_4:
    # --- Check upper 4 bits ---
    srli    t1, a0, 28
    bnez    t1, check_2
    addi    t0, t0, 4
    slli    a0, a0, 4

check_2:
    # --- Check upper 2 bits ---
    srli    t1, a0, 30
    bnez    t1, check_1
    addi    t0, t0, 2
    slli    a0, a0, 2

check_1:
    # --- Check highest bit (Bit 31) ---
    bltz    a0, done            # If a0 < 0 (Bit 31 == 1), done
    addi    t0, t0, 1           # Otherwise n += 1

done:
    mv      a0, t0              # Move result into a0
    ret

is_zero:
    li      a0, 32              # Special return value when input is zero
    ret
