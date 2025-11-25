#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#define printstr(ptr, length)                   \
do {                                        \
    asm volatile(                           \
            "add a7, x0, 0x40;"                 \
            "add a0, x0, 0x1;" /* stdout */     \
            "add a1, x0, %0;"                   \
            "mv a2, %1;" /* length character */ \
            "ecall;"                            \
            :                                   \
            : "r"(ptr), "r"(length)             \
            : "a0", "a1", "a2", "a7", "memory");          \
} while (0)
    // *DUMMY_IO_PORT = (uint32_t)ptr; /* 觸發 volatile 寫入 */ \
#define DUMMY_IO_PORT ((volatile uint32_t *)0xFFFFFFFC)
#define TEST_OUTPUT(msg, length) printstr(msg, length)
#define TEST_LOGGER(msg)                     \
    {                                        \
        char _msg[] = msg;                   \
        TEST_OUTPUT(_msg, sizeof(_msg) - 1); \
    }

extern uint64_t get_cycles(void);
extern uint64_t get_instret(void);

/* Bare metal memcpy implementation */
void *memcpy(void *dest, const void *src, size_t n)
{
    uint8_t *d = (uint8_t *) dest;
    const uint8_t *s = (const uint8_t *) src;
    while (n--)
        *d++ = *s++;
    return dest;
}

/* Software division for RV32I (no M extension) */
static unsigned long udiv(unsigned long dividend, unsigned long divisor)
{
    if (divisor == 0)
        return 0;

    unsigned long quotient = 0;
    unsigned long remainder = 0;

    for (int i = 31; i >= 0; i--) {
        remainder <<= 1;
        remainder |= (dividend >> i) & 1;

        if (remainder >= divisor) {
            remainder -= divisor;
            quotient |= (1UL << i);
        }
    }

    return quotient;
}

static unsigned long umod(unsigned long dividend, unsigned long divisor)
{
    if (divisor == 0)
        return 0;

    unsigned long remainder = 0;

    for (int i = 31; i >= 0; i--) {
        remainder <<= 1;
        remainder |= (dividend >> i) & 1;

        if (remainder >= divisor) {
            remainder -= divisor;
        }
    }

    return remainder;
}

/* Software multiplication for RV32I (no M extension) */
static uint32_t umul(uint32_t a, uint32_t b)
{
    uint32_t result = 0;
    while (b) {
        if (b & 1)
            result += a;
        a <<= 1;
        b >>= 1;
    }
    return result;
}

/* Provide __mulsi3 for GCC */
uint32_t __mulsi3(uint32_t a, uint32_t b)
{
    return umul(a, b);
}

/* Simple integer to hex string conversion */
static void print_hex(unsigned long val)
{
    char buf[20];
    char *p = buf + sizeof(buf) - 1;
    *p = '\n';
    p--;

    if (val == 0) {
        *p = '0';
        p--;
    } else {
        while (val > 0) {
            int digit = val & 0xf;
            *p = (digit < 10) ? ('0' + digit) : ('a' + digit - 10);
            p--;
            val >>= 4;
        }
    }

    p++;
    printstr(p, (buf + sizeof(buf) - p));
}

/* Simple integer to decimal string conversion */
// __attribute__((optimize("O0")))
void print_dec(unsigned long val)
{
    char buf[20];
    char *p = buf + sizeof(buf) - 1;
    // *p = '\n';
    // p--;

    if (val == 0) {
        *p = '0';
        p--;
    } else {
        while (val > 0) {
            *p = '0' + umod(val, 10);
            p--;
            val = udiv(val, 10);
        }
    }

    p++;
    printstr(p, (buf + sizeof(buf) - p));
}

/* * 宣告來自 q1-uf8.s 的函式。
 * 它會執行測試，並返回一個整數 (在 a0 暫存器中):
 * 1 = PASSED
 * 0 = FAILED
 */
extern int run_q1_uf8(void);

int main(void)
{
    uint64_t start_cycles, end_cycles, cycles_elapsed;
    uint64_t start_instret, end_instret, instret_elapsed;

    TEST_LOGGER("\n=== HW2 UF8 Tests (RISC-V Assembly) in Bare Metal ===\n\n");
    
    start_cycles = get_cycles();
    start_instret = get_instret();

    /* * 呼叫您在 q1-uf8.s 中修改過的函式
     * C 語言會自動從 a0 暫存器讀取返回值
     */
    int passed = run_q1_uf8();

    end_cycles = get_cycles();
    end_instret = get_instret();
    cycles_elapsed = end_cycles - start_cycles;
    instret_elapsed = end_instret - start_instret;

    /* * 檢查來自組合語言的返回值，並使用 "正確" 的裸機
     * 系統呼叫 (TEST_LOGGER) 來印出結果。
     */
    if (passed) {
        TEST_LOGGER("  q1-uf8 Test Suite: PASSED\n");
    } else {
        TEST_LOGGER("  q1-uf8 Test Suite: FAILED\n");
    }

    TEST_LOGGER("  Cycles: ");
    print_dec((unsigned long) cycles_elapsed);
    TEST_LOGGER("  Instructions: ");
    print_dec((unsigned long) instret_elapsed);
    TEST_LOGGER("\n");

    TEST_LOGGER("\n=== All Tests Completed ===\n");

    return 0;
}