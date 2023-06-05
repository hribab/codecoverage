using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace UnitTests
{
    public class LucasNumbersBeginningAt2SequenceTests
    {
        [Fact]
        public void FirstTenValues_AreCorrect()
        {
            // Arrange
            var lucasSequence = new LucasNumbersBeginningAt2Sequence();
            var expectedSequence = new List<BigInteger>{2, 1, 3, 4, 7, 11, 18, 29, 47, 76};
            var enumerator = expectedSequence.GetEnumerator();
            int valuesChecked = 0;

            // Act & Assert
            foreach (var lucasNumber in lucasSequence.Sequence)
            {
                if (valuesChecked >= 10)
                {
                    break;
                }

                enumerator.MoveNext();
                Assert.Equal(enumerator.Current, lucasNumber);
                valuesChecked++;
            }
        }

        [Fact]
        public void ForthValue_FromFirstValue_AreCorrect()
        {
            // Arrange
            var lucasSequence = new LucasNumbersBeginningAt2Sequence();
            BigInteger expectedValue = 4;

            // Act
            int valuesChecked = 0;
            BigInteger actualValue = default(BigInteger);
            foreach (var lucasNumber in lucasSequence.Sequence)
            {
                if (valuesChecked >= 3)
                {
                    actualValue = lucasNumber;
                    break;
                }

                valuesChecked++;
            }

            // Assert
            Assert.Equal(expectedValue, actualValue);
        }

        [Fact]
        public void LucasNumbersConverence_ToPhi()
        {
            // Arrange
            const double phi = 1.618033988749895;
            const int precision = 12;
            var lucasSequence = new LucasNumbersBeginningAt2Sequence();

            // Act
            double ratio = 0;
            int valuesChecked = 0;
            BigInteger previous = default(BigInteger);
            foreach (var lucasNumber in lucasSequence.Sequence)
            {
                if (valuesChecked > 0)
                {
                    ratio = (double)lucasNumber / (double)previous;
                }

                if (valuesChecked > precision)
                {
                    break;
                }

                previous = lucasNumber;
                valuesChecked++;
            }

            // Assert
            Assert.True(Math.Abs(phi - ratio) < 1e-12);
        }

        [Fact]
        public void Sequence_IsInfinite()
        {
            // Arrange
            const int largeCheck = 1_000_000;
            var lucasSequence = new LucasNumbersBeginningAt2Sequence();

            // Act & Assert
            int valuesChecked = 0;
            foreach (var lucasNumber in lucasSequence.Sequence)
            {
                if (valuesChecked >= largeCheck)
                {
                    break;
                }

                valuesChecked++;
            }

            Assert.Equal(largeCheck, valuesChecked);
        }

        [Fact]
        public void RelationshipTo_Fibonacci_AreCorrect()
        {
            // Arrange
            const int valuesCheckedCount = 10;
            var lucasSequence = new LucasNumbersBeginningAt2Sequence();
            var fibonacciSequence = new FibonacciSequence();

            // Act & Assert
            int valuesChecked = 0;
            BigInteger previousLucas = default(BigInteger);
            BigInteger previousTwoFibonacci = default(BigInteger);
            foreach (var lucasNumber in lucasSequence.Sequence)
            {
                if (valuesChecked > 0)
                {
                    BigInteger sumPreviousTwoFibonacci = previousTwoFibonacci + previousLucas;
                    Assert.Equal(sumPreviousTwoFibonacci, lucasNumber);
                }

                if (valuesChecked >= valuesCheckedCount)
                {
                    break;
                }

                previousTwoFibonacci = previousLucas;
                previousLucas = lucasNumber;
                valuesChecked++;
            }
        }
    }
}