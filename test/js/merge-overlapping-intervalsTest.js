const assert = require('assert');
const mergeOverlappingIntervals = require('sampletestfiles/js/merge-overlapping-intervals.js');

describe('mergeOverlappingIntervals', () => {
  // Test case 1
  it('should merge overlapping intervals', () => {
    const array = [
      [1, 3],
      [2, 6],
      [8, 10],
      [15, 18],
    ];
    const result = mergeOverlappingIntervals(array);
    assert.deepStrictEqual(result, [
      [1, 6],
      [8, 10],
      [15, 18],
    ]);
  });

  // Test case 2
  it('should handle intervals with same start and end points', () => {
    const array = [
      [1, 4],
      [4, 5],
    ];
    const result = mergeOverlappingIntervals(array);
    assert.deepStrictEqual(result, [
      [1, 5],
    ]);
  });

  // Test case 3
  it('should handle unsorted intervals', () => {
    const array = [
      [8, 10],
      [1, 3],
      [15, 18],
      [2, 6],
    ];
    const result = mergeOverlappingIntervals(array);
    assert.deepStrictEqual(result, [
      [1, 6],
      [8, 10],
      [15, 18],
    ]);
  });

  // Test case 4
  it('should handle non-overlapping intervals', () => {
    const array = [
      [1, 3],
      [5, 7],
      [9, 11],
    ];
    const result = mergeOverlappingIntervals(array);
    assert.deepStrictEqual(result, array);
  });

  // Test case 5
  it('should handle single interval', () => {
    const array = [
      [1, 5],
    ];
    const result = mergeOverlappingIntervals(array);
    assert.deepStrictEqual(result, array);
  });
});