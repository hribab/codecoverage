using System;
using System.Numerics;
using Algorithms.ModularArithmetic;
using Xunit;

namespace ModularMultiplicativeInverseTests
{
    public class ModularMultiplicativeInverseTest
    {
        [Fact]
        public void Compute_Long_ReturnsValidInverse_TestCase1()
        {
            // Arrange
            // a = 3, n = 7, GCD(a, n) = 1, inverse(3) = 5 (5*3 = 15; 15%7 = 1)
            long a = 3;
            long n = 7;

            // Act
            long inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

            // Assert
            Assert.Equal(5, inverseOfA);
        }

        [Fact]
        public void Compute_Long_ReturnsValidInverse_TestCase2()
        {
            // Arrange
            // a = 6, n = 9, GCD(a, n) = 1, inverse(6) = 6 (6*6 = 36; 36%9 = 1)
            long a = 6;
            long n = 9;

            // Act
            long inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

            // Assert
            Assert.Equal(6, inverseOfA);
        }

        [Fact]
        public void Compute_Long_ReturnsValidInverse_TestCase3()
        {
            // Arrange
            // a = 171, n = 221, GCD(a, n) = 1, inverse(171) = 112 (171*112 = 19152; 19152%221 = 1)
            long a = 171;
            long n = 221;

            // Act
            long inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

            // Assert
            Assert.Equal(112, inverseOfA);
        }

        [Fact]
        public void Compute_Long_ReturnsValidInverse_TestCase4()
        {
            // Arrange
            // a = 21, n = 25, GCD(a, n) = 1, inverse(21) = 16 (21*16 = 336; 336%25 = 1)
            long a = 21;
            long n = 25;

            // Act
            long inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

            // Assert
            Assert.Equal(16, inverseOfA);
        }

        [Fact]
        public void Compute_Long_Exception_TestCase1()
        {
            // Arrange
            // a = 4, n = 8, GCD(a, n) != 1, throws ArithmeticException
            long a = 4;
            long n = 8;

            // Act & Assert
            Assert.Throws<ArithmeticException>(() => ModularMultiplicativeInverse.Compute(a, n));
        }

        [Fact]
        public void Compute_BigInteger_ReturnsValidInverse_TestCase1()
        {
            // Arrange
            // a = 3, n = 7, GCD(a, n) = 1, inverse(3) = 5 (5*3 = 15; 15%7 = 1)
            BigInteger a = 3;
            BigInteger n = 7;

            // Act
            BigInteger inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

            // Assert
            Assert.Equal((BigInteger)5, inverseOfA);
        }

      [Fact]
      public void Compute_BigInteger_ReturnsValidInverse_TestCase2()
      {
          // Arrange
          // a = 6, n = 9, GCD(a, n) = 1, inverse(6) = 6 (6*6 = 36; 36%9 = 1)
          BigInteger a = 6;
          BigInteger n = 9;

          // Act
          BigInteger inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

          // Assert
          Assert.Equal((BigInteger)6, inverseOfA);
      }

      [Fact]
      public void Compute_BigInteger_ReturnsValidInverse_TestCase3()
      {
          // Arrange
          // a = 171, n = 221, GCD(a, n) = 1, inverse(171) = 112 (171*112 = 19152; 19152%221 = 1)
          BigInteger a = 171;
          BigInteger n = 221;

          // Act
          BigInteger inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

          // Assert
          Assert.Equal((BigInteger)112, inverseOfA);
      }

      [Fact]
      public void Compute_BigInteger_ReturnsValidInverse_TestCase4()
      {
          // Arrange
          // a = 21, n = 25, GCD(a, n) = 1, inverse(21) = 16 (21*16 = 336; 336%25 = 1)
          BigInteger a = 21;
          BigInteger n = 25;

          // Act
          BigInteger inverseOfA = ModularMultiplicativeInverse.Compute(a, n);

          // Assert
          Assert.Equal((BigInteger)16, inverseOfA);
      }

      [Fact]
      public void Compute_BigInteger_Exception_TestCase1()
      {
          // Arrange
          // a = 4, n = 8, GCD(a, n) != 1, throws ArithmeticException
          BigInteger a = 4;
          BigInteger n = 8;

          // Act & Assert
          Assert.Throws<ArithmeticException>(() => ModularMultiplicativeInverse.Compute(a, n));
      }
    }
}