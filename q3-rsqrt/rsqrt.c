#include <stdint.h>
/*
 * Newton iteration: new_y = y * (3/2 - x * y^2 / 2)
 * Here, y is a Q0.32 fixed-point number (< 1.0)
 */
static void newton_step(uint32_t *rec_inv_sqrt, uint32_t x)
{
    uint32_t invsqrt, invsqrt2;
    uint64_t val;

    invsqrt = *rec_inv_sqrt;  /* Dereference pointer */
    invsqrt2 = ((uint64_t)invsqrt * invsqrt) >> 32;
    val = (3LL << 32) - ((uint64_t)x * invsqrt2);

    val >>= 2; /* Avoid overflow in following multiply */
    val = (val * invsqrt) >> 31;  /* Right shift by 31 = (32 - 2 + 1) */

    *rec_inv_sqrt = (uint32_t)val;
}


#define REC_INV_SQRT_CACHE (16)
static const uint32_t inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
    ~0U,        ~0U, 3037000500, 2479700525,
    2147483647, 1920767767, 1753413056, 1623345051,
    1518500250, 1431655765, 1358187914, 1294981364,
    1239850263, 1191209601, 1147878294, 1108955788
};
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
static int clz(uint32_t x) {
    if (!x) return 32; /* Special case: no bits set */
    int n = 0;
    if (!(x & 0xFFFF0000)) { n += 16; x <<= 16; }
    if (!(x & 0xFF000000)) { n += 8; x <<= 8; }
    if (!(x & 0xF0000000)) { n += 4; x <<= 4; }
    if (!(x & 0xC0000000)) { n += 2; x <<= 2; }
    if (!(x & 0x80000000)) { n += 1; }
    return n;
}


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

    // Step 2: Linear interpolation for non-power-of-2 inputs
    if (x > (1u << exp)) {
        uint32_t y_next = (exp < 31) ? rsqrt_table[exp + 1] : 0; // Next estimate
        uint32_t delta = y - y_next; // Difference between estimates
        uint32_t frac =(uint32_t) ((((uint64_t)x - (1UL << exp)) << 16) >> exp);
        y -= (uint32_t) ((delta * frac) >> 16); // Interpolate
    }
    
    for (int iter = 0; iter < 2; iter++) {
        uint32_t y2 = (uint32_t)mul32(y, y); // y^2 in Q0.32
        uint32_t xy2 = (uint32_t)(mul32(x, y2) >> 16); // x * y^2 in Q0.32
        y = (uint32_t)(mul32(y, (3u << 16) - xy2) >> 17); // Newton step
    }

    return y;
}