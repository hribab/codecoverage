// Import the minRewards function from the original JavaScript file
const { minRewards } = require("./sampletestfiles/js/min-rewards.js");

// Test suite for the minRewards function
describe("minRewards", () => {
  // Test case: when the sequence is strictly decreasing
  test("should return correct rewards for decreasing sequence", () => {
    const scores = [9, 8, 7, 6, 5, 4, 3, 2, 1];
    const result = minRewards(scores);
    expect(result).toEqual(45);
  });

  // Test case: when the sequence is strictly increasing
  test("should return correct rewards for increasing sequence", () => {
    const scores = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    const result = minRewards(scores);
    expect(result).toEqual(45);
  });

  // Test case: when the sequence has a repeated value
  test("should return correct rewards for sequence with repeated value", () => {
    const scores = [2, 1, 1, 3, 7, 7, 2];
    const result = minRewards(scores);
    expect(result).toEqual(11);
  });

  // Test case: when the sequence has both increasing and decreasing trends
  test("should return correct rewards for mixed sequence", () => {
    const scores = [8, 4, 2, 1, 3, 6, 7, 9, 5];
    const result = minRewards(scores);
    expect(result).toEqual(25);
  });

  // Test case: when the sequence has all equal values
  test("should return correct rewards for all equal sequence", () => {
    const scores = [3, 3, 3, 3, 3];
    const result = minRewards(scores);
    expect(result).toEqual(5);
  });
});