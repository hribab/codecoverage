using System.Collections.Generic;
using System.Drawing;
using System.Numerics;
using Xunit;
using Algorithms.Other;

namespace UnitTests
{
    public class KochSnowflakeTests
    {
        [Fact]
        public void IterateTest_InitialVectors_ExpectedResult()
        {
            // Arrange
            List<Vector2> initialVectors = new List<Vector2>
            {
                new Vector2(0, 0),
                new Vector2(1, 0),
                new Vector2(0.5f, 0.8660254f),
                new Vector2(0, 0)
            };
            List<Vector2> expectedResult = new List<Vector2>
            {
                new Vector2(0, 0),
                new Vector2(0.3333333f, 0),
                new Vector2(0.5f, 0.288675134f),
                new Vector2(0.6666667f, 0),
                new Vector2(1, 0),
                new Vector2(0.8333333f, 0.288675134f),
                new Vector2(0.6666667f, 0.5773503f),
                new Vector2(0.8333333f, 0.288675134f),
                new Vector2(0.5f, 0.8660254f),
                new Vector2(0.3333333f, 0.5773503f),
                new Vector2(0.1666667f, 0.288675134f),
                new Vector2(0, 0)
            };

            // Act
            List<Vector2> result = KochSnowflake.Iterate(initialVectors, 1);

            // Assert
            Assert.Equal(expectedResult.Count, result.Count);

            for (int i = 0; i < expectedResult.Count; i++)
            {
                Assert.Equal(expectedResult[i], result[i], 5);
            }
        }

        [Fact]
        public void IterateTest_EmptyInitialVectors_ExpectedEmptyResult()
        {
            // Arrange
            List<Vector2> initialVectors = new List<Vector2>();

            // Act
            List<Vector2> result = KochSnowflake.Iterate(initialVectors, 1);

            // Assert
            Assert.Empty(result);
        }

        [Fact]
        public void IterateTest_ZeroSteps_ExpectedSameVectors()
        {
            // Arrange
            List<Vector2> initialVectors = new List<Vector2>
            {
                new Vector2(0, 0),
                new Vector2(1, 0),
                new Vector2(0.5f, 0.8660254f),
                new Vector2(0, 0)
            };

            // Act
            List<Vector2> result = KochSnowflake.Iterate(initialVectors, 0);

            // Assert
            Assert.Equal(initialVectors.Count, result.Count);

            for (int i = 0; i < initialVectors.Count; i++)
            {
                Assert.Equal(initialVectors[i], result[i], 5);
            }
        }

        [Fact]
        public void GetKochSnowflakeTest_ValidBitmapWidthSteps_ExpectedNotNull()
        {
            // Arrange
            int bitmapWidth = 600;
            int steps = 5;

            // Act
            Bitmap result = KochSnowflake.GetKochSnowflake(bitmapWidth, steps);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public void GetKochSnowflakeTest_InvalidBitmapWidth_ExpectedArgumentOutOfRangeException()
        {
            // Arrange
            int invalidBitmapWidth = -600;
            int steps = 5;

            // Act & Assert
            Assert.Throws<System.ArgumentOutOfRangeException>(() => KochSnowflake.GetKochSnowflake(invalidBitmapWidth, steps));
        }
    }
}