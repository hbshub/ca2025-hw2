# --- External Function Declarations ---
.extern print_dec       # Declare external C function 'print_dec' to be linked

# --- Text Section ---
.text
.globl run_q2_game_hanoi
run_q2_game_hanoi:
    # 1. PROLOGUE (Modified)
    # We need to call an external function (jal print_dec), so we must save ra (x1)
    # Allocate 48 bytes (16-byte aligned)
    # 0-19: s0-s4 (x8, x9, x18, x19, x20)
    # 20-31: Disk array
    # 32: ra (x1)
    # 36-37: Temp char buffer for 'A'/'B'/'C'
    addi    x2, x2, -48
    sw      x8, 0(x2)
    sw      x9, 4(x2)
    sw      x18, 8(x2)
    sw      x19, 12(x2)
    sw      x20, 16(x2)
    sw      x1, 32(x2)      # <-- Key: Save the return address (ra)

    # ... (Disk position initialization is unchanged) ...
    sw      x0, 20(x2)
    sw      x0, 24(x2)
    sw      x0, 28(x2)

    addi    x8, x0, 1
game_loop:
    addi    x5, x0, 8
    beq     x8, x5, finish_game

    # --- (Gray code and move logic is unchanged) ---
    srli    x5, x8, 1
    xor     x6, x8, x5
    addi    x7, x8, -1
    srli    x28, x7, 1
    xor     x7, x7, x28
    xor     x5, x6, x7
    addi    x9, x0, 0
    andi    x6, x5, 1
    bne     x6, x0, disk_found
    addi    x9, x0, 1
    andi    x6, x5, 2
    bne     x6, x0, disk_found
    addi    x9, x0, 2
disk_found:
    andi    x30, x5, 5
    addi    x31, x0, 5
    beq     x30, x31, pattern_match
    jal     x0, continue_move
pattern_match:
continue_move:
    slli    x5, x9, 2
    addi    x5, x5, 20
    add     x5, x2, x5
    lw      x18, 0(x5)      # x18 = source peg (0, 1, 2)
    bne     x9, x0, handle_large
    addi    x19, x18, 2
    addi    x6, x0, 3
    blt     x19, x6, display_move
    sub     x19, x19, x6
    jal     x0, display_move
handle_large:
    lw      x6, 20(x2)
    addi    x19, x0, 3
    sub     x19, x19, x18
    sub     x19, x19, x6    # x19 = destination peg (0, 1, 2)
    # x9 = disk_id, x18 = from_peg, x19 = to_peg

# --- 2. DISPLAY SECTION (Rewritten to use sys_write and print_dec) ---
display_move:
    # 1. Print "Move Disk " (using sys_write, a7=64)
    # This is identical to the asm volatile in your C macro
    add     a7, x0, 0x40        # a7 = 64 (sys_write)
    add     a0, x0, 1           # a0 = 1 (stdout)
    la      a1, str1            # a1 = pointer to string
    addi    a2, x0, 11          # a2 = length of "Move Disk "
    ecall

    # 2. Print the disk number (call C function)
    addi    a0, x9, 1           # a0 = argument (x9+1)
    jal     ra, print_dec       # Call C function

    # 3. Print " from " (using sys_write)
    add     a7, x0, 0x40
    add     a0, x0, 1
    la      a1, str2
    addi    a2, x0, 6           # length of " from "
    ecall

    # 4. Print 'from' peg (A/B/C)
    la      x20, obdata
    add     x5, x20, x18        # x18 = 'from' index
    lbu     x11, 0(x5)
    li      x6, 0x6F
    xor     x11, x11, x6
    addi    x11, x11, -0x12     # x11 = 'A', 'B', or 'C'
    
    # Store the character 'A'/'B'/'C' into the temp buffer on the stack
    sb      x11, 36(x2)
    
    # Print that 1-byte buffer
    add     a7, x0, 0x40
    add     a0, x0, 1
    add     a1, x2, 36          # a1 = pointer to stack buffer
    addi    a2, x0, 1           # a2 = length (1)
    ecall

    # 5. Print " to " (using sys_write)
    add     a7, x0, 0x40
    add     a0, x0, 1
    la      a1, str3
    addi    a2, x0, 4           # length of " to "
    ecall

    # 6. Print 'to' peg (A/B/C)
    add     x5, x20, x19        # x19 = 'to' index
    lbu     x12, 0(x5)
    xor     x12, x12, x6
    addi    x12, x12, -0x12     # x12 = 'A', 'B', or 'C'
    sb      x12, 37(x2)         # Store to a different location on the stack
    
    add     a7, x0, 0x40
    add     a0, x0, 1
    add     a1, x2, 37          # a1 = pointer
    addi    a2, x0, 1           # a2 = length (1)
    ecall

    # 7. Print newline character '\n' (using sys_write)
    add     a7, x0, 0x40
    add     a0, x0, 1
    la      a1, str_nl
    addi    a2, x0, 1           # length (1)
    ecall
    
    # --- (State update logic is unchanged) ---
    slli    x5, x9, 2
    addi    x5, x5, 20
    add     x5, x2, x5
    sw      x19, 0(x5)      # Update disk position
    
    addi    x8, x8, 1
    jal     x0, game_loop

# --- 3. FINISH SECTION (Modified) ---
finish_game:
    # Restore all registers
    lw      x8, 0(x2)
    lw      x9, 4(x2)
    lw      x18, 8(x2)
    lw      x19, 12(x2)
    lw      x20, 16(x2)
    lw      x1, 32(x2)      # <-- Key: Restore the return address (ra)
    
    # Deallocate the stack
    addi    x2, x2, 48
    
    # [Modified] Use ret instruction to return to C code
    ret

.data
obdata:     .byte   0x3c, 0x3b, 0x3a
str1:       .asciz  "Move Disk "    # length 11
str2:       .asciz  " from "        # length 6
str3:       .asciz  " to "          # length 4
str_nl:     .byte   10              # Newline (ASCII 10)