const { smallestDifference } = require('./sampletestfiles/js/smallest-difference');

describe('smallestDifference', () => {

  // Test case 1: Both arrays have positive numbers
  it('should return an array with the numbers that have the smallest difference between two positive arrays', () => {
    const arrayOne = [34, 67, 12, 4];
    const arrayTwo = [9, 15, 39, 5];
    const expectedResult = [4, 5];
    expect(smallestDifference(arrayOne, arrayTwo)).toEqual(expectedResult);
  });

  // Test case 2: The first array has negative numbers
  it('should return an array with the numbers that have the smallest difference between one array with negative numbers and one positive array', () => {
    const arrayOne = [-1, 5, 10, 20, 28, 3];
    const arrayTwo = [26, 134, 135, 15, 17];
    const expectedResult = [28, 26];
    expect(smallestDifference(arrayOne, arrayTwo)).toEqual(expectedResult);
  });

  // Test case 3: The second array has negative numbers
  it('should return an array with the numbers that have the smallest difference between one array with positive numbers and one with negative numbers', () => {
    const arrayOne = [1, 8, 15];
    const arrayTwo = [-3, -6, 0];
    const expectedResult = [1, 0];
    expect(smallestDifference(arrayOne, arrayTwo)).toEqual(expectedResult);
  });

  // Test case 4: Both arrays have negative numbers
  it('should return an array with the numbers that have the smallest difference between two negative arrays', () => {
    const arrayOne = [-1, -5, -10, -20, -3];
    const arrayTwo = [-26, -134, -135, -15];
    const expectedResult = [-10, -15];
    expect(smallestDifference(arrayOne, arrayTwo)).toEqual(expectedResult);
  });

  // Test case 5: Both arrays have duplicate elements
  it('should handle duplicate elements in both arrays', () => {
    const arrayOne = [24, 2, 4, 39, 24];
    const arrayTwo = [9, 15, 39, 5, 24];
    const expectedResult = [24, 24];
    expect(smallestDifference(arrayOne, arrayTwo)).toEqual(expectedResult);
  });

});
