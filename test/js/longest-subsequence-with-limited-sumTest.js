const assert = require("assert");

describe("answerQueries", function () {
  // Test case 1
  it("should return [3, 1] for nums = [1, 2, 3, 4, 5], queries = [7, 3]", function () {
    const nums = [1, 2, 3, 4, 5];
    const queries = [7, 3];
    const expectedResult = [3, 1];
    assert.deepStrictEqual(answerQueries(nums, queries), expectedResult);
  });

  // Test case 2
  it("should return [6, 4, 1] for nums = [5, 4, 9, 3, 1, 7], queries = [15, 10, 5]", function () {
    const nums = [5, 4, 9, 3, 1, 7];
    const queries = [15, 10, 5];
    const expectedResult = [6, 4, 1];
    assert.deepStrictEqual(answerQueries(nums, queries), expectedResult);
  });

  // Test case 3
  it("should return [0] for nums = [10, 20, 30], queries = [5]", function () {
    const nums = [10, 20, 30];
    const queries = [5];
    const expectedResult = [0];
    assert.deepStrictEqual(answerQueries(nums, queries), expectedResult);
  });

  // Test case 4
  it("should return [5, 0, 3] for nums = [1, 5, 7, 3, 6], queries = [14, 1, 9]", function () {
    const nums = [1, 5, 7, 3, 6];
    const queries = [14, 1, 9];
    const expectedResult = [5, 0, 3];
    assert.deepStrictEqual(answerQueries(nums, queries), expectedResult);
  });

  // Test case 5
  it("should return [4, 3, 2, 1, 0] for nums = [2, 1, 3, 4, 5], queries = [12, 9, 5, 4, 2]", function () {
    const nums = [2, 1, 3, 4, 5];
    const queries = [12, 9, 5, 4, 2];
    const expectedResult = [4, 3, 2, 1, 0];
    assert.deepStrictEqual(answerQueries(nums, queries), expectedResult);
  });
});

describe("binarySearch", function () {
  // Test case 1
  it("should return 4 for target = 11 and nums = [1, 3, 6, 10, 15]", function () {
    const nums = [1, 3, 6, 10, 15];
    const target = 11;
    const expectedResult = 4;
    assert.strictEqual(binarySearch(target, nums), expectedResult);
  });

  // Test case 2
  it("should return 0 for target = 1 and nums = [1, 3, 6, 10, 15]", function () {
    const nums = [1, 3, 6, 10, 15];
    const target = 1;
    const expectedResult = 0;
    assert.strictEqual(binarySearch(target, nums), expectedResult);
  });

  // Test case 3
  it("should return 5 for target = 16 and nums = [1, 3, 6, 10, 15]", function () {
    const nums = [1, 3, 6, 10, 15];
    const target = 16;
    const expectedResult = 5;
    assert.strictEqual(binarySearch(target, nums), expectedResult);
  });

  // Test case 4
  it("should return 2 for target = 6 and nums = [1, 3, 6, 10, 15]", function () {
    const nums = [1, 3, 6, 10, 15];
    const target = 6;
    const expectedResult = 2;
    assert.strictEqual(binarySearch(target, nums), expectedResult);
  });

  // Test case 5
  it("should return 3 for target = 10 and nums = [1, 3, 6, 10, 15]", function () {
    const nums = [1, 3, 6, 10, 15];
    const target = 10;
    const expectedResult = 3;
    assert.strictEqual(binarySearch(target, nums), expectedResult);
  });
});