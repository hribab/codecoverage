using System.Collections.Generic;
using Algorithms.Sequences;
using System.Numerics;
using Xunit;

namespace Algorithms.Tests.Sequences
{
    public class NegativeIntegersSequenceTests
    {
        [Fact]
        public void Test_FirstFiveValues()
        {
            // Arrange
            var expectedValues = new List<BigInteger> { -1, -2, -3, -4, -5 };
            var sequence = new NegativeIntegersSequence();

            // Act
            var actualValues = sequence.Sequence.GetEnumerator();
            
            // Assert
            for (int i = 0; i < 5; i++)
            {
                actualValues.MoveNext();
                Assert.Equal(expectedValues[i], actualValues.Current);
            }
        }

        [Fact]
        public void Test_NextValue()
        {
            // Arrange
            var sequence = new NegativeIntegersSequence().Sequence.GetEnumerator();
            
            // Act and Assert
            sequence.MoveNext();
            sequence.MoveNext();
            sequence.MoveNext();
            Assert.Equal(new BigInteger(-3), sequence.Current);
        }

        [Fact]
        public void Test_ValueBeforeReset()
        {
            // Arrange
            var sequence = new NegativeIntegersSequence().Sequence.GetEnumerator();
            sequence.MoveNext();
            sequence.MoveNext();
            sequence.MoveNext();
            sequence.Reset();

            // Act and Assert
            Assert.Equal(new BigInteger(-3), sequence.Current);
        }

        [Fact]
        public void Test_ValueAfterReset()
        {
            // Arrange
            var sequence = new NegativeIntegersSequence().Sequence.GetEnumerator();
            sequence.MoveNext();
            sequence.MoveNext();
            sequence.MoveNext();
            sequence.Reset();

            // Act
            sequence.MoveNext();

            // Assert
            Assert.Equal(new BigInteger(-1), sequence.Current);
        }

        [Fact]
        public void Test_ValueInTheSeed()
        {
            // Arrange
            var sequence = new NegativeIntegersSequence().Sequence.GetEnumerator();

            // Act
            var hasPreviousValue = sequence.MoveNext();

            // Assert
            Assert.True(hasPreviousValue);
        }
    }
}