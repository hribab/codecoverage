using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace Algorithms.Tests.Sequences
{
    public class ZeroSequenceTests
    {
        private readonly ZeroSequence _zeroSequence;

        public ZeroSequenceTests()
        {
            _zeroSequence = new ZeroSequence();
        }

        [Fact]
        public void TestZeroSequence_FirstElement()
        {
            // Arrange
            int expectedResult = 0;

            // Act
            BigInteger firstElement = _zeroSequence.Sequence.First();

            // Assert
            Assert.Equal(expectedResult, firstElement);
        }

        [Fact]
        public void TestZeroSequence_SecondElement()
        {
            // Arrange
            int expectedResult = 0;

            // Act
            BigInteger secondElement = _zeroSequence.Sequence.Skip(1).First();

            // Assert
            Assert.Equal(expectedResult, secondElement);
        }

        [Fact]
        public void TestZeroSequence_ThirdElement()
        {
            // Arrange
            int expectedResult = 0;

            // Act
            BigInteger thirdElement = _zeroSequence.Sequence.Skip(2).First();

            // Assert
            Assert.Equal(expectedResult, thirdElement);
        }

        [Fact]
        public void TestZeroSequence_FourthElement()
        {
            // Arrange
            int expectedResult = 0;

            // Act
            BigInteger fourthElement = _zeroSequence.Sequence.Skip(3).First();

            // Assert
            Assert.Equal(expectedResult, fourthElement);
        }

        [Fact]
        public void TestZeroSequence_FifthElement()
        {
            // Arrange
            int expectedResult = 0;

            // Act
            BigInteger fifthElement = _zeroSequence.Sequence.Skip(4).First();

            // Assert
            Assert.Equal(expectedResult, fifthElement);
        }
    }
}