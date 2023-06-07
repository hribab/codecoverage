using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class GolombsSequenceTests
{
    private readonly GolombsSequence _sequence;

    public GolombsSequenceTests()
    {
        _sequence = new GolombsSequence();
    }

    [Fact]
    public void TestFirstFiveSequenceValues()
    {
        // Arrange
        var expectedSequence = new List<BigInteger> { 1, 2, 2, 3, 3 };

        // Act
        var sequence = _sequence.Sequence.Take(5).ToList();

        // Assert
        Assert.Equal(expectedSequence, sequence);
    }

    [Fact]
    public void TestFirstTenSequenceValues()
    {
        // Arrange
        var expectedSequence = new List<BigInteger> { 1, 2, 2, 3, 3, 4, 4, 4, 5, 5 };

        // Act
        var sequence = _sequence.Sequence.Take(10).ToList();

        // Assert
        Assert.Equal(expectedSequence, sequence);
    }

    [Fact]
    public void TestFirstFifteenSequenceValues()
    {
        // Arrange
        var expectedSequence = new List<BigInteger> { 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6 };

        // Act
        var sequence = _sequence.Sequence.Take(15).ToList();

        // Assert
        Assert.Equal(expectedSequence, sequence);
    }

    [Fact]
    public void TestFirstTwentySequenceValues()
    {
        // Arrange
        var expectedSequence = new List<BigInteger> { 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8 };

        // Act
        var sequence = _sequence.Sequence.Take(20).ToList();

        // Assert
        Assert.Equal(expectedSequence, sequence);
    }

    [Fact]
    public void TestFirstTwentyFiveSequenceValues()
    {
        // Arrange
        var expectedSequence = new List<BigInteger> { 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 9 };

        // Act
        var sequence = _sequence.Sequence.Take(25).ToList();

        // Assert
        Assert.Equal(expectedSequence, sequence);
    }
}