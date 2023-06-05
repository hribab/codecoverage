// Test cases for threeNumberSum function
describe('threeNumberSum', () => {
  // Test case 1: Array has three numbers summing to targetSum
  it('should return the correct triplet when there exist three numbers that sum to targetSum', () => {
    const array = [12, 3, 1, 2, -6, 5, 0, -8, -1, 6];
    const targetSum = 0;
    const result = threeNumberSum(array, targetSum);
    expect(result).toEqual([[-6, 1, 5], [-1, 0, 1]]);
  });

  // Test case 2: Array does not have three numbers summing to targetSum
  it('should return an empty array when there does not exist three numbers that sum to targetSum', () => {
    const array = [1, 2, 3, 4, 5];
    const targetSum = 100;
    const result = threeNumberSum(array, targetSum);
    expect(result).toEqual([]);
  });

  // Test case 3: Array has negative numbers and targetSum is a positive number
  it('should return the correct triplet when the array has negative numbers and there exist three numbers that sum to a positive targetSum', () => {
    const array = [-3, -1, 2, 3, 4, 5];
    const targetSum = 3;
    const result = threeNumberSum(array, targetSum);
    expect(result).toEqual([[-3, 1, 5], [-1, 2, 3]]);
  });

  // Test case 4: Array length is less than 3
  it('should return an empty array when array length is less than 3', () => {
    const array = [1, 2];
    const targetSum = 3;
    const result = threeNumberSum(array, targetSum);
    expect(result).toEqual([]);
  });

  // Test case 5: Testing with both positive and negative targetSums
  it('should return the correct triplet when there exists three numbers that sum to both positive and negative targetSums', () => {
    const array = [1, -2, 3, -3, 4, 5, 0];
    const targetSum1 = 6;
    const targetSum2 = -4;
    const result1 = threeNumberSum(array, targetSum1);
    const result2 = threeNumberSum(array, targetSum2);
    expect(result1).toEqual([[1, 3, 2], [1, 4, 1], [-2, 5, 3]]);
    expect(result2).toEqual([[-2, 1, 1]]);
  });
});

// Test cases for threeSum function
describe('threeSum', () => {
  // Test case 1: Array has three numbers summing to 0
  it('should return the correct triplet when there exist three numbers that sum to 0', () => {
    const nums = [12, 3, 1, 2, -6, 5, 0, -8, -1, 6];
    const result = threeSum(nums);
    expect(result).toEqual([[-6, 1, 5], [-1, 0, 1]]);
  });

  // Test case 2: Array does not have three numbers summing to 0
  it('should return an empty array when there does not exist three numbers that sum to 0', () => {
    const nums = [1, 2, 3, 4, 5];
    const result = threeSum(nums);
    expect(result).toEqual([]);
  });

  // Test case 3: Array has negative numbers
  it('should return the correct triplet when the array has negative numbers and there exist three numbers that sum to 0', () => {
    const nums = [-3, -1, 2, 3, 4, 5];
    const result = threeSum(nums);
    expect(result).toEqual([[-3, -1, 4], [-3, 1, 2]]);
  });

  // Test case 4: Array length is less than 3
  it('should return an empty array when array length is less than 3', () => {
    const nums = [1, 2];
    const result = threeSum(nums);
    expect(result).toEqual([]);
  });

  // Test case 5: Array has unique triplets
  it('should return unique triplets', () => {
    const nums = [1, -2, 3, -3, 4, 5, 0, -2, -1, 6];
    const result = threeSum(nums);
    expect(result).toEqual([[-2, -1, 3], [-3, 1, 2]]);
  });
});