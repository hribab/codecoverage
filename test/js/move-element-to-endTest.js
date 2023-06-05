// Unit tests

const { describe, it } = require("mocha");
const { expect } = require("chai");

describe("moveElementToEnd", () => {
  it("should move all occurrences of the element to the end of the array", () => {
    const array = [2, 1, 2, 2, 2, 3, 4, 2];
    const toMove = 2;
    const expected = [1, 3, 4, 2, 2, 2, 2, 2];
    const result = moveElementToEnd(array, toMove);
    expect(result).to.deep.equal(expected);
  });

  it("should return the same array if the element is not in the array", () => {
    const array = [1, 3, 4, 5, 6, 7];
    const toMove = 2;
    const expected = [1, 3, 4, 5, 6, 7];
    const result = moveElementToEnd(array, toMove);
    expect(result).to.deep.equal(expected);
  });

  it("should return the same array if only one element exists in the array", () => {
    const array = [2, 2, 2, 2, 2, 2, 2, 2];
    const toMove = 2;
    const expected = [2, 2, 2, 2, 2, 2, 2, 2];
    const result = moveElementToEnd(array, toMove);
    expect(result).to.deep.equal(expected);
  });

  it("should return an empty array if the input array is empty", () => {
    const array = [];
    const toMove = 2;
    const expected = [];
    const result = moveElementToEnd(array, toMove);
    expect(result).to.deep.equal(expected);
  });

  it("should return the same array if the target element is already at the end of the array", () => {
    const array = [1, 3, 4, 2, 2, 2];
    const toMove = 2;
    const expected = [1, 3, 4, 2, 2, 2];
    const result = moveElementToEnd(array, toMove);
    expect(result).to.deep.equal(expected);
  });
});