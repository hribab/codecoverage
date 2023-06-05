using System;
using Algorithms.Other;
using Xunit;

namespace Algorithms.Tests.Other
{
    public class FermatPrimeCheckerTests
    {
        [Theory]
        // Test with known prime number
        [InlineData(2, 5, true)]
        // Test with non-prime (even) number
        [InlineData(4, 5, false)]
        // Test with another known prime number
        [InlineData(29, 5, true)]
        // Test with non-prime (odd) number
        [InlineData(33, 5, false)]
        // Test with large prime number (possible false positives)
        [InlineData(104729, 100, true)]
        public void IsPrimeTests(int numberToTest, int timesToCheck, bool expectedResult)
        {
            // Act
            bool result = FermatPrimeChecker.IsPrime(numberToTest, timesToCheck);

            // Assert
            Assert.Equal(expectedResult, result);
        }

        [Fact]
        public void IsPrimeTest_LargeNumber()
        {
            // Arrange
            int numberToTest = 1000000000;

            // Act
            bool result = FermatPrimeChecker.IsPrime(numberToTest, 5);

            // Assert
            Assert.False(result);
        }

        [Fact]
        public void IsPrimeTest_ZeroTimesToCheck()
        {
            // Arrange
            int numberToTest = 7;

            // Act
            bool result = FermatPrimeChecker.IsPrime(numberToTest, 0);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public void IsPrimeTest_NegativeTimesToCheck()
        {
            // Arrange
            int numberToTest = 11;

            // Act
            bool result = FermatPrimeChecker.IsPrime(numberToTest, -10);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public void IsPrimeTest_OneTimesToCheck()
        {
            // Arrange
            int numberToTest = 13;

            // Act
            bool result = FermatPrimeChecker.IsPrime(numberToTest, 1);

            // Assert
            Assert.True(result);
        }
    }
}