using System.Collections.Generic;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

namespace PrimePiSequence.Tests
{
    public class PrimePiTest
    {
        // Test scenario: first 10 numbers of the PrimePi sequence.
        [Fact]
        public void TestPrimePiSequence_First10()
        {
            // Arrange
            var sequence = new PrimePiSequence();
            var expectedResult = new List<BigInteger> {0, 1, 1, 2, 2, 3, 3, 4, 4, 4};
            var result = new List<BigInteger>();

            // Act
            int count = 0;
            foreach (var primePi in sequence.Sequence)
            {
                result.Add(primePi);
                if (++count == 10)
                    break;
            }

            // Assert
            Assert.Equal(expectedResult, result);
        }

        // Test scenario: Check PrimePi values between 10 and 20.
        [Fact]
        public void TestPrimePiSequence_Between10And20()
        {
            // Arrange
            var sequence = new PrimePiSequence();
            var expectedResult = new List<BigInteger> {4, 4, 4, 5, 5, 6, 6, 6, 7, 7};
            var result = new List<BigInteger>();

            // Act
            int count = 0;
            foreach (var primePi in sequence.Sequence)
            {
                if (++count > 10)
                    result.Add(primePi);
                if (count == 20)
                    break;
            }

            // Assert
            Assert.Equal(expectedResult, result);
        }

        // Test scenario: Check PrimePi values between 100 and 110.
        [Fact]
        public void TestPrimePiSequence_Between100And110()
        {
            // Arrange
            var sequence = new PrimePiSequence();
            var expectedResult = new List<BigInteger> {25, 25, 26, 26, 26, 27, 27, 28, 28, 28, 28};
            var result = new List<BigInteger>();

            // Act
            int count = 0;
            foreach (var primePi in sequence.Sequence)
            {
                if (++count > 100)
                    result.Add(primePi);
                if (count == 110)
                    break;
            }

            // Assert
            Assert.Equal(expectedResult, result);
        }

        // Test scenario: Check PrimePi values between 500 and 510.
        [Fact]
        public void TestPrimePiSequence_Between500And510()
        {
            // Arrange
            var sequence = new PrimePiSequence();
            var expectedResult = new List<BigInteger> {95, 95, 96, 96, 96, 97, 97, 98, 98, 98, 99};
            var result = new List<BigInteger>();

            // Act
            int count = 0;
            foreach (var primePi in sequence.Sequence)
            {
                if (++count > 500)
                    result.Add(primePi);
                if (count == 510)
                    break;
            }

            // Assert
            Assert.Equal(expectedResult, result);
        }

        // Test scenario: Check PrimePi values between 1000 and 1010.
        [Fact]
        public void TestPrimePiSequence_Between1000And1010()
        {
            // Arrange
            var sequence = new PrimePiSequence();
            var expectedResult = new List<BigInteger> {168, 168, 169, 169, 169, 170, 170, 171, 171, 171, 171};
            var result = new List<BigInteger>();

            // Act
            int count = 0;
            foreach (var primePi in sequence.Sequence)
            {
                if (++count > 1000)
                    result.Add(primePi);
                if (count == 1010)
                    break;
            }

            // Assert
            Assert.Equal(expectedResult, result);
        }
    }
}