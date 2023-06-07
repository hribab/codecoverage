using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace Algorithms.Tests
{
    public class NumberOfPrimesByPowersOf10SequenceTests
    {
        private readonly NumberOfPrimesByPowersOf10Sequence _sequence;

        public NumberOfPrimesByPowersOf10SequenceTests()
        {
            _sequence = new NumberOfPrimesByPowersOf10Sequence();
        }

        [Fact]
        public void GenerateSequence_FirstFiveElements()
        {
            // Arrange
            var expected = new List<BigInteger> { 4, 25, 168, 1229, 9592 };
            
            // Act
            var result = _sequence.Sequence;

            // Assert
            Assert.NotNull(result);

            int index = 0;
            foreach (var value in result)
            {
                if (index >= 5)
                {
                    break;
                }

                Assert.Equal(expected[index], value);
                index++;
            }
        }

        [Fact]
        public void GenerateSequence_TenthElement()
        {
            // Arrange
            int requestedElement = 10;
            BigInteger expected = new BigInteger(78498);

            // Act
            var result = _sequence.Sequence;

            // Assert
            Assert.NotNull(result);

            int index = 1;
            BigInteger valueAtRequestedIndex = 0;
            foreach (var value in result)
            {
                if (index == requestedElement)
                {
                    valueAtRequestedIndex = value;
                    break;
                }

                index++;
            }

            Assert.Equal(expected, valueAtRequestedIndex);
        }

        [Fact]
        public void GenerateSequence_CheckSequenceValues()
        {
            // Arrange
            var expected = new List<BigInteger> {
                4, 25, 168, 1229, 9592, 78498, 664579, 5761455,
                50847534, 455052511, 4118054813
            };

            // Act
            var result = _sequence.Sequence;

            // Assert
            Assert.NotNull(result);

            int index = 0;
            foreach (var value in result)
            {
                if (index >= expected.Count)
                {
                    break;
                }

                Assert.Equal(expected[index], value);
                index++;
            }
        }

        [Fact]
        public void GenerateSequence_CheckForNegativeOrZeroValues()
        {
            // Arrange
            int numberOfElements = 15;

            // Act
            var result = _sequence.Sequence;

            // Assert
            Assert.NotNull(result);

            int index = 1;
            foreach (var value in result)
            {
                if (index > numberOfElements)
                {
                    break;
                }

                Assert.True(value > 0);
                index++;
            }
        }

        [Fact]
        public void GenerateSequence_CheckForContinuouslyIncreasingValues()
        {
            // Arrange
            int numberOfElements = 20;

            // Act
            var result = _sequence.Sequence;

            // Assert
            Assert.NotNull(result);

            int index = 1;
            BigInteger previousValue = -1;
            foreach (var value in result)
            {
                if (index > numberOfElements)
                {
                    break;
                }

                Assert.True(value > previousValue);
                previousValue = value;
                index++;
            }
        }
    }
}