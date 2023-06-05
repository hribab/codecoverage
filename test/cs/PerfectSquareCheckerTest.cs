using System;
using Xunit;
using Algorithms.Numeric;

namespace Algorithms.Tests
{
    public class PerfectSquareCheckerTests
    {
        [Fact]
        public void IsPerfectSquare_NegativeNumber_False()
        {
            // Arrange
            int number = -5;

            // Act
            bool result = PerfectSquareChecker.IsPerfectSquare(number);

            // Assert
            Assert.False(result);
        }

        [Fact]
        public void IsPerfectSquare_Zero_True()
        {
            // Arrange
            int number = 0;

            // Act
            bool result = PerfectSquareChecker.IsPerfectSquare(number);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public void IsPerfectSquare_PositivePerfectSquare_True()
        {
            // Arrange
            int number = 9;

            // Act
            bool result = PerfectSquareChecker.IsPerfectSquare(number);

            // Assert
            Assert.True(result);
        }

        [Fact]
        public void IsPerfectSquare_PositiveNotPerfectSquare_False()
        {
            // Arrange
            int number = 7;

            // Act
            bool result = PerfectSquareChecker.IsPerfectSquare(number);

            // Assert
            Assert.False(result);
        }

        [Fact]
        public void IsPerfectSquare_LargePerfectSquare_True()
        {
            // Arrange
            int number = 1024;

            // Act
            bool result = PerfectSquareChecker.IsPerfectSquare(number);

            // Assert
            Assert.True(result);
        }
    }
}