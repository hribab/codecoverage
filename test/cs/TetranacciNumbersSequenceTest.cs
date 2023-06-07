using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class TetranacciNumbersSequenceTests
{
    [Fact]
    public void Sequence_Valid()
    {
        // Arrange
        var tetranacciSequence = new TetranacciNumbersSequence();
        var expectedFirstTen =
            new List<BigInteger> {1, 1, 1, 1, 4, 7, 13, 24, 44, 81};

        // Act
        var actualFirstTen = tetranacciSequence.Sequence.Take(10).ToList();

        // Assert
        Assert.Equal(expectedFirstTen, actualFirstTen);
    }

    [Fact]
    public void Sequence_ContinuesCorrectly()
    {
        // Arrange
        var tetranacciSequence = new TetranacciNumbersSequence();
        var expectedNextFive =
            new List<BigInteger> {149, 274, 504, 927, 1705};

        // Act
        var actualNextFive = tetranacciSequence.Sequence.Skip(10).Take(5).ToList();

        // Assert
        Assert.Equal(expectedNextFive, actualNextFive);
    }

    [Fact]
    public void Sequence_20Elements_Valid()
    {
        // Arrange
        var tetranacciSequence = new TetranacciNumbersSequence();
        var expectedFirstTwenty =
            new List<BigInteger>
            {
                1, 1, 1, 1, 4, 7, 13, 24, 44, 81,
                149, 274, 504, 927, 1705, 3136, 5768, 10609, 19513, 35890
            };

        // Act
        var actualFirstTwenty = tetranacciSequence.Sequence.Take(20).ToList();

        // Assert
        Assert.Equal(expectedFirstTwenty, actualFirstTwenty);
    }

    [Fact]
    public void Sequence_StartsOne()
    {
        // Arrange
        var tetranacciSequence = new TetranacciNumbersSequence();

        // Act
        var firstElement = tetranacciSequence.Sequence.First();

        // Assert
        Assert.Equal(BigInteger.One, firstElement);
    }

    [Fact]
    public void Sequence_SecondElementOne()
    {
        // Arrange
        var tetranacciSequence = new TetranacciNumbersSequence();

        // Act
        var secondElement = tetranacciSequence.Sequence.Skip(1).First();

        // Assert
        Assert.Equal(BigInteger.One, secondElement);
    }
}