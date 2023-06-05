const { subarraySort, isOutOfOrder } = require("./sampletestfiles/js/subarray-sort.js");

describe("subarraySort", () => {
  test("1. Test case with unsorted array", () => {
    const array = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19];
    expect(subarraySort(array)).toEqual([3, 9]);
  });

  test("2. Test case with sorted array", () => {
    const array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    expect(subarraySort(array)).toEqual([-1, -1]);
  });

  test("3. Test case with all same elements", () => {
    const array = [5, 5, 5, 5, 5, 5, 5, 5];
    expect(subarraySort(array)).toEqual([-1, -1]);
  });

  test("4. Test case with descending array", () => {
    const array = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
    expect(subarraySort(array)).toEqual([0, 9]);
  });

  test("5. Test case with single element", () => {
    const array = [1];
    expect(subarraySort(array)).toEqual([-1, -1]);
  });
});

describe("isOutOfOrder", () => {
  test("1. Test case with out of order element at the beginning", () => {
    const array = [3, 1, 2, 4, 5];
    expect(isOutOfOrder(0, 3, array)).toBe(true);
  });

  test("2. Test case with out of order element at the end", () => {
    const array = [1, 2, 3, 4, 0];
    expect(isOutOfOrder(4, 0, array)).toBe(true);
  });

  test("3. Test case with out of order element in the middle", () => {
    const array = [1, 2, 3, 5, 4, 6, 7];
    expect(isOutOfOrder(3, 5, array)).toBe(true);
  });

  test("4. Test case with in order element at the beginning", () => {
    const array = [1, 2, 3, 4, 5];
    expect(isOutOfOrder(0, 1, array)).toBe(false);
  });

  test("5. Test case with in order element at the end", () => {
    const array = [1, 2, 3, 4, 5];
    expect(isOutOfOrder(4, 5, array)).toBe(false);
  });
});