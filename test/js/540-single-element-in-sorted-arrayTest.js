const assert = require("assert");
const singleNonDuplicate = require("./sampletestfiles/js/540-single-element-in-sorted-array.js");

describe("singleNonDuplicate", function () {
  // Test case 1: Unique element at the beginning
  it("should return the unique element at the beginning of the array", function () {
    const nums = [1, 2, 2, 3, 3];
    const result = singleNonDuplicate(nums);
    assert.equal(result, 1);
  });

  // Test case 2: Unique element at the end
  it("should return the unique element at the end of the array", function () {
    const nums = [1, 1, 2, 2, 3];
    const result = singleNonDuplicate(nums);
    assert.equal(result, 3);
  });

  // Test case 3: Unique element in the middle
  it("should return the unique element in the middle of the array", function () {
    const nums = [1, 1, 2, 3, 3];
    const result = singleNonDuplicate(nums);
    assert.equal(result, 2);
  });

  // Test case 4: Array with only one element
  it("should return the unique element if the array has only one element", function () {
    const nums = [5];
    const result = singleNonDuplicate(nums);
    assert.equal(result, 5);
  });

  // Test case 5: Array with multiple pairs and one unique element
  it("should return the unique element in an array with multiple pairs and one unique element", function () {
    const nums = [1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6];
    const result = singleNonDuplicate(nums);
    assert.equal(result, 4);
  });
});