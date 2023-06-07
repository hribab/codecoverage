using System;
using Algorithms.Strings;
using Xunit;

namespace Algorithms.Tests.Strings
{
    public class LevenshteinDistanceTests
    {
        [Fact]
        public void Calculate_EmptyStrings_ReturnsZero()
        {
            // Arrange
            string source = "";
            string target = "";

            // Act
            int result = LevenshteinDistance.Calculate(source, target);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void Calculate_SameStrings_ReturnsZero()
        {
            // Arrange
            string source = "hello";
            string target = "hello";

            // Act
            int result = LevenshteinDistance.Calculate(source, target);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void Calculate_OneEdit_ReturnsOne()
        {
            // Arrange
            string source = "hello";
            string target = "helo";

            // Act
            int result = LevenshteinDistance.Calculate(source, target);

            // Assert
            Assert.Equal(1, result);
        }

        [Fact]
        public void Calculate_OneInsert_ReturnsOne()
        {
            // Arrange
            string source = "hello";
            string target = "sqhello";

            // Act
            int result = LevenshteinDistance.Calculate(source, target);

            // Assert
            Assert.Equal(2, result);
        }

        [Fact]
        public void Calculate_CompletelyDifferentStrings_ReturnsLength()
        {
            // Arrange
            string source = "hello";
            string target = "xyzab";

            // Act
            int result = LevenshteinDistance.Calculate(source, target);

            // Assert
            Assert.Equal(5, result);
        }
    }
}