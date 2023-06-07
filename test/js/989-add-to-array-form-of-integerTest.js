const { assert } = require("chai");

const addToArrayForm = (num, k) => {
  let numToNum = BigInt(num.join("")) + BigInt(k);
  return numToNum.toString().split("").map(Number);
};

describe("addToArrayForm function", () => {
  // Test case 1: Simple array and k value addition
  it("should return [1, 2, 3, 4] for num=[1,2,3] and k=31", () => {
    assert.deepEqual(addToArrayForm([1, 2, 3], 31), [1, 2, 3, 4]);
  });
  
  // Test case 2: Array with zeros and k value addition
  it("should return [4, 4, 4] for num=[4,4,3] and k=41", () => {
    assert.deepEqual(addToArrayForm([4, 4, 3], 41), [4, 4, 4]);
  });
  
  // Test case 3: Array with numbers in descending order and k value addition
  it("should return [7, 6, 1] for num=[6,5,0] and k=201", () => {
    assert.deepEqual(addToArrayForm([6, 5, 0], 201), [7, 6, 1]);
  });
  
  // Test case 4: Array with numbers in ascending order and k value addition
  it("should return [3, 3, 3] for num=[1,1,1] and k=222", () => {
    assert.deepEqual(addToArrayForm([1, 1, 1], 222), [3, 3, 3]);
  });
  
  // Test case 5: Array with large numbers and k value addition
  it("should return [4, 8, 3, 0, 9, 1] for num=[1,2,3,4,5,6] and k=345435", () => {
    assert.deepEqual(addToArrayForm([1, 2, 3, 4, 5, 6], 345435), [4, 8, 3, 0, 9, 1]);
  });
});