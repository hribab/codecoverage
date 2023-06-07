using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace NumberOfPrimesByNumberOfDigitsSequence.Tests
{
    public class NumberOfPrimesByNumberOfDigitsSequenceTest
    {
        private readonly NumberOfPrimesByNumberOfDigitsSequence _numOfPrimesByNumOfDigitsSeq;

        public NumberOfPrimesByNumberOfDigitsSequenceTest()
        {
            _numOfPrimesByNumOfDigitsSeq = new NumberOfPrimesByNumberOfDigitsSequence();
        }

        [Fact]
        public void Sequence_FirstFiveValues()
        {
            // Arrange
            var expected = new List<BigInteger> { 4, 21, 143, 1061, 8363 };

            // Act
            var actual = new List<BigInteger>();
            int counter = 0;

            foreach (var value in _numOfPrimesByNumOfDigitsSeq.Sequence)
            {
                actual.Add(value);
                counter++;

                if (counter >= 5)
                {
                    break;
                }
            }

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Sequence_SixthValue()
        {
            // Arrange
            var expected = new BigInteger(68906);

            // Act
            var actual = new BigInteger();
            int counter = 0;

            foreach (var value in _numOfPrimesByNumOfDigitsSeq.Sequence)
            {
                if (counter == 5)
                {
                    actual = value;
                    break;
                }

                counter++;
            }

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Sequence_SeventhValue()
        {
            // Arrange
            var expected = new BigInteger(586764);

            // Act
            var actual = new BigInteger();
            int counter = 0;

            foreach (var value in _numOfPrimesByNumOfDigitsSeq.Sequence)
            {
                if (counter == 6)
                {
                    actual = value;
                    break;
                }

                counter++;
            }

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Sequence_EighthValue()
        {
            // Arrange
            var expected = new BigInteger(5096873);

            // Act
            var actual = new BigInteger();
            int counter = 0;

            foreach (var value in _numOfPrimesByNumOfDigitsSeq.Sequence)
            {
                if (counter == 7)
                {
                    actual = value;
                    break;
                }

                counter++;
            }

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Sequence_NinthValue()
        {
            // Arrange
            var expected = new BigInteger(45505247);

            // Act
            var actual = new BigInteger();
            int counter = 0;

            foreach (var value in _numOfPrimesByNumOfDigitsSeq.Sequence)
            {
                if (counter == 8)
                {
                    actual = value;
                    break;
                }

                counter++;
            }

            // Assert
            Assert.Equal(expected, actual);
        }
    }
}