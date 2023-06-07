const { describe, it } = require('mocha');
const { expect } = require('chai');
const minimumWaitingTime = require('../js/minimum-waiting-time');

describe('minimumWaitingTime()', () => {
  // Test case 1: Normal input
  it('should return the correct minimum waiting time for a given input', () => {
    const input = [3, 2, 1, 2, 6];
    const output = 17;
    expect(minimumWaitingTime(input)).to.equal(output);
  });

  // Test case 2: Empty input
  it('should return 0 for an empty input', () => {
    const input = [];
    const output = 0;
    expect(minimumWaitingTime(input)).to.equal(output);
  });

  // Test case 3: One query
  it('should return 0 for a single query input', () => {
    const input = [5];
    const output = 0;
    expect(minimumWaitingTime(input)).to.equal(output);
  });

  // Test case 4: Queries with the same duration
  it('should return the correct minimum waiting time for queries with the same duration', () => {
    const input = [2, 2, 2, 2];
    const output = 8;
    expect(minimumWaitingTime(input)).to.equal(output);
  });

  // Test case 5: Sorted input
  it('should return the correct minimum waiting time for a sorted input', () => {
    const input = [1, 2, 3, 4];
    const output = 10;
    expect(minimumWaitingTime(input)).to.equal(output);
  });
});