using System;
using System.Numerics;
using Algorithms;
using Xunit;

namespace Algorithms.Tests
{
    public class NewtonSquareRootTests
    {
        // Test case for zero input.
        [Fact]
        public void Calculate_WithZeroInput_ReturnsZero()
        {
            // Arrange
            BigInteger number = BigInteger.Zero;
            BigInteger expectedResult = BigInteger.Zero;

            // Act
            BigInteger actualResult = NewtonSquareRoot.Calculate(number);

            // Assert
            Assert.Equal(expectedResult, actualResult);
        }

        // Test case for one input.
        [Fact]
        public void Calculate_WithOneInput_ReturnsOne()
        {
            // Arrange
            BigInteger number = BigInteger.One;
            BigInteger expectedResult = BigInteger.One;

            // Act
            BigInteger actualResult = NewtonSquareRoot.Calculate(number);

            // Assert
            Assert.Equal(expectedResult, actualResult);
        }

        // Test case for a small positive integer input.
        [Fact]
        public void Calculate_WithSmallInput_ReturnsCorrectSquareRoot()
        {
            // Arrange
            BigInteger number = new BigInteger(25);
            BigInteger expectedResult = new BigInteger(5);

            // Act
            BigInteger actualResult = NewtonSquareRoot.Calculate(number);

            // Assert
            Assert.Equal(expectedResult, actualResult);
        }

        // Test case for a large positive integer input to validate performance.
        [Fact]
        public void Calculate_WithLargeInput_ReturnsCorrectSquareRoot()
        {
            // Arrange
            BigInteger number = BigInteger.Pow(123456789, 2);
            BigInteger expectedResult = new BigInteger(123456789);

            // Act
            BigInteger actualResult = NewtonSquareRoot.Calculate(number);

            // Assert
            Assert.Equal(expectedResult, actualResult);
        }

        // Test case for negative input, throws ArgumentException.
        [Fact]
        public void Calculate_WithNegativeNumber_ThrowsArgumentException()
        {
            // Arrange
            BigInteger number = new BigInteger(-123);

            // Act and Assert
            Assert.Throws<ArgumentException>(() => NewtonSquareRoot.Calculate(number));
        }
    }
}