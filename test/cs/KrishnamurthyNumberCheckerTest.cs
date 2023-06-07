using System;
using Algorithms.Numeric;
using Xunit;

namespace Algorithms.Tests
{
    public class KrishnamurthyNumberCheckerTests
    {
        [Fact]
        // A test case to check a positive Krishnamurthy number
        public void Check_PositiveKrishnamurthyNumber()
        {
            // Arrange
            int n = 145;

            // Act
            bool result = KrishnamurthyNumberChecker.IsKMurthyNumber(n);

            // Assert
            Assert.True(result);
        }

        [Fact]
        // A test case to check a negative Krishnamurthy number
        public void Check_NegativeKrishnamurthyNumber()
        {
            // Arrange
            int n = 154;

            // Act
            bool result = KrishnamurthyNumberChecker.IsKMurthyNumber(n);

            // Assert
            Assert.False(result);
        }

        [InlineData(0)]
        [InlineData(-1)]
        [InlineData(-20)]
        [Theory]
        // Test cases to check various non-positive values
        public void Check_NonPositive(int n)
        {
            // Act
            bool result = KrishnamurthyNumberChecker.IsKMurthyNumber(n);

            // Assert
            Assert.False(result);
        }

        [InlineData(1)]
        [InlineData(2)]
        [InlineData(5)]
        [Theory]
        // Test cases to check various non-Krishnamurthy positive numbers
        public void Check_NonKrishnamurthy_PositiveNumber(int n)
        {
            // Act
            bool result = KrishnamurthyNumberChecker.IsKMurthyNumber(n);

            // Assert
            Assert.False(result);
        }

        [InlineData(40585)]
        [Theory]
        // A test case to check MulitDigit_KrishnamurthyNumber
        public void Check_MulitDigit_KrishnamurthyNumber(int n)
        {
            // Act
            bool result = KrishnamurthyNumberChecker.IsKMurthyNumber(n);

            // Assert
            Assert.True(result);
        }
    }
}