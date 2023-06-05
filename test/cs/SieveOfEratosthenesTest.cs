using System;
using System.Linq;
using Algorithms.Other;
using Xunit;

namespace Algorithms.Tests
{
    public class SieveOfEratosthenesTests
    {
        [Fact]
        public void Constructor_TestMaximumNumberToCheck()
        {
            // Arrange
            long maximumNumberToCheck = 100;

            // Act
            SieveOfEratosthenes sieve = new SieveOfEratosthenes(maximumNumberToCheck);

            // Assert
            Assert.Equal(maximumNumberToCheck, sieve.MaximumNumber);
        }

        [Theory]
        [InlineData(2, true)]
        [InlineData(3, true)]
        [InlineData(4, false)]
        [InlineData(5, true)]
        [InlineData(6, false)]
        public void IsPrime_TestCases(long numberToCheck, bool expectedResult)
        {
            // Arrange
            SieveOfEratosthenes sieve = new SieveOfEratosthenes(10);

            // Act & Assert
            Assert.Equal(expectedResult, sieve.IsPrime(numberToCheck));
        }

        [Fact]
        public void GetPrimes_Below10()
        {
            // Arrange
            SieveOfEratosthenes sieve = new SieveOfEratosthenes(10);
            long[] expectedPrimes = { 2, 3, 5, 7 };

            // Act
            var actualPrimes = sieve.GetPrimes().ToArray();

            // Assert
            Assert.Equal(expectedPrimes, actualPrimes);
        }

        [Fact]
        public void GetPrimes_Below200()
        {
            // Arrange
            SieveOfEratosthenes sieve = new SieveOfEratosthenes(200);
            long[] expectedPrimes = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199 };

            // Act
            var actualPrimes = sieve.GetPrimes().ToArray();

            // Assert
            Assert.Equal(expectedPrimes, actualPrimes);
        }
    }
}
