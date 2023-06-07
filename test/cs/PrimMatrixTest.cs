using System;
using Xunit;
using Algorithms.Graph.MinimumSpanningTree;

namespace Algorithms.Tests
{
    public class PrimMatrixTests
    {
        [Fact]
        public void Solve_MST_SampleTest1()
        {
            // Arrange
            float[,] inputMatrix = new float[4, 4]
            {
                {float.PositiveInfinity, 1, 4, 2},
                {1, float.PositiveInfinity, 3, 0},
                {4, 3, float.PositiveInfinity, 1},
                {2, 0, 1, float.PositiveInfinity}
            };

            float[,] expectedMST = new float[4, 4]
            {
                {float.PositiveInfinity, 1, float.PositiveInfinity, 2},
                {1, float.PositiveInfinity, 3, 0},
                {float.PositiveInfinity, 3, float.PositiveInfinity, 1},
                {2, 0, 1, float.PositiveInfinity}
            };

            // Act
            float[,] result = PrimMatrix.Solve(inputMatrix, 0);

            // Assert
            Assert.Equal(result, expectedMST);
        }

        [Fact]
        public void Solve_MST_SampleTest2()
        {
            // Arrange
            float[,] inputMatrix = new float[4, 4]
            {
                {float.PositiveInfinity, 2, 4, 1},
                {2, float.PositiveInfinity, 3, 5},
                {4, 3, float.PositiveInfinity, 3},
                {1, 5, 3, float.Positive_INFINITY}
            };

            float[,] expectedMST = new float[4, 4]
            {
                {float.PositiveInfinity, 2, float.PositiveInfinity, 1},
                {2, float.PositiveInfinity, 3, float.PositiveInfinity},
                {float.PositiveInfinity, 3, float.PositiveInfinity, 3},
                {1, float.PositiveInfinity, 3, float.PositiveInfinity}
            };

            // Act
            float[,] result = PrimMatrix.Solve(inputMatrix, 2);

            // Assert
            Assert.Equal(result, expectedMST);
        }

        [Fact]
        public void Solve_InvalidMatrix_NotSquare()
        {
            // Arrange
            float[,] invalidMatrix = new float[3, 4]
            {
                {float.PositiveInfinity, 1, 4, 2},
                {1, float.PositiveInfinity, 3, 0},
                {4, 3, float.PositiveInfinity, 1}
            };

            // Act and Assert
            Assert.Throws<ArgumentException>(() => PrimMatrix.Solve(invalidMatrix, 0));
        }

        [Fact]
        public void Solve_InvalidMatrix_NotSymmetric()
        {
            // Arrange
            float[,] invalidMatrix = new float[4, 4]
            {
                {float.PositiveInfinity, 1, 4, 2},
                {2, float.PositiveInfinity, 3, 0},
                {4, 3, float.PositiveInfinity, 1},
                {2, 0, 1, float.PositiveInfinity}
            };

            // Act and Assert
            Assert.Throws<ArgumentException>(() => PrimMatrix.Solve(invalidMatrix, 0));
        }

        [Fact]
        public void Solve_InvalidMatrix_NotConnected()
        {
            // Arrange
            float[,] invalidMatrix = new float[4, 4]
            {
                {float.PositiveInfinity, 1, 4, float.PositiveInfinity},
                {1, float.PositiveInfinity, 3, 0},
                {4, 3, float.PositiveInfinity, 1},
                {float.PositiveInfinity, 0, 1, float.PositiveInfinity}
            };

            // Act and Assert
            Assert.Throws<ArgumentException>(() => PrimMatrix.Solve(invalidMatrix, 0));
        }
    }
}