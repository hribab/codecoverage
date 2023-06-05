const assert = require('assert');
const isValidWalk = require('sampletestfiles/js/isValidWalk.js');

describe('isValidWalk()', function() {
  // Test case 1: Check if function returns false for walk shorter than 10
  it('should return false for walk shorter than 10', function() {
    const walk = ['n', 's', 'n', 's'];
    assert.equal(isValidWalk(walk), false);
  });

  // Test case 2: Check if function returns false for walk longer than 10
  it('should return false for walk longer than 10', function() {
    const walk = ['n', 'n', 's', 'e','w', 's', 'n','s','e','w','n'];
    assert.equal(isValidWalk(walk), false);
  });

  // Test case 3: Check if function returns true for a valid walk of exactly 10 steps
  it('should return true for a valid walk of exactly 10 steps', function() {
    const walk = ['n', 's', 'e', 'w', 'n', 's', 'e', 'w', 'n', 's'];
    assert.equal(isValidWalk(walk), true);
  });

  // Test case 4: Check if function returns false for a walk with more steps in North and South direction
  it('should return false for a walk with more steps in North and South direction', function() {
    const walk = ['n', 'n', 's', 'e', 'w', 's', 'n', 's', 'n', 's'];
    assert.equal(isValidWalk(walk), false);
  });

  // Test case 5: Check if function returns false for a walk with more steps in East and West direction
  it('should return false for a walk with more steps in East and West direction', function() {
    const walk = ['n', 's', 'e', 'e', 'w', 's', 'n', 's', 'w', 's'];
    assert.equal(isValidWalk(walk), false);
  });
});