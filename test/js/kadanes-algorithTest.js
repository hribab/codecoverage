const assert = require("assert");

function kadanesAlgorithm(array) {
  let maxEndingHere = array[0];
  let maxSoFar = array[0];

  for (let i = 1; i < array.length; i++) {
    const num = array[i];
    maxEndingHere = Math.max(num, maxEndingHere + num);
    maxSoFar = Math.max(maxSoFar, maxEndingHere);
  }
  return maxSoFar;
}

describe("kadanesAlgorithm", () => {
  // Test case 1: Positive numbers only
  it("should return the correct maximum subarray sum with positive numbers only", () => {
    const array = [3, 5, 9, 1, 3, 2, 3, 4, 7, 2, 9, 6, 3, 1, 5, 4];
    assert.equal(kadanesAlgorithm(array), 60);
  });

  // Test case 2: Negative numbers only
  it("should return the correct maximum subarray sum with negative numbers only", () => {
    const array = [-3, -5, -9, -1, -3, -2, -3, -4, -7, -2, -9, -6, -3, -1, -5, -4];
    assert.equal(kadanesAlgorithm(array), -1);
  });

  // Test case 3: Positive and negative numbers mixed
  it("should return the correct maximum subarray sum with both positive and negative numbers", () => {
    const array = [3, 5, -9, 1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 4];
    assert.equal(kadanesAlgorithm(array), 19);
  });

  // Test case 4: Array with only one element
  it("should return the correct maximum subarray sum for an array with one element", () => {
    const array = [5];
    assert.equal(kadanesAlgorithm(array), 5);
  });

  // Test case 5: Array with all elements the same
  it("should return the correct maximum subarray sum for an array with all elements the same", () => {
    const array = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3];
    assert.equal(kadanesAlgorithm(array), 30);
  });
});