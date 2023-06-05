using System;
using Xunit;
using Algorithms.Strings;

namespace JaroWinklerDistanceTests
{
    public class JaroWinklerDistanceTests
    {
        // Test case 1: Exact match
        [Fact]
        public void Calculate_ExactMatch_ReturnsZero()
        {
            // Arrange
            string s1 = "example";
            string s2 = "example";

            // Act
            double result = JaroWinklerDistance.Calculate(s1, s2);

            // Assert
            Assert.Equal(0, result);
        }

        // Test case 2: No similarity
        [Fact]
        public void Calculate_NoSimilarity_ReturnsOne()
        {
            // Arrange
            string s1 = "example";
            string s2 = "qwerty";

            // Act
            double result = JaroWinklerDistance.Calculate(s1, s2);

            // Assert
            Assert.Equal(1, result);
        }

        // Test case 3: Some similarity
        [Fact]
        public void Calculate_SomeSimilarity_ReturnsDistance()
        {
            // Arrange
            string s1 = "example";
            string s2 = "exxmpl";

            // Act
            double result = JaroWinklerDistance.Calculate(s1, s2);

            // Assert
            Assert.Equal(0.1333333333333333, result, 9);
        }

        // Test case 4: Different scaling factor
        [Fact]
        public void Calculate_DifferentScalingFactor_ReturnsDifferentDistance()
        {
            // Arrange
            string s1 = "example";
            string s2 = "exxmpl";
            double scalingFactor = 0.2;

            // Act
            double result = JaroWinklerDistance.Calculate(s1, s2, scalingFactor);

            // Assert
            Assert.Equal(0.2666666666666667, result, 9);
        }

        // Test case 5: Empty strings
        [Fact]
        public void Calculate_EmptyStrings_ReturnsZero()
        {
            // Arrange
            string s1 = "";
            string s2 = "";

            // Act
            double result = JaroWinklerDistance.Calculate(s1, s2);

            // Assert
            Assert.Equal(0, result);
        }
    }
}