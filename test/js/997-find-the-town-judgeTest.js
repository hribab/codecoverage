// Import the findJudge function for testing
const findJudge = require('../js/997-find-the-town-judge.js');

// Test cases
describe('findJudge', () => {

  // Test case 1: Normal case with a valid town judge
  test('should return the correct town judge when there is one', () => {
    const n = 3;
    const trust = [[1, 3], [2, 3]];
    const expected = 3;
    expect(findJudge(n, trust)).toBe(expected);
  });

  // Test case 2: Normal case with no town judge
  test('should return -1 when there is no town judge', () => {
    const n = 3;
    const trust = [[1, 2], [2, 3]];
    const expected = -1;
    expect(findJudge(n, trust)).toBe(expected);
  });

  // Test case 3: Case with n = 1 (Single person - the town judge)
  test('should return the single person as the town judge when n = 1', () => {
    const n = 1;
    const trust = [];
    const expected = 1;
    expect(findJudge(n, trust)).toBe(expected);
  });

  // Test case 4: Case with multiple trusts towards different people
  test('should return the town judge when there are multiple trusts towards different people', () => {
    const n = 4;
    const trust = [[1, 3], [1, 4], [2, 3], [2, 4], [4, 3]];
    const expected = 3;
    expect(findJudge(n, trust)).toBe(expected);
  });

  // Test case 5: Case with multiple trusts but no valid town judge
  test('should return -1 when there are multiple trusts but no valid town judge', () => {
    const n = 5;
    const trust = [[1, 3], [1, 5], [3, 4], [2, 5], [5, 4], [4, 2]];
    const expected = -1;
    expect(findJudge(n, trust)).toBe(expected);
  });
});