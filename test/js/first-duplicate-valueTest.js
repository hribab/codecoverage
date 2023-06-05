// Import the firstDuplicateValue function for testing
const firstDuplicateValue = require("sampletestfiles/js/first-duplicate-value.js");

// Test cases for the firstDuplicateValue function
describe("firstDuplicateValue", () => {
  // Test case 1: Normal case with duplicate values
  test("Returns the first duplicate value in the array", () => {
    const input = [2, 1, 5, 3, 3, 2, 4];
    const expectedOutput = 3;
    expect(firstDuplicateValue(input)).toBe(expectedOutput);
  });

  // Test case 2: Normal case without duplicate values
  test("Returns -1 if there is no duplicate value", () => {
    const input = [1, 2, 3, 4, 5, 6];
    const expectedOutput = -1;
    expect(firstDuplicateValue(input)).toBe(expectedOutput);
  });

  // Test case 3: Normal case with all duplicate values
  test("Returns the first duplicate value when all elements are the same", () => {
    const input = [7, 7, 7];
    const expectedOutput = 7;
    expect(firstDuplicateValue(input)).toBe(expectedOutput);
  });

  // Test case 4: Normal case with negative and positive duplicate values
  test("Returns the first duplicate value both positive and negative values", () => {
    const input = [1, -1, 3, 4, 1, -1, 3];
    const expectedOutput = 1;
    expect(firstDuplicateValue(input)).toBe(expectedOutput);
  });

  // Test case 5: Edge case with an empty array
  test("Returns -1 if the input array is empty", () => {
    const input = [];
    const expectedOutput = -1;
    expect(firstDuplicateValue(input)).toBe(expectedOutput);
  });
});