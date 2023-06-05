const assert = require("assert");
const nonConstructibleChange = require("sampletestfiles/js/non-constructible-change.js");

describe("nonConstructibleChange", () => {
  // Test case 1: Empty array
  it("should return 1 when no coins provided", () => {
    assert.strictEqual(nonConstructibleChange([]), 1);
  });

  // Test case 2: Array containing a single coin
  it("should return 2 when only 1 coin provided", () => {
    assert.strictEqual(nonConstructibleChange([1]), 2);
  });

  // Test case 3: Array containing multiple coins that can construct all possible changes
  it("should return correct summation when all possible changes can be constructed", () => {
    assert.strictEqual(nonConstructibleChange([1, 2, 3, 4, 5]), 16);
  });

  // Test case 4: Array containing random coins that cannot construct a specific change
  it("should return the smallest non-constructible change", () => {
    assert.strictEqual(nonConstructibleChange([5, 7, 1, 1, 2, 3, 22]), 20);
  });

  // Test case 5: Array containing corner case
  it("should return proper output on corner case", () => {
    assert.strictEqual(nonConstructibleChange([1, 1, 1, 1, 1]), 6);
  });
});