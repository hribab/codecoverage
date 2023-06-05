using System;
using Xunit;
using Algorithms.Numeric.Factorization;

namespace Algorithms.Tests.Numeric.Factorization
{
    public class TrialDivisionFactorizerTests
    {
        private readonly TrialDivisionFactorizer _factorizer;

        public TrialDivisionFactorizerTests()
        {
            _factorizer = new TrialDivisionFactorizer();
        }

        [Theory]
        // Test with prime number
        [InlineData(2, 0, false)]
        [InlineData(3, 0, false)]
        [InlineData(7, 0, false)]
        [InlineData(29, 0, false)]
        [InlineData(31, 0, false)]
        public void TryFactor_PrimeNumber_ReturnsFalse_And_NoFactor(int n, int expectedFactor, bool expectedResult)
        {
            // Act
            var result = _factorizer.TryFactor(n, out int factor);

            // Assert
            Assert.Equal(expectedFactor, factor);
            Assert.Equal(expectedResult, result);
        }

        [Theory]
        // Test with composite numbers
        [InlineData(4, 2, true)]
        [InlineData(6, 2, true)]
        [InlineData(9, 3, true)]
        [InlineData(12, 2, true)]
        [InlineData(27, 3, true)]
        public void TryFactor_CompositeNumber_ReturnsTrue_And_Factor(int n, int expectedFactor, bool expectedResult)
        {
            // Act
            var result = _factorizer.TryFactor(n, out int factor);

            // Assert
            Assert.Equal(expectedFactor, factor);
            Assert.Equal(expectedResult, result);
        }

        [Theory]
        // Test with negative numbers
        [InlineData(-3, 0, false)]
        [InlineData(-8, 2, true)]
        [InlineData(-25, 5, true)]
        [InlineData(-17, 0, false)]
        [InlineData(-18, 2, true)]
        public void TryFactor_NegativeNumber_ReturnsExpected(int n, int expectedFactor, bool expectedResult)
        {
            // Act
            var result = _factorizer.TryFactor(n, out int factor);

            // Assert
            Assert.Equal(expectedFactor, factor);
            Assert.Equal(expectedResult, result);
        }

        [Theory]
        // Test with zero and one
        [InlineData(0, 0, false)]
        [InlineData(1, 0, false)]
        public void TryFactor_ZeroAndOne_ReturnsFalse_And_NoFactor(int n, int expectedFactor, bool expectedResult)
        {
            // Act
            var result = _factorizer.TryFactor(n, out int factor);

            // Assert
            Assert.Equal(expectedFactor, factor);
            Assert.Equal(expectedResult, result);
        }
    }
}