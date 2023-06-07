using System.Collections.Generic;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class SquaresSequenceTests
{
    [Fact]
    public void TestFirstFiveSquares()
    {
        // Arrange
        var squaresSequence = new SquaresSequence();
        var expectedList = new List<BigInteger> { 0, 1, 4, 9, 16 };

        // Act
        var actualList = new List<BigInteger>();
        using (var enumerator = squaresSequence.Sequence.GetEnumerator())
        {
            for (int i = 0; i < 5; i++)
            {
                enumerator.MoveNext();
                actualList.Add(enumerator.Current);
            }
        }

        // Assert
        Assert.Equal(expectedList, actualList);
    }

    [Fact]
    public void TestSequenceGreaterThanOrEqualZero()
    {
        // Arrange
        var squaresSequence = new SquaresSequence();

        // Act
        var actualList = new List<BigInteger>();
        using (var enumerator = squaresSequence.Sequence.GetEnumerator())
        {
            for (int i = 0; i < 10; i++)
            {
                enumerator.MoveNext();
                actualList.Add(enumerator.Current);
            }
        }

        // Assert
        Assert.All(actualList, n => Assert.True(n >= 0));
    }

    [Fact]
    public void TestSequenceCount()
    {
        // Arrange
        var squaresSequence = new SquaresSequence();

        // Act
        var actualList = new List<BigInteger>();
        using (var enumerator = squaresSequence.Sequence.GetEnumerator())
        {
            for (int i = 0; i < 10; i++)
            {
                enumerator.MoveNext();
                actualList.Add(enumerator.Current);
            }
        }

        // Assert
        Assert.Equal(10, actualList.Count);
    }

    [Fact]
    public void TestSequenceIsSquaredSequence()
    {
        // Arrange
        var squaresSequence = new SquaresSequence();

        // Act
        var actualList = new List<BigInteger>();
        using (var enumerator = squaresSequence.Sequence.GetEnumerator())
        {
            for (int i = 0; i < 10; i++)
            {
                enumerator.MoveNext();
                actualList.Add(enumerator.Current);
            }
        }

        // Assert
        Assert.All(actualList, n => Assert.True(IsSquareNumber(n)));
    }

    [Fact]
    public void TestSequenceDoesNotContainNonSquareValues()
    {
        // Arrange
        var squaresSequence = new SquaresSequence();
        var nonSquareValues = new List<BigInteger> { 2, 3, 5, 42, 99 };

        // Act
        var actualList = new HashSet<BigInteger>();
        using (var enumerator = squaresSequence.Sequence.GetEnumerator())
        {
            for (int i = 0; i < 150; i++)
            {
                enumerator.MoveNext();
                actualList.Add(enumerator.Current);
            }
        }

        // Assert
        Assert.DoesNotContain(nonSquareValues, actualList);
    }

    private static bool IsSquareNumber(BigInteger n)
    {
        var squareRoot = BigInteger.Sqrt(n);
        return squareRoot * squareRoot == n;
    }
}