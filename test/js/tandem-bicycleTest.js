const { tandemBicycle, sumSpeeds } = require('../js/tandem-bicycle.js');
const { assert } = require('chai');

describe('tandemBicycle()', function() {
  it('should return the maximum possible total speeds when fastest is true', function() {
    assert.deepEqual(tandemBicycle([5, 5, 3, 9, 2], [3, 6, 7, 2, 1], true), 32);
  });

  it('should return the minimum possible total speeds when fastest is false', function() {
    assert.deepEqual(tandemBicycle([5, 5, 3, 9, 2], [3, 6, 7, 2, 1], false), 25);
  });

  it('should return 0 when the input arrays are empty', function() {
    assert.deepEqual(tandemBicycle([], [], true), 0);
    assert.deepEqual(tandemBicycle([], [], false), 0);
  });

  it('should work with input arrays of length 1', function() {
    assert.deepEqual(tandemBicycle([4], [5], true), 5);
    assert.deepEqual(tandemBicycle([4], [5], false), 5);
  });

  it('should work with input arrays of any length', function() {
    assert.deepEqual(
      tandemBicycle([1, 2, 3], [3, 2, 1], true),
      12,
      'Expected sum to be 12 when fastest is true'
    );
    assert.deepEqual(
      tandemBicycle([1, 2, 3], [3, 2, 1], false),
      10,
      'Expected sum to be 10 when fastest is false'
    );
  });
});

describe('sumSpeeds()', function() {
  it('should return the sum of the maximum values of each pair', function() {
    assert.deepEqual(sumSpeeds([5, 5, 3, 8, 2], [3, 6, 7, 2, 1]), 28);
  });

  it('should work with equal value arrays', function() {
    assert.deepEqual(sumSpeeds([2, 2, 2], [2, 2, 2]), 6);
  });

  it('should return 0 when the input arrays are empty', function() {
    assert.deepEqual(sumSpeeds([], []), 0);
  });

  it('should work with input arrays of length 1', function() {
    assert.deepEqual(sumSpeeds([4], [5]), 5);
  });

  it('should work with input arrays containing different values', function() {
    assert.deepEqual(sumSpeeds([1, 1, 1, 1], [4, 3, 2, 1]), 10);
  });
});