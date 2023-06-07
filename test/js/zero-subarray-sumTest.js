const zeroSumSubarray = require("../js/zero-subarray-sum.js");
const assert = require("assert");

describe("zeroSumSubarray", function() {
  // Test case 1: Array contains a zero sum subarray
  it("should return true for [2, -2]", function() {
    assert.equal(zeroSumSubarray([2, -2]), true);
  });

  // Test case 2: Array does not contain a zero sum subarray
  it("should return false for [3, 1, -1, 4]", function() {
    assert.equal(zeroSumSubarray([3, 1, -1, 4]), false);
  });

  // Test case 3: Array contains multiple zero sum subarrays
  it("should return true for [1, -2, 3, -3, 2]", function() {
    assert.equal(zeroSumSubarray([1, -2, 3, -3, 2]), true);
  });

  // Test case 4: Array has only negative numbers and does not contain a zero sum subarray
  it("should return false for [-1, -2, -3, -4]", function() {
    assert.equal(zeroSumSubarray([-1, -2, -3, -4]), false);
  });

  // Test case 5: Array has only positive numbers and does not contain a zero sum subarray
  it("should return false for [1, 2, 3, 4]", function() {
    assert.equal(zeroSumSubarray([1, 2, 3, 4]), false);
  });
});