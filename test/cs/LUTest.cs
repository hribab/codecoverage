using System;
using NUnit.Framework;
using Algorithms.Numeric.Decomposition;

namespace Algorithms.Tests.Numeric.Decomposition
{
    public class LuTests
    {
        [Test]
        public void Decompose_MatrixNotSquare_ThrowsArgumentException()
        {
            var sourceMatrix = new[,] { { 1.0, 2.0 }, { 3.0, 4.0 }, { 5.0, 6.0 } };

            Assert.Throws<ArgumentException>(() => Lu.Decompose(sourceMatrix));
        }

        [Test]
        public void Decompose_SquareMatrix_ReturnsCorrectLowerAndUpperMatrices()
        {
            // Arrange
            var sourceMatrix = new[,] { { 4.0, 3.0 }, { 6.0, 3.0 } };
            var expectedLower = new[,] { { 1.0, 0.0 }, { 1.5, 1.0 } };
            var expectedUpper = new[,] { { 4.0, 3.0 }, { 0.0, -1.5 } };

            // Act
            (double[,] L, double[,] U) result = Lu.Decompose(sourceMatrix);

            // Assert
            CollectionAssert.AreEqual(expectedLower, result.L);
            CollectionAssert.AreEqual(expectedUpper, result.U);
        }

        [Test]
        public void Eliminate_MatrixNotSquare_ThrowsArgumentException()
        {
            var matrix = new[,] { { 1.0, 2.0 }, { 3.0, 4.0 }, { 5.0, 6.0 } };
            var coefficients = new[] { 1.0, 2.0, 3.0 };

            Assert.Throws<ArgumentException>(() => Lu.Eliminate(matrix, coefficients));
        }

        [Test]
        public void Eliminate_ValidMatrixAndCoefficients_ReturnsCorrectSolution()
        {
            // Arrange
            var matrix = new[,] { { 3.0, 2.0 }, { 1.0, -1.0 } };
            var coefficients = new[] { 2.0, 3.0 };
            var expectedSolution = new[] { 1.0, -2.0 };
            
            // Act
            double[] result = Lu.Eliminate(matrix, coefficients);

            // Assert
            CollectionAssert.AreEqual(expectedSolution, result);
        }

        [Test]
        public void Eliminate_ValidMatrixAndCoefficients2_ReturnsCorrectSolution()
        {
            // Arrange
            var matrix = new[,] { { 4.0, 3.0 }, { 6.0, 3.0 } };
            var coefficients = new[] { 10.0, 12.0 };
            var expectedSolution = new[] { 3.0, -2.0 };

            // Act
            double[] result = Lu.Eliminate(matrix, coefficients);

            // Assert
            CollectionAssert.AreEqual(expectedSolution, result);
        }
    }
}