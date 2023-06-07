using System;
using Xunit;
using Algorithms.LinearAlgebra.Distances;

namespace ManhattanTests
{
    public class ManhattanUnitTests
    {
        [Fact]
        public void TestDistance_ForTwoDimensionalEqualPoints_ReturnsZero()
        {
            // Arrange
            double[] point1 = { 0, 0 };
            double[] point2 = { 0, 0 };

            // Act
            double result = Manhattan.Distance(point1, point2);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void TestDistance_ForTwoDimensionalDifferentPoints_ReturnsManhattanDistance()
        {
            // Arrange
            double[] point1 = { 1, 2 };
            double[] point2 = { 4, 6 };

            // Act
            double result = Manhattan.Distance(point1, point2);

            // Assert
            Assert.Equal(7, result);
        }

        [Fact]
        public void TestDistance_ForThreeDimensionalDifferentPoints_ReturnsManhattanDistance()
        {
            // Arrange
            double[] point1 = { 1, 2, 3 };
            double[] point2 = { 4, 6, 9 };

            // Act
            double result = Manhattan.Distance(point1, point2);

            // Assert
            Assert.Equal(13, result);
        }

        [Fact]
        public void TestDistance_ForNegativeDimensionalPoints_ReturnsManhattanDistance()
        {
            // Arrange
            double[] point1 = { -1, 2, -3 };
            double[] point2 = { 4, -6, 9 };

            // Act
            double result = Manhattan.Distance(point1, point2);

            // Assert
            Assert.Equal(23, result);
        }

        [Fact]
        public void TestDistance_ForDifferentLengthPoints_ThrowsArgumentException()
        {
            // Arrange
            double[] point1 = { 1, 2 };
            double[] point2 = { 1, 2, 3 };

            // Act
            Exception ex = Assert.Throws<ArgumentException>(() => Manhattan.Distance(point1, point2));

            // Assert
            Assert.Equal("Both points should have the same dimensionality", ex.Message);
        }
    }
}