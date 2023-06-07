using System;
using System.Collections.Generic;
using Xunit;
using Algorithms.Strings;

public class RabinKarpTests
{
    [Fact]
    public void FindAllOccurrences_TestEmptyText()
    {
        // Test with empty text and non-empty pattern
        string text = "";
        string pattern = "test";
        List<int> expected = new List<int>();
        List<int> result = RabinKarp.FindAllOccurrences(text, pattern);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void FindAllOccurrences_TestEmptyPattern()
    {
        // Test with empty pattern and non-empty text
        string text = "this is a sample text";
        string pattern = "";
        List<int> expected = new List<int>();
        List<int> result = RabinKarp.FindAllOccurrences(text, pattern);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void FindAllOccurrences_TestExactMatch()
    {
        // Test with same text and pattern
        string text = "thisisasampletext";
        string pattern = "thisisasampletext";
        List<int> expected = new List<int> { 0 };
        List<int> result = RabinKarp.FindAllOccurrences(text, pattern);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void FindAllOccurrences_TestSingleOccurrence()
    {
        // Test with single occurrence of pattern
        string text = "thisisatestforsingleoccurrence";
        string pattern = "single";
        List<int> expected = new List<int> { 15 };
        List<int> result = RabinKarp.FindAllOccurrences(text, pattern);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void FindAllOccurrences_TestMultipleOccurrences()
    {
        // Test with multiple occurrences of pattern
        string text = "thisisatestformultipleoccurrencesmultiple";
        string pattern = "multiple";
        List<int> expected = new List<int> { 15, 32 };
        List<int> result = RabinKarp.FindAllOccurrences(text, pattern);
        Assert.Equal(expected, result);
    }
}