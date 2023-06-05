using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace Algorithms.Tests.Sequences
{
    public class PowersOf2SequenceTests
    {
        private readonly PowersOf2Sequence _sequence;

        public PowersOf2SequenceTests()
        {
            _sequence = new PowersOf2Sequence();
        }

        [Fact]
        public void TestFirstFivePowersOf2()
        {
            // Arrange
            var expectedPowersOf2 = new List<BigInteger>
            {
                new BigInteger(1),
                new BigInteger(2),
                new BigInteger(4),
                new BigInteger(8),
                new BigInteger(16),
            };

            // Act
            var actualPowersOf2 = new List<BigInteger>();
            int count = 0;
            foreach (var powerOf2 in _sequence.Sequence)
            {
                if (count >= 5) break;

                actualPowersOf2.Add(powerOf2);
                count++;
            }

            // Assert
            Assert.Equal(expectedPowersOf2, actualPowersOf2);
        }

        [Theory]
        [InlineData(0, 1)]
        [InlineData(1, 2)]
        [InlineData(2, 4)]
        [InlineData(3, 8)]
        [InlineData(4, 16)]
        public void TestPowersOf2ByIndex(int index, BigInteger expectedPowerOf2)
        {
            // Arrange
            int count = 0;
            BigInteger actualPowerOf2 = 0;

            // Act
            foreach (var powerOf2 in _sequence.Sequence)
            {
                if (count == index)
                {
                    actualPowerOf2 = powerOf2;
                    break;
                }

                count++;
            }

            // Assert
            Assert.Equal(expectedPowerOf2, actualPowerOf2);
        }

        [Theory]
        [InlineData(1, 1)]
        [InlineData(2, 2)]
        [InlineData(4, 4)]
        [InlineData(8, 8)]
        [InlineData(16, 16)]
        public void TestSequenceContainsPowerOf2(BigInteger powerOfTwo, BigInteger expectedPowerOf2)
        {
            // Arrange
            bool containsPowerOfTwo = false;

            // Act
            foreach (var powerOf2 in _sequence.Sequence)
            {
                if (powerOf2 > powerOfTwo)
                {
                    break;
                }

                if (powerOf2 == powerOfTwo)
                {
                    containsPowerOfTwo = true;
                    break;
                }
            }

            // Assert
            Assert.True(containsPowerOfTwo);
        }

        [Theory]
        [InlineData(3, false)]
        [InlineData(5, false)]
        [InlineData(6, false)]
        [InlineData(7, false)]
        [InlineData(9, false)]
        public void TestSequenceDoesNotContainNonPowerOf2(int nonPowerOfTwo, bool expectedContainsNonPowerOfTwo)
        {
            // Arrange
            bool containsNonPowerOfTwo = false;

            // Act
            foreach (var powerOf2 in _sequence.Sequence)
            {
                if (powerOf2 > nonPowerOfTwo)
                {
                    break;
                }

                if (powerOf2 == nonPowerOfTwo)
                {
                    containsNonPowerOfTwo = true;
                    break;
                }
            }

            // Assert
            Assert.Equal(expectedContainsNonPowerOfTwo, containsNonPowerOfTwo);
        }
    }
}