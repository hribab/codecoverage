using System;
using Xunit;
using Algorithms.Numeric.Series;

namespace Algorithms.Tests
{
    public class MaclaurinTests
    {
        [Fact]
        public void TestExp_Int()
        {
            // Arrange
            double x = 1;
            int n = 10;

            // Act 
            double result = Maclaurin.Exp(x, n);

            // Assert
            Assert.Equal(Math.Exp(x), result, 5);
        }

        [Fact]
        public void TestExp_Double()
        {
            // Arrange
            double x = 1;
            double error = 0.00001;

            // Act 
            double result = Maclaurin.Exp(x, error);

            // Assert
            Assert.Equal(Math.Exp(x), result, 5);
        }

        [Fact]
        public void TestSin_Int()
        {
            // Arrange
            double x = 1;
            int n = 10;

            // Act
            double result = Maclaurin.Sin(x, n);

            // Assert
            Assert.Equal(Math.Sin(x), result, 5);
        }

        [Fact]
        public void TestSin_Double()
        {
            // Arrange
            double x = 1;
            double error = 0.00001;

            // Act
            double result = Maclaurin.Sin(x, error);

            // Assert
            Assert.Equal(Math.Sin(x), result, 5);
        }

        [Fact]
        public void TestCos_Int()
        {
            // Arrange
            double x = 1;
            int n = 10;

            // Act
            double result = Maclaurin.Cos(x, n);

            // Assert
            Assert.Equal(Math.Cos(x), result, 5);
        }

        [Fact]
        public void TestCos_Double()
        {
            // Arrange
            double x = 1;
            double error = 0.00001;

            // Act
            double result = Maclaurin.Cos(x, error);

            // Assert
            Assert.Equal(Math.Cos(x), result, 5);
        }

        [Fact]
        public void TestExp_InvalidError_ThrowsArgumentException()
        {
            // Arrange
            double x = 1;
            double error = -0.5;

            // Act and Assert
            Assert.Throws<ArgumentException>(() => Maclaurin.Exp(x, error));
        }

        [Fact]
        public void TestSin_InvalidError_ThrowsArgumentException()
        {
            // Arrange
            double x = 1;
            double error = -0.5;

            // Act and Assert
            Assert.Throws<ArgumentException>(() => Maclaurin.Sin(x, error));
        }

        [Fact]
        public void TestCos_InvalidError_ThrowsArgumentException()
        {
            // Arrange
            double x = 1;
            double error = -0.5;

            // Act and Assert
            Assert.Throws<ArgumentException>(() => Maclaurin.Cos(x, error));
        }
    }
}