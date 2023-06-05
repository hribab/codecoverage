const assert = require('assert');

describe('minimumRounds tests', () => {
  // Test case 1: Normal behavior with unique tasks
  it('should return correct number of rounds for unique tasks', () => {
    const tasks = ['A', 'B', 'C'];
    const expected = -1;
    const result = minimumRounds(tasks);
    assert.strictEqual(result, expected);
  });

  // Test case 2: Normal behavior with multiple tasks
  it('should return correct number of rounds for multiple tasks', () => {
    const tasks = ['A', 'B', 'C', 'A', 'B', 'C'];
    const expected = 2;
    const result = minimumRounds(tasks);
    assert.strictEqual(result, expected);
  });

  // Test case 3: Normal behavior with unequal tasks
  it('should return correct number of rounds for unequal tasks', () => {
    const tasks = ['A', 'A', 'A', 'B', 'B', 'C'];
    const expected = 3;
    const result = minimumRounds(tasks);
    assert.strictEqual(result, expected);
  });

  // Test case 4: Normal behavior with only one task
  it('should return correct number of rounds for single task', () => {
    const tasks = ['A'];
    const expected = -1;
    const result = minimumRounds(tasks);
    assert.strictEqual(result, expected);
  });

  // Test case 5: Normal behavior with repeated task
  it('should return correct number of rounds for repeating tasks', () => {
    const tasks = ['A', 'A', 'A'];
    const expected = 1;
    const result = minimumRounds(tasks);
    assert.strictEqual(result, expected);
  });
});