using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace Algorithms.Tests
{
    public class NaturalSequenceTests
    {
        private readonly NaturalSequence _sequence;

        public NaturalSequenceTests()
        {
            _sequence = new NaturalSequence();
        }

        [Fact]
        public void Test_First10Numbers()
        {
            // Arrange
            var expected = Enumerable.Range(1, 10).Select(x => new BigInteger(x)).ToArray();

            // Act
            var actual = _sequence.Sequence.Take(10).ToArray();

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Test_SequenceContainsNoDuplicates()
        {
            // Arrange
            const int sequenceLength = 1000;

            // Act
            var sequence = _sequence.Sequence.Take(sequenceLength);

            // Assert
            Assert.Equal(sequenceLength, sequence.Distinct().Count());
        }

        [Fact]
        public void Test_SequenceHasIncreasedElements()
        {
            // Arrange
            const int sequenceLength = 1000;

            // Act
            var sequence = _sequence.Sequence.Take(sequenceLength).ToArray();

            // Assert
            for (int i = 1; i < sequence.Length; i++)
            {
                Assert.True(sequence[i] > sequence[i - 1]);
            }
        }

        [Fact]
        public void Test_NegativeNumber_NotInSequence()
        {
            // Arrange
            const int sequenceLength = 1000;

            // Act
            var sequence = _sequence.Sequence.Take(sequenceLength);

            // Assert
            Assert.DoesNotContain(new BigInteger(-1), sequence);
        }

        [Fact]
        public void Test_SequenceStartsWithOne()
        {
            // Act
            var firstElement = _sequence.Sequence.First();

            // Assert
            Assert.Equal(new BigInteger(1), firstElement);
        }
    }
}