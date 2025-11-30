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



.global clz_brless
# -----------------------------------------------------------------------
# clz_branchless_binary
# Branchless CLZ implementation using a binary search pattern.
# Input:  a0
# Output: a0
# -----------------------------------------------------------------------
clz_brless:
    # Preserve original input for zero correction
    mv      t5, a0
    
    # Initialize counter
    li      t0, 0

    # Check upper 16 bits
    srli    t1, a0, 16
    sltiu   t2, t1, 1        # t2 = (t1 == 0)
    slli    t3, t2, 4        # shift amount = 16 or 0
    add     t0, t0, t3
    sll     a0, a0, t3

    # Check upper 8 bits
    srli    t1, a0, 24
    sltiu   t2, t1, 1
    slli    t3, t2, 3        # shift amount = 8 or 0
    add     t0, t0, t3
    sll     a0, a0, t3

    # Check upper 4 bits
    srli    t1, a0, 28
    sltiu   t2, t1, 1
    slli    t3, t2, 2        # shift amount = 4 or 0
    add     t0, t0, t3
    sll     a0, a0, t3

    # Check upper 2 bits
    srli    t1, a0, 30
    sltiu   t2, t1, 1
    slli    t3, t2, 1        # shift amount = 2 or 0
    add     t0, t0, t3
    sll     a0, a0, t3

    # Check MSB
    srli    t1, a0, 31
    sltiu   t2, t1, 1
    add     t0, t0, t2

    # Zero-input adjustment (CLZ(0) = 32)
    seqz    t4, t5
    add     a0, t0, t4
    
    ret


.global mul32
# -----------------------------------------------------------------------
# mul32: Unsigned 32x32 -> 64-bit multiplication
# Input:  a0 = a, a1 = b
# Output: a1:a0 = result (hi:lo)
# -----------------------------------------------------------------------

mul32:
    # Clear result accumulators
    # t0 = res_lo, t1 = res_hi
    li      t0, 0
    li      t1, 0

    # Extend 'a' to 64-bit. t2 holds the upper 32 bits.
    li      t2, 0

mul32_loop:
    # Early exit if multiplier is empty
    beqz    a1, mul32_done

    # Check LSB. Skip add if bit is 0.
    andi    t3, a1, 1
    beqz    t3, mul32_shift

    # --- Add 'a' to result (64-bit) ---
    add     t0, t0, a0      # res_lo += a_lo
    sltu    t3, t0, a0      # Carry bit? (1 if wrapped around, else 0)
    add     t1, t1, t2      # res_hi += a_hi
    add     t1, t1, t3      # res_hi += carry

mul32_shift:
    # --- Shift 'a' left by 1 (64-bit) ---
    # Need to bridge the MSB of a_lo to LSB of a_hi
    srli    t3, a0, 31      # Grab MSB from low part
    slli    a0, a0, 1       # a_lo << 1
    slli    t2, t2, 1       # a_hi << 1
    or      t2, t2, t3      # Merge MSB into high part

    # Shift multiplier right
    srli    a1, a1, 1
    
    j       mul32_loop

mul32_done:
    # Set return values
    mv      a0, t0
    mv      a1, t1
    ret