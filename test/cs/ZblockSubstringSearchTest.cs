using System;
using Xunit;
using Algorithms.Strings;

namespace Algorithms.Tests.Strings
{
    public class ZblockSubstringSearchTests
    {
        [Fact]
        public void FindSubstring_ContainsPatternOnce_ReturnsOne()
        {
            // Arrange
            string pattern = "abc";
            string text = "defghijklmabcnopqrstuvwxyz";

            // Act
            int result = ZblockSubstringSearch.FindSubstring(pattern, text);

            // Assert
            Assert.Equal(1, result);
        }

        [Fact]
        public void FindSubstring_ContainsPatternMultipleTimes_ReturnsCorrectCount()
        {
            // Arrange
            string pattern = "abc";
            string text = "abcdefghijklmabcnopqrstuvwxyzabc";

            // Act
            int result = ZblockSubstringSearch.FindSubstring(pattern, text);

            // Assert
            Assert.Equal(3, result);
        }

        [Fact]
        public void FindSubstring_PatternNotInText_ReturnsZero()
        {
            // Arrange
            string pattern = "xyz";
            string text = "abcdefghijklmabcnopqrstuvwxyzabc";

            // Act
            int result = ZblockSubstringSearch.FindSubstring(pattern, text);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void FindSubstring_EmptyPattern_ReturnsZero()
        {
            // Arrange
            string pattern = "";
            string text = "abcdefghijklmabcnopqrstuvwxyzabc";

            // Act
            int result = ZblockSubstringSearch.FindSubstring(pattern, text);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void FindSubstring_EmptyText_ReturnsZero()
        {
            // Arrange
            string pattern = "abc";
            string text = "";

            // Act
            int result = ZblockSubstringSearch.FindSubstring(pattern, text);

            // Assert
            Assert.Equal(0, result);
        }
    }
}