const assert = require('assert');
const arrayOfProducts = require('../js/array-of-products.js');

describe('arrayOfProducts', () => {
  // Test case 1: Check if function returns an array
  it('Should return an array', () => {
    const result = arrayOfProducts([1, 2, 3, 4]);
    assert(Array.isArray(result));
  });

  // Test case 2: Check if the array elements are numbers
  it('Elements in the array should be numbers', () => {
    const result = arrayOfProducts([1, 2, 3, 4]);
    result.forEach((element) => {
      assert(typeof element === 'number');
    });
  });

  // Test case 3: Check if the function handles an empty array
  it('Should return empty array when array length is 0', () => {
    const result = arrayOfProducts([]);
    assert.deepEqual(result, []);
  });

  // Test case 4: Check if the function calculates array of products correctly
  it('Should return correct array of products for a given array', () => {
    const result = arrayOfProducts([1, 2, 3, 4]);
    assert.deepEqual(result, [24, 12, 8, 6]);
  });

  // Test case 5: Check if the function handles arrays with zero values
  it('Should return correct array of products when array has zero values', () => {
    const result = arrayOfProducts([1, 2, 0, 4]);
    assert.deepEqual(result, [0, 0, 8, 0]);
  });
});