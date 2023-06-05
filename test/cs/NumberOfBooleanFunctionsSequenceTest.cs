using System.Collections.Generic;
using System.Numerics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Sequences;

namespace Algorithms.Tests.Sequences
{
    [TestClass]
    public class NumberOfBooleanFunctionsSequenceTests
    {
        [TestMethod]
        public void TestFirstFiveElements()
        {
            // Arrange
            var sequence = new NumberOfBooleanFunctionsSequence();
            var expectedResults = new List<BigInteger> { 2, 4, 16, 256, 65536 };

            // Act
            var actualResults = sequence.Sequence.GetEnumerator();
            actualResults.MoveNext();

            // Assert
            for (int i = 0; i < 5; i++)
            {
                Assert.AreEqual(expectedResults[i], actualResults.Current);
                actualResults.MoveNext();
            }
        }

        [TestMethod]
        public void TestNonExponentialSequence()
        {
            // Arrange
            var sequence = new NumberOfBooleanFunctionsSequence();

            // Act
            var actualResults = sequence.Sequence.GetEnumerator();
            actualResults.MoveNext();

            var previousResult = actualResults.Current;
            actualResults.MoveNext();

            // Assert
            while (previousResult < BigInteger.One << (1 << 10)) // Check up to 2^(2^10)
            {
                var newResult = actualResults.Current;

                Assert.IsFalse(IsPowerOfTwo(newResult));
                Assert.IsFalse(IsPowerOfTwo(newResult - 1));

                var factors = Factor(newResult);
                Assert.IsFalse(factors.Count == 1 && factors[0] == 2);

                previousResult = newResult;
                actualResults.MoveNext();
            }
        }

        [TestMethod]
        public void TestPowerOfTwoSize()
        {
            // Arrange
            var sequence = new NumberOfBooleanFunctionsSequence();

            // Act
            var actualResults = sequence.Sequence.GetEnumerator();
            actualResults.MoveNext();

            var previousResult = actualResults.Current;
            actualResults.MoveNext();

            // Assert
            while (previousResult < BigInteger.One << (1 << 10)) // Check up to 2^(2^10)
            {
                var newResult = actualResults.Current;
                Assert.AreEqual(previousResult * previousResult, newResult);

                previousResult = newResult;
                actualResults.MoveNext();
            }
        }

        private bool IsPowerOfTwo(BigInteger value)
        {
            if (value <= 0) return false;
            return (value & (value - 1)) == 0;
        }

        private List<BigInteger> Factor(BigInteger value)
        {
            var factors = new List<BigInteger>();

            for (BigInteger i = 2; i * i <= value; i++)
            {
                while (value % i == 0)
                {
                    value /= i;
                    factors.Add(i);
                }
            }

            if (value > 1)
            {
                factors.Add(value);
            }

            return factors;
        }
    }
}