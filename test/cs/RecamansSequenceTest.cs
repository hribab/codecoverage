using System;
using System.Linq;
using Xunit;
using Algorithms.Sequences;
using System.Numerics;

public class RecamansSequenceTests
{
    [Fact]
    public void FirstElementsTest()
    {
        // Arrange
        var sequence = new RecamansSequence().Sequence;
        // Check first 10 elements
        BigInteger[] firstTenElements = { 0, 1, 3, 6, 2, 7, 13, 20, 12, 21 };
        
        // Act
        var result = sequence.Take(10).ToArray();

        // Assert
        Assert.Equal(firstTenElements, result);
    }

    [Fact]
    public void ElementUniquenessTest()
    {
        // Arrange
        var sequence = new RecamansSequence().Sequence;
        int checkUpTo = 50;

        // Act
        var result = sequence.Take(checkUpTo).ToArray();

        // Assert
        for (int i = 0; i < result.Length; i++)
        {
            for (int j = i + 1; j < result.Length; j++)
            {
                Assert.NotEqual(result[i], result[j]);
            }
        }
    }

    [Fact]
    public void PositiveValuesTest()
    {
        // Arrange
        var sequence = new RecamansSequence().Sequence;
        int checkUpTo = 50;

        // Act
        var result = sequence.Take(checkUpTo).ToArray();

        // Assert
        for (int i = 0; i < result.Length; i++)
        {
            Assert.True(result[i] >= 0);
        }
    }

    [Fact]
    public void RecamansPropertyTest()
    {
        // Arrange
        var sequence = new RecamansSequence().Sequence;
        int checkUpTo = 10;

        // Act
        var result = sequence.Take(checkUpTo).ToArray();

        // Assert
        for (int i = 1; i < checkUpTo; i++)
        {
            if (result[i - 1] - i > 0 && !result.Take(i - 1).Contains(result[i - 1] - i))
            {
                Assert.Equal(result[i], result[i - 1] - i);
            }
            else
            {
                Assert.Equal(result[i], result[i - 1] + i);
            }
        }
    }

    [Fact]
    public void IncreasingOrderTest()
    {
        // Arrange
        var sequence = new RecamansSequence().Sequence;
        int checkUpTo = 10;

        // Act
        var result = sequence.Take(checkUpTo).ToArray();

        // Assert
        for (int i = 1; i < checkUpTo; i++)
        {
            Assert.True(result[i] > result[i - 1]);
        }
    }
}