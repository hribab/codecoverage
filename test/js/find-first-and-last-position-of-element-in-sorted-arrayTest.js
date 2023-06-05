const assert = require("assert");

describe("searchRange", function () {
  // Test case 1: Normal usage, target exists
  it("should return [1, 4] when searching target 3 in [1, 3, 3, 3, 3, 4, 5]", function () {
    const nums = [1, 3, 3, 3, 3, 4, 5];
    const target = 3;
    assert.deepStrictEqual(searchRange(nums, target), [1, 4]);
  });

  // Test case 2: Normal usage, target not found
  it("should return [-1, -1] when searching target 6 in [1, 3, 3, 3, 3, 4, 5]", function () {
    const nums = [1, 3, 3, 3, 3, 4, 5];
    const target = 6;
    assert.deepStrictEqual(searchRange(nums, target), [-1, -1]);
  });

  // Test case 3: Normal usage, target at the edge
  it("should return [0, 2] when searching target 1 in [1, 1, 1, 3, 4, 5]", function () {
    const nums = [1, 1, 1, 3, 4, 5];
    const target = 1;
    assert.deepStrictEqual(searchRange(nums, target), [0, 2]);
  });

  // Test case 4: Empty array
  it("should return [-1, -1] when searching target 3 in an empty array", function () {
    assert.deepStrictEqual(searchRange([], 3), [-1, -1]);
  });

  // Test case 5: Array with single item, target found
  it("should return [0, 0] when searching target 3 in [3]", function () {
    assert.deepStrictEqual(searchRange([3], 3), [0, 0]);
  });

});

describe("getStartingAndEnding", function () {
  // Test case 1: Target is in the middle
  it("should return [3, 6] for nums=[1, 2, 2, 3, 3, 3, 3, 4, 5] and target=3", function () {
    const nums = [1, 2, 2, 3, 3, 3, 3, 4, 5];
    const target = 3;
    assert.deepStrictEqual(getStartingAndEnding(4, nums, target), [3, 6]);
  });

  // Test case 2: Target is at the edge
  it("should return [0, 3] for nums=[1, 1, 1, 1, 2, 2] and target=1", function () {
    const nums = [1, 1, 1, 1, 2, 2];
    const target = 1;
    assert.deepStrictEqual(getStartingAndEnding(2, nums, target), [0, 3]);
  });

  // Test case 3: Target has 1 occurrence
  it("should return [2, 2] for nums=[1, 2, 3, 4, 5] and target=3", function () {
    const nums = [1, 2, 3, 4, 5];
    const target = 3;
    assert.deepStrictEqual(getStartingAndEnding(2, nums, target), [2, 2]);
  });

  // Test case 4: Target is at the end
  it("should return [5, 7] for nums=[0, 1, 2, 3, 5, 6, 6, 6] and target=6", function () {
    const nums = [0, 1, 2, 3, 5, 6, 6, 6];
    const target = 6;
    assert.deepStrictEqual(getStartingAndEnding(5, nums, target), [5, 7]);
  });

  // Test case 5: Target has 2 occurrences
  it("should return [6, 7] for nums=[1, 1, 2, 3, 5, 6, 6] and target=6", function () {
    const nums = [1, 1, 2, 3, 5, 6, 6];
    const target = 6;
    assert.deepStrictEqual(getStartingAndEnding(5, nums, target), [6, 7]);
  });
});