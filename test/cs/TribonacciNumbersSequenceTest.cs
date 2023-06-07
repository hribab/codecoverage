using System;
using System.Linq;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace Algorithms.Tests.Sequences
{
    public class TribonacciNumbersSequenceTests
    {
        private readonly TribonacciNumbersSequence _sequence;

        public TribonacciNumbersSequenceTests()
        {
            _sequence = new TribonacciNumbersSequence();
        }

        [Fact]
        public void Test_FirstFiveElementsAreCorrect()
        {
            // Arrange
            BigInteger[] expected = { 1, 1, 1, 3, 5 };

            // Act
            var actual = _sequence.Sequence.Take(5).ToArray();

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Test_SixthElementIsCorrect()
        {
            // Arrange
            BigInteger expected = 9;

            // Act
            var actual = _sequence.Sequence.Skip(5).First();

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Test_FirstFewElementsAreSumOfPreviousThree()
        {
            // Arrange
            int numberOfElementsToCheck = 10;

            // Act
            var sequenceElements = _sequence.Sequence.Take(numberOfElementsToCheck + 3).ToArray();

            // Assert
            for (int i = 3; i < numberOfElementsToCheck; i++)
            {
                Assert.Equal(sequenceElements[i], sequenceElements[i - 1] + sequenceElements[i - 2] + sequenceElements[i - 3]);
            }
        }

        [Fact]
        public void Test_SequenceIncreases()
        {
            // Arrange
            int numberOfElementsToCheck = 10;

            // Act
            var sequenceElements = _sequence.Sequence.Take(numberOfElementsToCheck).ToArray();

            // Assert
            for (int i = 1; i < numberOfElementsToCheck; i++)
            {
                Assert.True(sequenceElements[i] > sequenceElements[i - 1]);
            }
        }

        [Fact]
        public void Test_AllElementsArePositive()
        {
            // Arrange
            int numberOfElementsToCheck = 20;

            // Act
            var sequenceElements = _sequence.Sequence.Take(numberOfElementsToCheck).ToArray();

            // Assert
            foreach (var element in sequenceElements)
            {
                Assert.True(element >= 0);
            }
        }
    }
}