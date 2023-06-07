using System;
using System.Numerics;
using Xunit;
using Algorithms.Numeric;

namespace Algorithms.Tests
{
    public class MillerRabinPrimalityCheckerTests
    {
        [Fact]
        public void IsProbablyPrimeNumber_NumberLessThanOrEqualToThree_ThrowsArgumentException()
        {
            // Arrange
            BigInteger number = 3;

            // Assert
            Assert.Throws<ArgumentException>(() => MillerRabinPrimalityChecker.IsProbablyPrimeNumber(number, 1));
        }

        [Theory]
        [InlineData(5, 2, true)]
        [InlineData(7, 3, true)]
        [InlineData(9, 2, false)]
        [InlineData(11, 3, true)]
        [InlineData(15, 2, false)]
        public void IsProbablyPrimeNumber_BasicTests(int number, int rounds, bool expectedIsPrime)
        {
            // Act
            bool result = MillerRabinPrimalityChecker.IsProbablyPrimeNumber(number, rounds);

            // Assert 
            Assert.Equal(expectedIsPrime, result);
        }

        [Fact]
        public void IsProbablyPrimeNumber_LargePrime()
        {
            // Arrange
            BigInteger prime = BigInteger.Parse("15487469");

            // Act
            bool result = MillerRabinPrimalityChecker.IsProbablyPrimeNumber(prime, 10);

            // Assert 
            Assert.True(result);
        }

        [Fact]
        public void IsProbablyPrimeNumber_LargeComposite()
        {
            // Arrange
            BigInteger composite = BigInteger.Parse("212121015385");

            // Act
            bool result = MillerRabinPrimalityChecker.IsProbablyPrimeNumber(composite, 10);

            // Assert 
            Assert.False(result);
        }

        [Fact]
        public void IsProbablyPrimeNumber_WithSeed_DeterministicResult()
        {
            // Arrange
            BigInteger number = 9973;
            int seed = 42;

            // Act
            bool result1 = MillerRabinPrimalityChecker.IsProbablyPrimeNumber(number, 5, seed);
            bool result2 = MillerRabinPrimalityChecker.IsProbablyPrimeNumber(number, 5, seed);

            // Assert 
            Assert.Equal(result1, result2);
        }
    }
}