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

#define TEST_OUTPUT(msg, length) printstr(msg, length)

#define TEST_LOGGER(msg)                     \
    {                                        \
        char _msg[] = msg;                   \
        TEST_OUTPUT(_msg, sizeof(_msg) - 1); \
    }

extern uint64_t get_cycles(void);
extern uint64_t get_instret(void);


/* Bare metal strlen implementation */
size_t strlen(const char *s)
{
    size_t count = 0;
    while (*s != '\0') {
        count++;
        s++;
    }
    return count;
}

// Helper union to split 64-bit values into two 32-bit parts
// (RISC-V is typically little-endian)
typedef union {
    uint64_t u64;
    struct {
        uint32_t lo;
        uint32_t hi;
    } s;
} val64;

/**
 * @brief 64-bit Logical Shift Right (libgcc intrinsic)
 */
uint64_t __lshrdi3(uint64_t u, int b) {
    val64 v;
    v.u64 = u;
    const uint32_t shift = (uint32_t)b;

    if (shift == 0)
        return u;

    if (shift >= 64) {
        v.s.lo = 0;
        v.s.hi = 0;
        return v.u64;
    }
    
    // If shift amount is >= 32, hi part moves to lo part
    if (shift >= 32) {
        v.s.lo = v.s.hi >> (shift - 32);
        v.s.hi = 0;
    } else {
        // Otherwise, high bits of lo are filled by low bits of hi
        v.s.lo = (v.s.lo >> shift) | (v.s.hi << (32 - shift));
        v.s.hi = v.s.hi >> shift;
    }
    
    return v.u64;
}

/**
 * @brief 64-bit Arithmetic Shift Left (libgcc intrinsic)
 * (For unsigned integers, arithmetic left shift is the same as logical)
 */
uint64_t __ashldi3(uint64_t u, int b) {
    val64 v;
    v.u64 = u;
    const uint32_t shift = (uint32_t)b;

    if (shift == 0)
        return u;
    
    if (shift >= 64) {
        v.s.lo = 0;
        v.s.hi = 0;
        return v.u64;
    }

    // If shift amount is >= 32, lo part moves to hi part
    if (shift >= 32) {
        v.s.hi = v.s.lo << (shift - 32);
        v.s.lo = 0;
    } else {
        // Otherwise, low bits of hi are filled by high bits of lo
        v.s.hi = (v.s.hi << shift) | (v.s.lo >> (32 - shift));
        v.s.lo = v.s.lo << shift;
    }
    
    return v.u64;
}

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

/* Count leading zeros using binary search
 * Algorithm: Binary search from MSB to LSB in 5 steps
 * Example: x = 0x00001234 (binary: ...0001 0010 0011 0100)
 * Step 1: Top 16 bits = 0, so n += 16, shift left 16
 * Step 2: Top 8 bits now have bits, continue
 * ...
 * Result: 19 leading zeros
 *
 * Returns: Number of leading zeros bits (0-32)
 * - clz(0) = 32 (special case)
 * - clz(1) = 31 (MSB at position 0)
 * - clz(0x80000000) = 0 (MSB at position 31)
 */

// implement in compute.S assembler version
extern int clz(uint32_t x);
// static int clz(uint32_t x) {
//     if (!x) return 32; /* Special case: no bits set */
//     int n = 0;
//     if (!(x & 0xFFFF0000)) { n += 16; x <<= 16; }
//     if (!(x & 0xFF000000)) { n += 8; x <<= 8; }
//     if (!(x & 0xF0000000)) { n += 4; x <<= 4; }
//     if (!(x & 0xC0000000)) { n += 2; x <<= 2; }
//     if (!(x & 0x80000000)) { n += 1; }
//     return n;
// }


/* Implement 32x32 -> 64-bit multiplication without hardware MUL instruction
 * Algorithm: For each set bit i in multiplier b, add (a << i) to result
 *
 * Example: 5 * 3
 * Binary: 5 = 101, 3 = 11
 * 3 has bits set at positions 0 and 1
 * Result = (5 << 0) + (5 << 1) = 5 + 10 = 15
 *
 * Hint: Use a loop from i=0 to i=31, check if bit i is set in b,
 * then add (a << i) to the result.
 */
static uint64_t mul32(uint32_t a, uint32_t b) {
    uint64_t r = 0;
    for (int i = 0; i < 32; i++) {
        if (b & ( 1U << i ))
            r += (uint64_t)a << i ;
    }
    return r;
}

/* Software 64-bit by 32-bit division */
static uint64_t udiv64_32(uint64_t dividend, uint32_t divisor_u32)
{
    if (divisor_u32 == 0)
        return 0;

    uint64_t quotient = 0;
    uint64_t remainder = 0;
    uint64_t divisor = (uint64_t)divisor_u32; // promote to 64-bit

    for (int i = 63; i >= 0; i--) {
        remainder <<= 1;
        remainder |= (dividend >> i) & 1;

        if (remainder >= divisor) {
            remainder -= divisor;
            quotient |= (1ULL << i); // 1ULL is 64-bit 1
        }
    }

    return quotient;
}

/* Lookup table: initial estimates for 65536 / sqrt(2^n)
 * Provides starting approximations indexed by MSB position
 * Usage:
 * For input x, find MSB position exp = 31 - clz(x)
 * Initial estimate: y = rsqrt_table[exp]
 * Examples:
 * x = 1 (2^0)  -> exp = 0  -> y = 65536 (exact: 65536/sqrt(1))
 * x = 16 (2^4) -> exp = 4  -> y = 16384 (exact: 65536/sqrt(16))
 * x = 1024     -> exp = 10 -> y = 2048 (exact: 65536/sqrt(1024))
 *
 * Each entry computed as: round(65536 / sqrt(2^n))
 */
static const uint16_t rsqrt_table[32] = {
        65535, 46341, 32768, 23170, 16384,  /* 2^0 to 2^4 */
        11585, 8192,  5793,  4096,  2896,   /* 2^5 to 2^9 */
        2048,  1448,  1024,  724,   512,    /* 2^10 to 2^14 */
        362,   256,   181,   128,   90,     /* 2^15 to 2^19 */
        64,    45,    32,    23,    16,     /* 2^20 to 2^24 */
        11,    8,     6,     4,     3,      /* 2^25 to 2^ 29 */
        2,     1                            /* 2^3O, 2^3l */
} ;

/* Fast reciprocal square root: 65536 / sqrt(x)
* Computes approximation of 1/sqrt(x) scaled by 2"16.
* I nput : x - any uint32_t value
* Output: y:::: 65536 / sqrt(x), with 3-8% relative error
*
* Edge Cases:
* X = 0 ➔ 0xFFFFFFFF (represents infinity)
* X = 1 ➔ 65536 (exact)
* X = 2^n ➔ accurate (0-2% error)
* X = MAX_U32 ➔ 1 (minimum non-zero result)
* Algorithm Overview:
* 1. LUT lookup: ~20% error
* 2 . + Interpolation: ~10% error
* 3 . + 2 Newton: ~3 - 8% error
*/
uint32_t fast_rsqrt(uint32_t x)
{
    if (x == 0) return 0xFFFFFFFF; // Handle zero case
    if (x == 1) return 65536; // Handle exact case for 1

    // Step 1: Find MSB position
    int exp = 31 - clz(x); // Count leading zeros
    uint32_t y = rsqrt_table[exp]; // Initial estimate

    if (x > (1u << exp)) {
    // Step 2: Linear interpolation for non-power-of-2 inputs
        uint32_t y_next = (exp < 31) ? rsqrt_table[exp + 1] : 0; // Next estimate
        uint32_t delta = y - y_next; // Difference between estimates
        uint32_t frac =(uint32_t) ((((uint64_t)x - (1UL << exp)) << 16) >> exp);
        y -= (uint32_t) ((delta * frac) >> 16); // Interpolate
    // Step 3: Newton-Raphson iterations
        for (int iter = 0; iter < 2; iter++) {
            uint32_t y2 = (uint32_t)mul32(y, y); // y^2 in Q0.32
            uint32_t xy2 = (uint32_t)(mul32(x, y2) >> 16); // x * y^2 in Q16.16
            y = (uint32_t)(mul32(y, (3u << 16) - xy2) >> 17); // Newton step
        }
    }

    return y;
}


/* Computes approximation of 65536 / sqrt(x) using fixed-point arithmetic.
 * Algorithm:
 *
 * 1. Lookup table provides initial estimate based on MSB position
 * 2. Linear interpolation refines estimate for non-power-of-2 inputs
 * 3. Two Newton-Raphson iterations improve precision to 3-8% error
 *
 * Expected outputs:
 * fast_rsqrt(1) = 65536 (exact)
 * fast_rsqrt(4) = 32768 (exact: 32768)
 * fast_rsqrt(16) = 16384 (exact: 16384)
 * fast_rsqrt(100) = 6554 (exact: 6553.6)
 */

/* --- Automated Test Helper Functions (Start) --- */

/**
 * @brief Check if two values are exactly equal
 * @param test_name Name of the test case
 * @param actual    Actual value computed by the function
 * @param expected  Expected exact value
 * @param cycles    Cycles taken to compute 'actual'
 * @param all_passed Pointer to the overall pass status (set to 0 if failed)
 */
static void check_exact(const char* test_name, uint32_t actual, uint32_t expected, uint64_t cycles, int* all_passed) {
    if (actual == expected) {
        TEST_LOGGER("    [PASS] ");
    } else {
        TEST_LOGGER("    [FAIL] ");
    }
    
    /* --- New Code (Fixing .rodata reading issue) --- */
    char name_buf[64]; // Create a 64-byte buffer on the stack
    const char* s = test_name;
    size_t len = 0;
    // Manually copy string from .rodata (test_name) to stack (name_buf)
    // Assume test_name does not exceed 63 characters
    while (*s != '\0' && len < 63) {
        name_buf[len] = *s;
        s++;
        len++;
    }
    // Now 'name_buf' is on the stack, 'len' is its length
    TEST_OUTPUT(name_buf, len);
    /* --- Copy End --- */

    if (actual == expected) {
        TEST_LOGGER(" | Cycles: ");
        print_dec((unsigned long)cycles);
        TEST_LOGGER("\n");
    } else {
        TEST_LOGGER(": Expected ");
        print_dec(expected);
        TEST_LOGGER(", Got ");
        print_dec(actual);
        TEST_LOGGER(" | Cycles: ");
        print_dec((unsigned long)cycles);
        TEST_LOGGER("\n");
        *all_passed = 0;
    }
}

/**
 * @brief Check if a value is within a specific percentage error margin of the expected value
 * @param test_name Name of the test case
 * @param actual    Actual value computed by the function
 * @param expected  Reference expected value
 * @param margin_percent Allowed error percentage (e.g., 10 means 10%)
 * @param cycles    Cycles taken to compute 'actual'
 * @param all_passed Pointer to the overall pass status (set to 0 if failed)
 */
static void check_approx(const char* test_name, uint32_t actual, uint32_t expected, uint32_t margin_percent, uint64_t cycles, int* all_passed) {
    /* --- 1. Calculate diff and margin --- */
    // Calculate absolute difference
    uint32_t diff = (actual > expected) ? (actual - expected) : (expected - actual);
    
    // Use 64-bit to avoid overflow when calculating error margin
    uint64_t product = mul32(expected, margin_percent); // 32x32 -> 64
    uint64_t margin = udiv64_32(product, 100);       // 64 / 32 -> 64

    // For cases where expected value is small (e.g., 1), add a minimum absolute error tolerance.
    if (margin == 0) {
        margin = 2; // Allow at least 2 absolute error
    }
    /* --- Calculation End --- */


    /* --- 2. Check and Print Results --- */
    if ((uint64_t)diff <= margin) {
        TEST_LOGGER("    [PASS] ");
        
        /* --- Copy test_name to stack (Fixing .rodata reading issue) --- */
        char name_buf[64];
        const char* s = test_name;
        size_t len = 0;
        while (*s != '\0' && len < 63) {
            name_buf[len] = *s;
            s++;
            len++;
        }
        TEST_OUTPUT(name_buf, len); // Print from stack
        
        TEST_LOGGER(" (Got: ");
        print_dec(actual);
        TEST_LOGGER(") | Cycles: ");
        print_dec((unsigned long)cycles);
        TEST_LOGGER("\n");
    } else {
        TEST_LOGGER("    [FAIL] ");
        
        /* --- Copy test_name to stack (Fixing .rodata reading issue) --- */
        char name_buf[64];
        const char* s = test_name;
        size_t len = 0;
        while (*s != '\0' && len < 63) {
            name_buf[len] = *s;
            s++;
            len++;
        }
        TEST_OUTPUT(name_buf, len); // Print from stack
        
        TEST_LOGGER(": Expected ~");
        print_dec(expected);
        TEST_LOGGER(", Got ");
        print_dec(actual);
        TEST_LOGGER(" (Diff: ");
        print_dec(diff);
        TEST_LOGGER(", Allowed Margin: ");
        print_dec((uint32_t)margin);
        TEST_LOGGER(") | Cycles: ");
        print_dec((unsigned long)cycles);
        TEST_LOGGER("\n");
        *all_passed = 0;
    }
}


/**
 * @brief Run the fast_rsqrt automated test suite
 * @return 1 if all tests passed, 0 if any test failed
 */
int run_q3_rsqrt() {
    int all_passed = 1; // Assume all passed until failure
    uint64_t t_start, t_end, t_diff;
    uint32_t result;

    TEST_LOGGER("  Running fast_rsqrt test suite...\n");
    
    // According to comments, error range is 3-8%. We use 10% as tolerance (margin_percent = 10).
    // Expected values are calculated based on (uint32_t)(65536.0 / sqrt(x)).

    // --- 1. Edge/Special Cases (Should be Exact) ---
    TEST_LOGGER("  Testing edge cases...\n");
    TEST_LOGGER("  -> Calling rsqrt(0)...\n");
    t_start = get_cycles();
    result = fast_rsqrt(0);
    t_end = get_cycles();
    check_exact("rsqrt(0)", result, 0xFFFFFFFF, t_end - t_start, &all_passed);
    
    TEST_LOGGER("  -> Calling rsqrt(1)...\n");
    t_start = get_cycles();
    result = fast_rsqrt(1);
    t_end = get_cycles();
    check_exact("rsqrt(1)", result, 65536, t_end - t_start, &all_passed);

    TEST_LOGGER("  -> Calling rsqrt(0xFFFFFFFF)...\n");
    t_start = get_cycles();
    result = fast_rsqrt(0xFFFFFFFF);
    t_end = get_cycles();
    check_exact("rsqrt(0xFFFFFFFF)", result, 1, t_end - t_start, &all_passed);

    // --- 2. Powers of 2 (From comments and table, should be exact) ---
    TEST_LOGGER("  Testing powers of 2...\n");
    
    t_start = get_cycles(); result = fast_rsqrt(4); t_end = get_cycles();
    check_exact("rsqrt(4)", result, 32768, t_end - t_start, &all_passed);
    
    t_start = get_cycles(); result = fast_rsqrt(16); t_end = get_cycles();
    check_exact("rsqrt(16)", result, 16384, t_end - t_start, &all_passed);
    
    t_start = get_cycles(); result = fast_rsqrt(1024); t_end = get_cycles();
    check_exact("rsqrt(1024)", result, 2048, t_end - t_start, &all_passed);
    
    t_start = get_cycles(); result = fast_rsqrt(65536); t_end = get_cycles();
    check_exact("rsqrt(65536)", result, 256, t_end - t_start, &all_passed); // 2^16
    
    t_start = get_cycles(); result = fast_rsqrt(1048576); t_end = get_cycles();
    check_exact("rsqrt(1048576)", result, 64, t_end - t_start, &all_passed); // 2^20

    // --- 3. General Cases (Using 10% Tolerance) ---
    TEST_LOGGER("  Testing general cases (10% tolerance)...\n");
    
    // Case from comments: rsqrt(100)
    t_start = get_cycles(); result = fast_rsqrt(100); t_end = get_cycles();
    check_approx("rsqrt(100)", result, 6554, 10, t_end - t_start, &all_passed); // Exact: 6553.6
    
    // Other test cases
    t_start = get_cycles(); result = fast_rsqrt(2); t_end = get_cycles();
    check_approx("rsqrt(2)", result, 46341, 10, t_end - t_start, &all_passed);     // Exact: 46340.9
    
    t_start = get_cycles(); result = fast_rsqrt(10); t_end = get_cycles();
    check_approx("rsqrt(10)", result, 20723, 10, t_end - t_start, &all_passed);   // Exact: 20723.0
    
    t_start = get_cycles(); result = fast_rsqrt(42); t_end = get_cycles();
    check_approx("rsqrt(42)", result, 10103, 10, t_end - t_start, &all_passed);   // Exact: 10103.4
    
    t_start = get_cycles(); result = fast_rsqrt(12345); t_end = get_cycles();
    check_approx("rsqrt(12345)", result, 590, 10, t_end - t_start, &all_passed); // Exact: 589.6
    
    t_start = get_cycles(); result = fast_rsqrt(1000000); t_end = get_cycles();
    check_approx("rsqrt(1000000)", result, 66, 10, t_end - t_start, &all_passed); // Exact: 65.53
    
    t_start = get_cycles(); result = fast_rsqrt(2000000000); t_end = get_cycles();
    check_approx("rsqrt(2000000000)", result, 1, 10, t_end - t_start, &all_passed); // Exact: 1.46

    return all_passed;
}

/* --- Automated Test Helper Functions (End) --- */


int main(void)
{
    uint64_t start_cycles, end_cycles, cycles_elapsed;
    uint64_t start_instret, end_instret, instret_elapsed;

    TEST_LOGGER("\n=== HW2 FastRsqrt Tests in Bare Metal ===\n\n");
    
    start_cycles = get_cycles();
    start_instret = get_instret();

    int passed = run_q3_rsqrt();

    end_cycles = get_cycles();
    end_instret = get_instret();
    cycles_elapsed = end_cycles - start_cycles;
    instret_elapsed = end_instret - start_instret;

    if (passed) {
        TEST_LOGGER("\n  q3-rsqrt Test Suite: PASSED\n");
    } else {
        TEST_LOGGER("\n  q3-rsqrt Test Suite: FAILED\n");
    }

    TEST_LOGGER("  Total Cycles: ");
    print_dec((unsigned long) cycles_elapsed);
    TEST_LOGGER("  Total Instructions: ");
    print_dec((unsigned long) instret_elapsed);
    TEST_LOGGER("\n");

    TEST_LOGGER("\n=== All Tests Completed ===\n");

    return 0;
}