// Import the function to test
const findUniq = require("./sampletestfiles/js/find-the-unique-number.js");

// Test cases for the `findUniq` function
describe("findUniq()", () => {
  // Test case 1: Unique number at the beginning
  test("When the unique number is at the beginning", () => {
    const input = [5, 4, 4, 4, 4];
    const output = findUniq(input);
    expect(output).toBe(5);
  });

  // Test case 2: Unique number at the end
  test("When the unique number is at the end", () => {
    const input = [1, 1, 1, 1, 3];
    const output = findUniq(input);
    expect(output).toBe(3);
  });

  // Test case 3: Unique number in the middle
  test("When the unique number is in the middle", () => {
    const input = [10, 10, 7, 10, 10];
    const output = findUniq(input);
    expect(output).toBe(7);
  });

  // Test case 4: Long input array
  test("When the input array is long", () => {
    const input = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 2];
    const output = findUniq(input);
    expect(output).toBe(2);
  });

  // Test case 5: Input array with negative numbers
  test("When the input array contains negative numbers", () => {
    const input = [-3, -3, -3, -3, 1];
    const output = findUniq(input);
    expect(output).toBe(1);
  });
});