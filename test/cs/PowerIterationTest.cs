using System;
using Xunit;
using Algorithms.LinearAlgebra.Eigenvalue;

namespace AlgorithmsTests
{
    public class PowerIterationTests
    {
        [Fact]
        public void Dominant_InvalidSquareMatrix_ThrowsArgumentException()
        {
            // Arrange
            double[,] source = { { 1, 2, 3 }, { 4, 5, 6 } };
            double[] startVector = { 1, 1, 1 };

            // Act, Assert
            Assert.Throws<ArgumentException>(() => PowerIteration.Dominant(source, startVector));
        }

        [Fact]
        public void Dominant_StartVectorSizeMismatch_ThrowsArgumentException()
        {
            // Arrange
            double[,] source = { { 1, 2, 3 }, { 1, 4, 6 }, { 1, 2, 7 } };
            double[] startVector = { 1, 1 };

            // Act, Assert
            Assert.Throws<ArgumentException>(() => PowerIteration.Dominant(source, startVector));
        }

        [Fact]
        public void Dominant_ValidInput_ReturnsEigenValueAndEigenVector()
        {
            // Arrange
            double[,] source = { { 1, 2, 3 }, { 1, 4, 6 }, { 1, 2, 7 } };
            double[] startVector = { 1, 1, 1 };

            // Act
            (double eigenvalue, double[] eigenvector) = PowerIteration.Dominant(source, startVector);

            // Assert
            double expectedEigenvalue = 9.669151583208;
            double[] expectedEigenvector = { 0.306479, 0.527851, 0.793471 };

            Assert.InRange(eigenvalue, expectedEigenvalue - 0.0001, expectedEigenvalue + 0.0001);
            for (int i = 0; i < eigenvector.Length; i++)
            {
                Assert.InRange(eigenvector[i], expectedEigenvector[i] - 0.0001, expectedEigenvector[i] + 0.0001);
            }
        }

        [Fact]
        public void Dominant_WithCustomError_ReturnsEigenValueAndEigenVector()
        {
            // Arrange
            double[,] source = { { 1, 2, 3 }, { 1, 4, 6 }, { 1, 2, 7 } };
            double[] startVector = { 1, 1, 1 };
            double customError = 0.001;

            // Act
            (double eigenvalue, double[] eigenvector) = PowerIteration.Dominant(source, startVector, customError);

            // Assert
            double expectedEigenvalue = 9.669151583208;
            double[] expectedEigenvector = { 0.306479, 0.527851, 0.793471 };

            Assert.InRange(eigenvalue, expectedEigenvalue - 0.1, expectedEigenvalue + 0.1);
            for (int i = 0; i < eigenvector.Length; i++)
            {
                Assert.InRange(eigenvector[i], expectedEigenvector[i] - 0.1, expectedEigenvector[i] + 0.1);
            }
        }

        [Fact]
        public void Dominant_ValidInputWithoutStartVector_ReturnsEigenValueAndEigenVector()
        {
            // Arrange
            double[,] source = { { 1, 2, 3 }, { 1, 4, 6 }, { 1, 2, 7 } };

            // Act
            (double eigenvalue, double[] eigenvector) = PowerIteration.Dominant(source);

            // Assert
            double expectedEigenvalue = 9.669151583208;
            double[] expectedEigenvector = { 0.306479, 0.527851, 0.793471 };

            Assert.InRange(eigenvalue, expectedEigenvalue - 0.0001, expectedEigenvalue + 0.0001);
            for (int i = 0; i < eigenvector.Length; i++)
            {
                Assert.InRange(eigenvector[i], expectedEigenvector[i] - 0.0001, expectedEigenvector[i] + 0.0001);
            }
        }
    }
}