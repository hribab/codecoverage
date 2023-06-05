// Import the function to be tested
const subarraysDivByK = require("sampletestfiles/js/974-subarray-sums-divisible-by-k.js");

// Test Suite
describe("subarraysDivByK", () => {
  // Test case 1: normal input
  it("returns correct count of subarrays", () => {
    expect(subarraysDivByK([4, 5, 0, -2, -3, 1], 5)).toBe(7);
  });

  // Test case 2: all numbers divisible by k
  it("returns count of subarrays with all numbers divisible by k", () => {
    expect(subarraysDivByK([5, 10, 15, 20], 5)).toBe(10);
  });

  // Test case 3: all zeros
  it("returns count of subarrays when all elements are zeros", () => {
    expect(subarraysDivByK([0, 0, 0, 0, 0], 2)).toBe(15);
  });

  // Test case 4: negative numbers in nums
  it("returns correct count of subarrays with negative numbers", () => {
    expect(subarraysDivByK([2, -2, 2, -4], 6)).toBe(2);
  });

  // Test case 5: single element array
  it("returns count of subarrays for a single element array", () => {
    expect(subarraysDivByK([4], 2)).toBe(0);
  });
});