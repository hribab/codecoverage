using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

namespace Algorithms.Tests
{
    public class PrimesSequenceTests
    {
        [Fact]
        public void Test_First10Primes()
        {
            // Arrange
            var expectedPrimes = new List<BigInteger> { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 };
            
            // Act
            var primesSequence = new PrimesSequence();
            var actualPrimes = primesSequence.Sequence.Take(10).ToList();

            // Assert
            Assert.Equal(expectedPrimes, actualPrimes);
        }

        [Fact]
        public void Test_First20Primes()
        {
            // Arrange
            var expectedPrimes = new List<BigInteger> { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71 };
            
            // Act
            var primesSequence = new PrimesSequence();
            var actualPrimes = primesSequence.Sequence.Take(20).ToList();

            // Assert
            Assert.Equal(expectedPrimes, actualPrimes);
        }

        [Fact]
        public void Test_First50Primes()
        {
            // Arrange
            var expectedPrimes = new List<BigInteger> { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223 };
            
            // Act
            var primesSequence = new PrimesSequence();
            var actualPrimes = primesSequence.Sequence.Take(50).ToList();

            // Assert
            Assert.Equal(expectedPrimes, actualPrimes);
        }

        [Fact]
        public void Test_First100Primes()
        {
            // Arrange
            var expectedPrimes = new List<BigInteger> { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397 };
            
            // Act
            var primesSequence = new PrimesSequence();
            var actualPrimes = primesSequence.Sequence.Take(100).ToList();

            // Assert
            Assert.Equal(expectedPrimes, actualPrimes);
        }

        [Fact]
        public void Test_PrimesUpTo100()
        {
            // Arrange
            var expectedPrimes = new List<BigInteger> { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97 };
            
            // Act
            var primesSequence = new PrimesSequence();
            var actualPrimes = primesSequence.Sequence.TakeWhile(p => p <= 100).ToList();

            // Assert
            Assert.Equal(expectedPrimes, actualPrimes);
        }
    }
}