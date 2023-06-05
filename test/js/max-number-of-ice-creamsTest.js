const maxIceCream = require('../js/max-number-of-ice-creams.js');
const assert = require('assert');

describe('maxIceCream', () => {
  // Test case 1: Normal input and output
  it('returns the maximum number of ice creams that can be bought', () => {
    const costs = [1, 3, 2, 4, 1];
    const coins = 7;
    const result = maxIceCream(costs, coins);
    assert.strictEqual(result, 4);
  });

  // Test case 2: Empty costs array
  it('returns 0 if the costs array is empty', () => {
    const costs = [];
    const coins = 7;
    const result = maxIceCream(costs, coins);
    assert.strictEqual(result, 0);
  });

  // Test case 3: Insufficient coins
  it('returns 0 if the coins are not enough to buy any ice cream', () => {
    const costs = [2, 3, 4, 5];
    const coins = 1;
    const result = maxIceCream(costs, coins);
    assert.strictEqual(result, 0);
  });

  // Test case 4: Just enough coins to buy all ice creams
  it('returns the number of ice creams if the coins are just enough to buy all', () => {
    const costs = [1, 2, 3, 4];
    const coins = 10;
    const result = maxIceCream(costs, coins);
    assert.strictEqual(result, 4);
  });

  // Test case 5: All ice creams have the same cost
  it('returns the correct number of ice creams if all have the same cost', () => {
    const costs = [3, 3, 3, 3];
    const coins = 9;
    const result = maxIceCream(costs, coins);
    assert.strictEqual(result, 3);
  });
});