using System;
using Algorithms.Numeric;
using Xunit;

namespace Algorithms.Tests
{
    public class NarcissisticNumberCheckerTests
    {
        [Fact]
        // Test case with a single digit Narcissistic number
        public void IsNarcissistic_SingleDigitNumber_ReturnsTrue()
        {
            // Arrange
            int number = 9;

            // Act
            bool result = NarcissisticNumberChecker.IsNarcissistic(number);

            // Assert
            Assert.True(result);
        }

        [Fact]
        // Test case with a multi-digit Narcissistic number
        public void IsNarcissistic_MultiDigitNarcissisticNumber_ReturnsTrue()
        {
            // Arrange
            int number = 153;

            // Act
            bool result = NarcissisticNumberChecker.IsNarcissistic(number);

            // Assert
            Assert.True(result);
        }

        [Fact]
        // Test case with a number that is not Narcissistic
        public void IsNarcissistic_NotNarcissisticNumber_ReturnsFalse()
        {
            // Arrange
            int number = 123;

            // Act
            bool result = NarcissisticNumberChecker.IsNarcissistic(number);

            // Assert
            Assert.False(result);
        }

        [Fact]
        // Test case with a negative number
        public void IsNarcissistic_NegativeNumber_ReturnsFalse()
        {
            // Arrange
            int number = -153;

            // Act
            bool result = NarcissisticNumberChecker.IsNarcissistic(number);

            // Assert
            Assert.False(result);
        }

        [Fact]
        // Test case with zero
        public void IsNarcissistic_Zero_ReturnsTrue()
        {
            // Arrange
            int number = 0;

            // Act
            bool result = NarcissisticNumberChecker.IsNarcissistic(number);

            // Assert
            Assert.True(result);
        }
    }
}