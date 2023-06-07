using System.Collections.Generic;
using Xunit;
using Algorithms.Strings;

namespace Algorithms.Strings.Tests
{
    public class KnuthMorrisPrattSearcherTests
    {
        [Fact]
        public void FindIndexes_PatternInString_ReturnsExpectedResult()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string input = "This is a sample text used for testing.";
            string pattern = "sample";

            // Act
            var result = searcher.FindIndexes(input, pattern);

            // Assert
            Assert.Equal(new[] { 10 }, result);
        }

        [Fact]
        public void FindIndexes_PatternNotFound_ReturnsEmpty()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string input = "This is a sample text used for testing.";
            string pattern = "test pattern";

            // Act
            var result = searcher.FindIndexes(input, pattern);

            // Assert
            Assert.Empty(result);
        }

        [Fact]
        public void FindIndexes_RepeatedPattern_ReturnsExpectedResult()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string input = "ABABDABACDABABCABAB";
            string pattern = "ABABCABAB";

            // Act
            var result = searcher.FindIndexes(input, pattern);

            // Assert
            Assert.Equal(new[] { 10 }, result);
        }

        [Fact]
        public void FindIndexes_SingleCharacterPatterns_ReturnsExpectedResult()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string input = "AAAAA";
            string pattern = "A";

            // Act
            var result = searcher.FindIndexes(input, pattern);

            // Assert
            Assert.Equal(new[] { 0, 1, 2, 3, 4 }, result);
        }

        [Fact]
        public void FindIndexes_EmptyInput_ReturnsEmpty()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string input = "";
            string pattern = "pattern";

            // Act
            var result = searcher.FindIndexes(input, pattern);

            // Assert
            Assert.Empty(result);
        }

        [Fact]
        public void FindLongestPrefixSuffixValues_ValidPattern_ReturnsExpectedResult()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string pattern = "ABABCABAB";

            // Act
            var result = searcher.FindLongestPrefixSuffixValues(pattern);

            // Assert
            Assert.Equal(new[] { 0, 0, 1, 2, 0, 1, 2, 3, 4 }, result);
        }

        [Fact]
        public void FindLongestPrefixSuffixValues_RepeatedPattern_ReturnsExpectedResult()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string pattern = "AABAAABAAA";

            // Act
            var result = searcher.FindLongestPrefixSuffixValues(pattern);

            // Assert
            Assert.Equal(new[] { 0, 1, 0, 1, 2, 2, 3, 4, 5 }, result);
        }

        [Fact]
        public void FindLongestPrefixSuffixValues_SingleCharacter_ReturnsExpectedResult()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string pattern = "A";

            // Act
            var result = searcher.FindLongestPrefixSuffixValues(pattern);

            // Assert
            Assert.Equal(new[] { 0 }, result);
        }

        [Fact]
        public void FindLongestPrefixSuffixValues_EmptyPattern_ReturnsEmpty()
        {
            // Arrange
            var searcher = new KnuthMorrisPrattSearcher();
            string pattern = "";

            // Act
            var result = searcher.FindLongestPrefixSuffixValues(pattern);

            // Assert
            Assert.Empty(result);
        }
    }
}