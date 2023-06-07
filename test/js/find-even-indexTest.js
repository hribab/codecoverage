const assert = require("assert");

// Test code for findEvenIndex function
describe("findEvenIndex", () => {
  // Test case 1: Test with a valid even index
  it("should return 3 when given an array with even index 3", () => {
    const arr = [1, 2, 3, 4, 3, 2, 1];
    const result = findEvenIndex(arr);
    assert.strictEqual(result, 3);
  });

  // Test case 2: Test with no valid even index
  it("should return -1 when there is no even index", () => {
    const arr = [1, 2, 3, 4, 5, 6, 7];
    const result = findEvenIndex(arr);
    assert.strictEqual(result, -1);
  });

  // Test case 3: Test with a valid even index at position 0
  it("should return 0 when the valid even index is located at position 0", () => {
    const arr = [0, 1, 2, 3, 4];
    const result = findEvenIndex(arr);
    assert.strictEqual(result, 0);
  });

  // Test case 4: Test with a valid even index at the last position
  it("should return 4 when the valid even index is located at the last position", () => {
    const arr = [1, 2, 3, 4, 0];
    const result = findEvenIndex(arr);
    assert.strictEqual(result, 4);
  });

  // Test case 5: Test with a large array
  it("should return 0 when given a large array with an even index at position 0", () => {
    const arr = [0, 3, 2, 7, 8, 4, 7, 3, 9];
    const result = findEvenIndex(arr);
    assert.strictEqual(result, 0);
  });
});