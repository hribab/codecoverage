// Import the necessary libraries
const assert = require("assert");

// Import the function for testing
const minimumAverageDifference = require("../js/minimum-average-difference.js");

// Test cases
describe("minimumAverageDifference", () => {
  // Test case 1: Simple case with a clear minimum average difference
  it("should return the index of the minimum average difference", () => {
    const nums = [1, 2, 3, 4, 5];
    const result = minimumAverageDifference(nums);
    assert.strictEqual(result, 2);
  });

  // Test case 2: Test with negative numbers
  it("should handle negative numbers", () => {
    const nums = [-5, -3, 0, 2, 4];
    const result = minimumAverageDifference(nums);
    assert.strictEqual(result, 2);
  });

  // Test case 3: Test with only one number in the array
  it("should return 0 if the array has only one number", () => {
    const nums = [3];
    const result = minimumAverageDifference(nums);
    assert.strictEqual(result, 0);
  });

  // Test case 4: Test when all numbers in the array are the same
  it("should return 0 if all numbers in the array are the same", () => {
    const nums = [2, 2, 2, 2, 2];
    const result = minimumAverageDifference(nums);
    assert.strictEqual(result, 0);
  });

  // Test case 5: Test with mixed positive and negative numbers
  it("should handle mixed positive and negative numbers", () => {
    const nums = [1, -3, 4, -1, 2];
    const result = minimumAverageDifference(nums);
    assert.strictEqual(result, 3);
  });
});