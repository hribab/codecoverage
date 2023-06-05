// Import the function to be tested
const findKthPositive = require('../js/1539-kth-missing-positive-number.js');

// Start writing test cases
describe('findKthPositive function testing', () => {

  // Test case 1
  test('Positive test case with given array and k value', () => {
    const arr = [2, 3, 4, 7, 11];
    const k = 5;
    const expected_output = 9;
    expect(findKthPositive(arr, k)).toBe(expected_output);
  });

  // Test case 2
  test('Positive test case with the same number in the array multiple times', () => {
    const arr = [1, 1, 2, 4, 6];
    const k = 3;
    const expected_output = 5;
    expect(findKthPositive(arr, k)).toBe(expected_output);
  });

  // Test case 3
  test('Positive test case with k value larger than the array length', () => {
    const arr = [1, 2, 3, 4];
    const k = 8;
    const expected_output = 12;
    expect(findKthPositive(arr, k)).toBe(expected_output);
  });

  // Test case 4
  test('Positive test case with given array containing negative numbers', () => {
    const arr = [-2, -1, 3, 4, 5];
    const k = 4;
    const expected_output = 6;
    expect(findKthPositive(arr, k)).toBe(expected_output);
  });

  // Test case 5
  test('Positive test case with given array having non-sequential numbers', () => {
    const arr = [1, 3, 7, 15, 19];
    const k = 6;
    const expected_output = 10;
    expect(findKthPositive(arr, k)).toBe(expected_output);
  });

});