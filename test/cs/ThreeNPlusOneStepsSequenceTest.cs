using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using NUnit.Framework;

namespace Algorithms.Tests.Sequences
{
    public class ThreeNPlusOneStepsSequenceTests
    {
        private readonly ThreeNPlusOneStepsSequence _sequence = new ThreeNPlusOneStepsSequence();

        [Test]
        public void FirstTenElements_AreCorrect()
        {
            // Arrange
            var expected = new List<BigInteger> {0, 1, 7, 2, 5, 8, 16, 3, 19, 6};

            // Act
            var firstTenElements = new List<BigInteger>();
            using (var enumerator = _sequence.Sequence.GetEnumerator())
            {
                for (int i = 0; i < 10; i++)
                {
                    enumerator.MoveNext();
                    firstTenElements.Add(enumerator.Current);
                }
            }

            // Assert
            Assert.AreEqual(expected, firstTenElements);
        }

        [Test]
        public void ElementAtIndex50_IsCorrect()
        {
            // Arrange
            BigInteger expectedResult = 112;

            // Act
            BigInteger result;
            using (var enumerator = _sequence.Sequence.GetEnumerator())
            {
                for (int i = 0; i <= 50; i++)
                {
                    enumerator.MoveNext();
                }

                result = enumerator.Current;
            }

            // Assert
            Assert.AreEqual(expectedResult, result);
        }

        [Test]
        public void ElementAtIndex100_IsCorrect()
        {
            // Arrange
            BigInteger expectedResult = 25;

            // Act
            BigInteger result;
            using (var enumerator = _sequence.Sequence.GetEnumerator())
            {
                for (int i = 0; i <= 100; i++)
                {
                    enumerator.MoveNext();
                }

                result = enumerator.Current;
            }

            // Assert
            Assert.AreEqual(expectedResult, result);
        }

        [Test]
        public void ElementAtIndex200_IsCorrect()
        {
            // Arrange
            BigInteger expectedResult = 68;

            // Act
            BigInteger result;
            using (var enumerator = _sequence.Sequence.GetEnumerator())
            {
                for (int i = 0; i <= 200; i++)
                {
                    enumerator.MoveNext();
                }

                result = enumerator.Current;
            }

            // Assert
            Assert.AreEqual(expectedResult, result);
        }

        [Test]
        public void ElementAtIndex500_IsCorrect()
        {
            // Arrange
            BigInteger expectedResult = 99;

            // Act
            BigInteger result;
            using (var enumerator = _sequence.Sequence.GetEnumerator())
            {
                for (int i = 0; i <= 500; i++)
                {
                    enumerator.MoveNext();
                }

                result = enumerator.Current;
            }

            // Assert
            Assert.AreEqual(expectedResult, result);
        }
    }
}