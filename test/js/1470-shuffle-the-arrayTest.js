const assert = require("assert");
const { shuffle } = require("../js/1470-shuffle-the-array.js");

describe("Test shuffle function", () => {
  // Test Case 1: Correct shuffling of an input with different numbers
  it("Should shuffle array [1, 2, 3, 4, 5, 6] with n = 3", () => {
    assert.deepEqual(shuffle([1, 2, 3, 4, 5, 6], 3), [1, 4, 2, 5, 3, 6]);
  });

  // Test Case 2: Correct shuffling of an input with same numbers
  it("Should shuffle array [3, 3, 3, 3, 3, 3] with n = 3", () => {
    assert.deepEqual(shuffle([3, 3, 3, 3, 3, 3], 3), [3, 3, 3, 3, 3, 3]);
  });

  // Test Case 3: Correct shuffling of an input with alternating numbers
  it("Should shuffle array [1, 2, 1, 2, 1, 2] with n = 3", () => {
    assert.deepEqual(shuffle([1, 2, 1, 2, 1, 2], 3), [1, 1, 2, 2, 1, 2]);
  });

  // Test Case 4: Correct shuffling of an input with only two numbers
  it("Should shuffle array [1, 1] with n = 1", () => {
    assert.deepEqual(shuffle([1, 1], 1), [1, 1]);
  });

  // Test Case 5: Correct shuffling of an input with negative numbers
  it("Should shuffle array [-1, -2, -3, -4, -5, -6] with n = 3", () => {
    assert.deepEqual(shuffle([-1, -2, -3, -4, -5, -6], 3), [-1, -4, -2, -5, -3, -6]);
  });
});