using System;
using Xunit;
using Algorithms.Strings;
using System.Collections.Generic;

public class NaiveStringSearchTests
{
    // Test Case 1, 2, and 3: Testing for different patterns in the content.
    [Theory]
    [InlineData("The quick brown fox jumps over the lazy dog", "fox", new int[] { 16 })]
    [InlineData("abracadabra", "abra", new int[] { 0, 7 })]
    [InlineData("aaaaab aaaab ", "aaaab", new int[] { 1, 7})]
    public void NaiveSearch_PatternFoundInContent_ReturnsIndices(string content, string pattern, int[] expectedIndices)
    {
        // Act
        var result = NaiveStringSearch.NaiveSearch(content, pattern);

        // Assert
        Assert.Equal(expectedIndices, result);
    }

    // Test Case 4: Testing for non-existent pattern in the content.
    [Fact]
    public void NaiveSearch_PatternNotInContent_ReturnsEmptyArray()
    {
        // Arrange
        string content = "The quick brown fox jumps over the lazy dog";
        string pattern = "cat";

        // Act
        var result = NaiveStringSearch.NaiveSearch(content, pattern);

        // Assert
        Assert.Empty(result);
    }

    // Test Case 5: Testing for empty pattern in the content.
    [Fact]
    public void NaiveSearch_EmptyPattern_ReturnsEmptyArray()
    {
        // Arrange
        string content = "The quick brown fox jumps over the lazy dog";
        string pattern = "";

        // Act
        var result = NaiveStringSearch.NaiveSearch(content, pattern);

        // Assert
        Assert.Empty(result);
    }

    // Test Case 6: Testing for pattern larger than content.
    [Fact]
    public void NaiveSearch_PatternLargerThanContent_ReturnsEmptyArray()
    {
        // Arrange
        string content = "The quick brown fox";
        string pattern = "The quick brown fox jumps over the lazy dog";

        // Act
        var result = NaiveStringSearch.NaiveSearch(content, pattern);

        // Assert
        Assert.Empty(result);
    }
}