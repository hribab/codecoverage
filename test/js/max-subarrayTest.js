// Import the maxSubArray function
const { maxSubArray } = require("../js/max-subarray.js");
const assert = require("assert");

describe("maxSubArray", () => {
  // Test case 1: The function should return the maximum subarray sum
  it("should return the maximum subarray sum", () => {
    assert.strictEqual(maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]), 6);
  });

  // Test case 2: The function should return the correct sum even when there are negative numbers
  it("should return the correct sum even when there are negative numbers", () => {
    assert.strictEqual(maxSubArray([-2, 3, -1, 2, -3, 1, 2, -2]), 4);
  });

  // Test case 3: The function should return the correct sum when all numbers are negative
  it("should return the correct sum when all numbers are negative", () => {
    assert.strictEqual(maxSubArray([-5, -3, -1, -2, -4, -6]), -1);
  });

  // Test case 4: The function should return the correct sum when all numbers are positive
  it("should return the correct sum when all numbers are positive", () => {
    assert.strictEqual(maxSubArray([1, 2, 3, 4, 5, 6]), 21);
  });

  // Test case 5: The function should return the correct sum when there is only one element in the array
  it("should return the correct sum when there is only one element in the array", () => {
    assert.strictEqual(maxSubArray([5]), 5);
  });
});