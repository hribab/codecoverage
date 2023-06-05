// Import the removeDuplicates function from the code file
const removeDuplicates = require('sampletestfiles/js/remove-duplicates-from-sorted-array.js');

// Test cases for removeDuplicates function
describe('removeDuplicates', () => {
  // Test case 1: Check if it removes duplicates from array
  it('should remove duplicates from array', () => {
    const nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4];
    expect(removeDuplicates(nums)).toEqual([0, 1, 2, 3, 4]);
  });

  // Test case 2: Check if it works with an empty array
  it('should return an empty array when given an empty array', () => {
    const nums = [];
    expect(removeDuplicates(nums)).toEqual([]);
  });

  // Test case 3: Check if it works with an array with one value
  it('should return the same array when given an array with only one value', () => {
    const nums = [5];
    expect(removeDuplicates(nums)).toEqual([5]);
  });

  // Test case 4: Check if it works with an array with no duplicates
  it('should return the same array when given an array with no duplicates', () => {
    const nums = [1, 2, 3, 4, 5];
    expect(removeDuplicates(nums)).toEqual([1, 2, 3, 4, 5]);
  });

  // Test case 5: Check if it works with an array with negative numbers
  it('should remove duplicates from array with negative numbers', () => {
    const nums = [-2, -2, -1, -1, 0, 0, 1, 1];
    expect(removeDuplicates(nums)).toEqual([-2, -1, 0, 1]);
  });
});