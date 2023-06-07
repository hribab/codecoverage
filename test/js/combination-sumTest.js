// Unit test code for combinationSum and combinationSum2

const { expect } = require("chai");

describe("combinationSum", function () {
  // Test case 1: Normal scenario with distinct numbers
  it("should return unique combinations of candidates that sums up to target (distinct numbers)", function () {
    const candidates = [2, 3, 6, 7];
    const target = 7;
    const result = combinationSum(candidates, target);
    expect(result).to.deep.equal([[2, 2, 3], [7]]);
  });

  // Test case 2: Normal scenario with duplicate numbers
  it("should return unique combinations of candidates that sums up to target (duplicate numbers)", function () {
    const candidates = [2, 3, 5, 3, 7];
    const target = 8;
    const result = combinationSum(candidates, target);
    expect(result).to.deep.equal([[2, 2, 2, 2], [2, 3, 3], [3, 5], [2, 5, 3]]);
  });

  // Test case 3: An empty array as input
  it("should return an empty array if given candidates is empty", function () {
    const candidates = [];
    const target = 7;
    const result = combinationSum(candidates, target);
    expect(result).to.deep.equal([]);
  });

  // Test case 4: No combinations possible
  it("should return an empty array if no combinations are possible", function () {
    const candidates = [4, 5, 6];
    const target = 7;
    const result = combinationSum(candidates, target);
    expect(result).to.deep.equal([]);
  });

  // Test case 5: Target is zero
  it("should return an empty array if target is zero", function () {
    const candidates = [2, 4, 6];
    const target = 0;
    const result = combinationSum(candidates, target);
    expect(result).to.deep.equal([]);
  });
});

describe("combinationSum2", function () {
  // Test case 1: Normal scenario with distinct numbers
  it("should return unique combinations of candidates that sums up to target (distinct numbers)", function () {
    const candidates = [10, 1, 2, 7, 6, 1, 5];
    const target = 8;
    const result = combinationSum2(candidates, target);
    expect(result).to.deep.equal([[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]]);
  });

  // Test case 2: Normal scenario with duplicate numbers
  it("should return unique combinations of candidates that sums up to target (duplicate numbers)", function () {
    const candidates = [2, 5, 2, 1, 2];
    const target = 5;
    const result = combinationSum2(candidates, target);
    expect(result).to.deep.equal([[1, 2, 2], [5]]);
  });

  // Test case 3: An empty array as input
  it("should return an empty array if given candidates is empty", function () {
    const candidates = [];
    const target = 7;
    const result = combinationSum2(candidates, target);
    expect(result).to.deep.equal([]);
  });

  // Test case 4: No combinations possible
  it("should return an empty array if no combinations are possible", function () {
    const candidates = [4, 5, 6];
    const target = 7;
    const result = combinationSum2(candidates, target);
    expect(result).to.deep.equal([]);
  });

  // Test case 5: Target is zero
  it("should return an empty array if target is zero", function () {
    const candidates = [2, 4, 6];
    const target = 0;
    const result = combinationSum2(candidates, target);
    expect(result).to.deep.equal([]);
  });
});