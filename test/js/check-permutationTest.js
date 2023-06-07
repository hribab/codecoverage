const checkPermutation = require("../js/check-permutation.js");
const assert = require("assert");

describe("checkPermutation", function() {
  // Test case 1: Valid permutations
  it("should return true for valid permutations", function() {
    const str1 = "dog";
    const str2 = "god";
    assert.strictEqual(checkPermutation(str1, str2), true);
  });

  // Test case 2: Invalid permutations with extra space
  it("should return false for invalid permutations with extra space", function() {
    const str1 = "edcba";
    const str2 = "abcde ";
    assert.strictEqual(checkPermutation(str1, str2), false);
  });

  // Test case 3: Empty strings
  it("should return true for empty strings", function() {
    const str1 = "";
    const str2 = "";
    assert.strictEqual(checkPermutation(str1, str2), true);
  });

  // Test case 4: Different character counts
  it("should return false for strings with different character counts", function() {
    const str1 = "abc";
    const str2 = "abcd";
    assert.strictEqual(checkPermutation(str1, str2), false);
  });

  // Test case 5: Case sensitivity
  it("should be case sensitive and return false for strings with same characters but different cases", function() {
    const str1 = "Abc";
    const str2 = "aBC";
    assert.strictEqual(checkPermutation(str1, str2), false);
  });
});