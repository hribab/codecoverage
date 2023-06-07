using System;
using Xunit;
using Algorithms.Other;

namespace Algorithms.Tests.Other
{
    public class LuhnTests
    {
        [Fact]
        public void Test_Validate_ValidNumbers()
        {
            // Arrange
            var validNumbers = new[] { "79927398713", "4532015112830366", "6011514433546201", "6771549495586802" };

            // Act & Assert
            foreach (var number in validNumbers)
            {
                Assert.True(Luhn.Validate(number), $"The number {number} should be valid");
            }
        }

        [Fact]
        public void Test_Validate_InvalidNumbers()
        {
            // Arrange
            var invalidNumbers = new[] { "79927398714", "4532015112830367", "6011514433546202", "6771549495586803" };

            // Act & Assert
            foreach (var number in invalidNumbers)
            {
                Assert.False(Luhn.Validate(number), $"The number {number} should be invalid");
            }
        }

        [Fact]
        public void Test_GetLostNum_MissingDigitInValidNumbers()
        {
            // Arrange
            var numbersWithMissingDigits = new[] { "7992739871x", "45320151128303x6", "60115144335462x1", "67715494955868x2" };
            var expectedMissingDigits = new[] { 3, 6, 1, 2 };

            // Act & Assert
            for (int i = 0; i < numbersWithMissingDigits.Length; i++)
            {
                int lostNum = Luhn.GetLostNum(numbersWithMissingDigits[i]);
                Assert.Equal(expectedMissingDigits[i], lostNum);
            }
        }

        [Fact]
        public void Test_GetLostNum_MissingDigitInInvalidNumbers()
        {
            // Arrange
            var invalidNumbersWithMissingDigits = new[] { "7992739871x", "45320151128303x7", "60115144335462x2", "67715494955868x3" };
            var expectedMissingDigits = new[] { 3, 6, 1, 2 };

            // Act & Assert
            for (int i = 0; i < invalidNumbersWithMissingDigits.Length; i++)
            {
                int lostNum = Luhn.GetLostNum(invalidNumbersWithMissingDigits[i]);
                Assert.NotEqual(expectedMissingDigits[i], lostNum);
            }
        }

        [Fact]
        public void Test_GetLostNum_SingleDigit_Number()
        {
            // Arrange
            var singleDigitNumber = "x";

            // Act
            int lostNum = Luhn.GetLostNum(singleDigitNumber);

            // Assert
            Assert.InRange(lostNum, 0, 9);
        }
    }
}