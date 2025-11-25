# --- External Function Declarations ---
.extern print_dec       # 宣告我們要連結外部的 C 函式 print_dec

# --- Text Section ---
.text
.globl run_q2_game_hanoi
run_q2_game_hanoi:
    # 1. PROLOGUE (已擴展)
    # 分配 64 bytes (16-byte aligned) 以儲存:
    # s0-s4 (x8, x9, x18, x19, x20)  (5 regs * 4B = 20B)
    # ra (x1)                       (1 reg  * 4B = 4B)
    # s5-s9 (x21-x25)               (5 regs * 4B = 20B)
    # disk array                    (3 regs * 4B = 12B)
    # Total = 20 + 4 + 20 + 12 = 56B. 對齊 16B，分配 64B.
    addi    x2, x2, -64
    sw      x8, 0(x2)       # s0 (loop_count)
    sw      x9, 4(x2)       # s1 (disk_id)
    sw      x18, 8(x2)      # s2 (from_peg)
    sw      x19, 12(x2)     # s3 (to_peg)
    sw      x20, 16(x2)     # s4 (disk_array_base)
    sw      x1, 20(x2)      # ra (因為我們會 jal print_dec)
    sw      x21, 24(x2)     # s5 (ptr: str1)
    sw      x22, 28(x2)     # s6 (ptr: str2)
    sw      x23, 32(x2)     # s7 (ptr: str3)
    sw      x24, 36(x2)     # s8 (ptr: str_nl)
    sw      x25, 40(x2)     # s9 (ptr: peg_names)
    
    # 圓盤位置陣列的基底將位於 48(x2)

    # 【優化 2】: 迴圈不變程式碼外提
    la      x21, str1
    la      x22, str2
    la      x23, str3
    la      x24, str_nl
    la      x25, peg_names  # 【優化 1】

    # 設定 s4 (x20) 為圓盤陣列的基底位址
    addi    x20, x2, 48

    # ... (Disk position initialization) ...
    sw      x0, 0(x20)      # Disk 0 position
    sw      x0, 4(x20)      # Disk 1 position
    sw      x0, 8(x20)      # Disk 2 position

    addi    x8, x0, 1
game_loop:
    addi    x5, x0, 8
    beq     x8, x5, finish_game

    # --- (Gray code and move logic) ---
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
    # 【優化 3】: 移除了 4 條多餘的指令
    
    slli    x5, x9, 2
    add     x5, x20, x5
    lw      x18, 0(x5)      # x18 = 來源柱 (0, 1, 2)
    bne     x9, x0, handle_large
    
    # Disk 0 logic
    addi    x19, x18, 2
    addi    x6, x0, 3
    blt     x19, x6, display_move
    sub     x19, x19, x6
    jal     x0, display_move

handle_large:
    # Disk 1/2 logic
    lw      x6, 0(x20)
    addi    x19, x0, 3
    sub     x19, x19, x18
    sub     x19, x19, x6    # x19 = 目標柱 (0, 1, 2)
    # 執行緒會自動往下掉到 display_move

display_move:
    # --- 2. DISPLAY SECTION (Optimized) ---
    # 1. 印出 "Move Disk "
    add     a7, x0, 0x40
    add     a0, x0, 1
    mv      a1, x21             # 【優化 2】: 使用 s5
    addi    a2, x0, 11
    ecall

    # 2. 印出圓盤編號 (呼叫 C 函式)
    addi    a0, x9, 1
    jal     ra, print_dec

    # 3. 印出 " from "
    add     a7, x0, 0x40
    add     a0, x0, 1
    mv      a1, x22             # 【優化 2】: 使用 s6
    addi    a2, x0, 6
    ecall

    # 4. 印出 'from' 柱 (A/B/C)
    # 【優化 4】: 直接使用 peg_names 位址, 不再複製到堆疊
    add     a1, x25, x18        # a1 = peg_names + from_index
    add     a7, x0, 0x40
    add     a0, x0, 1
    addi    a2, x0, 1           # a2 = length (1)
    ecall

    # 5. 印出 " to "
    add     a7, x0, 0x40
    add     a0, x0, 1
    mv      a1, x23             # 【優化 2】: 使用 s7
    addi    a2, x0, 4
    ecall

    # 6. 印出 'to' 柱 (A/B/C)
    # 【優化 4】: 直接使用 peg_names 位址, 不再複製到堆疊
    add     a1, x25, x19        # a1 = peg_names + to_index
    add     a7, x0, 0x40
    add     a0, x0, 1
    addi    a2, x0, 1           # a2 = length (1)
    ecall

    # 7. 印出換行符 '\n'
    add     a7, x0, 0x40
    add     a0, x0, 1
    mv      a1, x24             # 【優化 2】: 使用 s8
    addi    a2, x0, 1
    ecall
    
    # --- (State update logic) ---
    slli    x5, x9, 2
    add     x5, x20, x5
    sw      x19, 0(x5)      # 更新圓盤位置
    
    addi    x8, x8, 1
    jal     x0, game_loop

# --- 3. FINISH SECTION (Epilogue) ---
finish_game:
    # 恢復所有暫存器
    lw      x8, 0(x2)
    lw      x9, 4(x2)
    lw      x18, 8(x2)
    lw      x19, 12(x2)
    lw      x20, 16(x2)
    lw      x1, 20(x2)      # 恢復 ra
    lw      x21, 24(x2)     # 恢復 s5
    lw      x22, 28(x2)     # 恢復 s6
    lw      x23, 32(x2)     # 恢復 s7
    lw      x24, 36(x2)     # 恢復 s8
    lw      x25, 40(x2)     # 恢復 s9
    
    # 釋放堆疊
    addi    x2, x2, 64
    
    ret

.data
# 【優化 1】: 移除 obdata, 使用直接查詢表
peg_names:  .asciz  "ABC"
str1:       .asciz  "Move Disk "    # length 11
str2:       .asciz  " from "        # length 6
str3:       .asciz  " to "          # length 4
str_nl:     .byte   10              # Newline (ASCII 10) 