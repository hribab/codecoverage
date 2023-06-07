const assert = require("assert");

function hasUniqueCharacters(string) {
  if (string.length > 128) return false;

  const charSet = new Set();

  for (let idx in string) {
    if (charSet.has(string[idx])) return false;
    charSet.add(string[idx]);
  }
  return true;
}

function hasUniqueCharactersSet(str) {
  let chars = new Set();

  for (let i = 0; i < str.length; ++i) {
    if (chars.has(str[i])) {
      return false;
    }
    chars.add(str[i]);
  }
  return true;
}

function hasUniqueCharactersSort(str) {
  str.sort();

  for (let i = 1; i < str.length; ++i) {
    if (str[i] === str[i - 1]) {
      return false;
    }
  }
  return true;
}

// Unit tests for hasUniqueCharacters function
describe("hasUniqueCharacters", function() {
  // Test case 1: Check for unique characters in a string
  it("should return true for unique set of characters", function() {
    assert.strictEqual(hasUniqueCharacters("abcdefghijklmnopqrstuvwxyz"), true);
  });

  // Test case 2: Check for non-unique characters in a string
  it("should return false for non-unique set of characters", function() {
    assert.strictEqual(hasUniqueCharacters("abcdeghijklmnopqrstuvwxyzabcde"), false);
  });

  // Test case 3: Check for empty string
  it("should return true for empty string", function() {
    assert.strictEqual(hasUniqueCharacters(""), true);
  });

  // Test case 4: Check for string with all same characters
  it("should return false for string with all same characters", function() {
    assert.strictEqual(hasUniqueCharacters("aaaaaaaaaaaaaa"), false);
  });

  // Test case 5: Check for string with special characters
  it("should return true for string with unique special characters", function() {
    assert.strictEqual(hasUniqueCharacters("!#$%&()*+,-.:;<=>?@[]^_`"), true);
  });
});

// Unit tests for hasUniqueCharactersSet function
describe("hasUniqueCharactersSet", function() {
  // Test case 1: Check for unique characters in a string
  it("should return true for unique set of characters", function() {
    assert.strictEqual(hasUniqueCharactersSet("abcdefghijklmnopqrstuvwxyz"), true);
  });

  // Test case 2: Check for non-unique characters in a string
  it("should return false for non-unique set of characters", function() {
    assert.strictEqual(hasUniqueCharactersSet("abcdeghijklmnopqrstuvwxyzabcde"), false);
  });

  // Test case 3: Check for empty string
  it("should return true for empty string", function() {
    assert.strictEqual(hasUniqueCharactersSet(""), true);
  });

  // Test case 4: Check for string with all same characters
  it("should return false for string with all same characters", function() {
    assert.strictEqual(hasUniqueCharactersSet("aaaaaaaaaaaaaa"), false);
  });

  // Test case 5: Check for string with special characters
  it("should return true for string with unique special characters", function() {
    assert.strictEqual(hasUniqueCharactersSet("!#$%&()*+,-.:;<=>?@[]^_`"), true);
  });
});

// Unit tests for hasUniqueCharactersSort function
describe("hasUniqueCharactersSort", function() {
  // Test case 1: Check for unique characters in a string
  it("should return true for unique set of characters", function() {
    assert.strictEqual(hasUniqueCharactersSort(Array.from("abcdefghijklmnopqrstuvwxyz")), true);
  });

  // Test case 2: Check for non-unique characters in a string
  it("should return false for non-unique set of characters", function() {
    assert.strictEqual(hasUniqueCharactersSort(Array.from("abcdeghijklmnopqrstuvwxyzabcde")), false);
  });

  // Test case 3: Check for empty string
  it("should return true for empty string", function() {
    assert.strictEqual(hasUniqueCharactersSort(Array.from("")), true);
  });

  // Test case 4: Check for string with all same characters
  it("should return false for string with all same characters", function() {
    assert.strictEqual(hasUniqueCharactersSort(Array.from("aaaaaaaaaaaaaa")), false);
  });

  // Test case 5: Check for string with special characters
  it("should return true for string with unique special characters", function() {
    assert.strictEqual(hasUniqueCharactersSort(Array.from("!#$%&()*+,-.:;<=>?@[]^_`")), true);
  });
});