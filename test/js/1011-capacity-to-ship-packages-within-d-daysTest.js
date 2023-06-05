const { shipWithinDays, canShipInDays } = require('sampletestfiles/js/1011-capacity-to-ship-packages-within-d-days.js');
const assert = require('assert');

describe('shipWithinDays', () => {
  // Test case 1
  it('should return the minimum capacity to ship packages within given days', () => {
    const weights = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    const days = 5;
    assert.strictEqual(shipWithinDays(weights, days), 15);
  });

  // Test case 2
  it('should return the minimum capacity to ship packages within given days', () => {
    const weights = [3, 2, 2, 4, 1, 4];
    const days = 3;
    assert.strictEqual(shipWithinDays(weights, days), 6);
  });

  // Test case 3
  it('should return the minimum capacity to ship packages within given days', () => {
    const weights = [1, 2, 3, 1, 1];
    const days = 4;
    assert.strictEqual(shipWithinDays(weights, days), 3);
  });

  // Test case 4
  it('should return the minimum capacity to ship packages within given days', () => {
    const weights = [10, 20, 30, 40, 50, 60, 70, 80, 90];
    const days = 3;
    assert.strictEqual(shipWithinDays(weights, days), 170);
  });

  // Test case 5
  it('should return the minimum capacity to ship packages within given days', () => {
    const weights = [5, 5, 5, 5, 5];
    const days = 5;
    assert.strictEqual(shipWithinDays(weights, days), 5);
  });
});

describe('canShipInDays', () => {
  // Test case 1
  it('should return true if the packages can be shipped in the given days with the provided capacity', () => {
    const weights = [1, 2, 3, 4, 5];
    const capacity = 5;
    const days = 3;
    assert.strictEqual(canShipInDays(weights, capacity, days), true);
  });

  // Test case 2
  it('should return false if the packages cannot be shipped in the given days with the provided capacity', () => {
    const weights = [5, 5, 5, 5, 5];
    const capacity = 4;
    const days = 5;
    assert.strictEqual(canShipInDays(weights, capacity, days), false);
  });

  // Test case 3
  it('should return true if the packages can be shipped in the given days with the provided capacity', () => {
    const weights = [10, 20, 30, 40, 50, 60, 70, 80, 90];
    const capacity = 170;
    const days = 3;
    assert.strictEqual(canShipInDays(weights, capacity, days), true);
  });

  // Test case 4
  it('should return false if the packages cannot be shipped in the given days with the provided capacity', () => {
    const weights = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    const capacity = 14;
    const days = 5;
    assert.strictEqual(canShipInDays(weights, capacity, days), false);
  });

  // Test case 5
  it('should return true if the packages can be shipped in the given days with the provided capacity', () => {
    const weights = [3, 2, 2, 4, 1, 4];
    const capacity = 6;
    const days = 3;
    assert.strictEqual(canShipInDays(weights, capacity, days), true);
  });
});