const assert = require("assert");

function largestRange(array) {
  const dic = {};
  let bestRange = [];
  let longesLenght = 0;

  for (const num of array) {
    dic[num] = true;
  }

  for (const num of array) {
    if (!dic[num]) continue;
    dic[num] = false;
    let currentLenght = 1;
    let left = num - 1;
    let right = num + 1;
    while (left in dic) {
      dic[left] = false;
      currentLenght++;
      left--;
    }
    while (right in dic) {
      dic[right] = false;
      currentLenght++;
      right++;
    }
    if (currentLenght > longesLenght) {
      longesLenght = currentLenght;
      bestRange = [left + 1, right - 1];
    }
  }
  return bestRange;
}

describe("largestRange", () => {
  // Test 1: Array contains one range
  it("Should return the correct range for an array containing one range", () => {
    const array = [1, 2, 3, 4, 5];
    const result = largestRange(array);
    assert.deepStrictEqual(result, [1, 5]);
  });

  // Test 2: Array contains multiple ranges
  it("Should return the correct range for an array containing multiple ranges", () => {
    const array = [1, 11, 3, 0, 15, 5, 2, 4, 10, 7, 12, 6];
    const result = largestRange(array);
    assert.deepStrictEqual(result, [0, 7]);
  });

  // Test 3: Array contains two ranges of equal length
  it("Should return the first encountered range for arrays containing equal length ranges", () => {
    const array = [1, 2, 3, 5, 6, 7, 8, 9];
    const result = largestRange(array);
    assert.deepStrictEqual(result, [1, 3]);
  });

  // Test 4: Array contains negative numbers
  it("Should return the correct range for an array containing negative numbers", () => {
    const array = [-3, -2, -1, 0, 1, 2, 3];
    const result = largestRange(array);
    assert.deepStrictEqual(result, [-3, 3]);
  });

  // Test 5: Array contains unsorted numbers
  it("Should return the correct range for an unsorted array", () => {
    const array = [2, 5, 3, 1, 8, 7, 6, 4];
    const result = largestRange(array);
    assert.deepStrictEqual(result, [1, 8]);
  });
});