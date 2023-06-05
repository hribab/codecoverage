using System;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class MatchstickTriangleSequenceTest
{
    [Fact]
    public void Test_MatchstickTriangleSequence()
    {
        // Arrange
        var matchstickTriangleSequence = new MatchstickTriangleSequence();
        var expectedResult = new[] {BigInteger.Zero, BigInteger.One, BigInteger.Parse("5"), BigInteger.Parse("13"), BigInteger.Parse("27")};

        // Act
        var actualResult = matchstickTriangleSequence.Sequence.GetEnumerator();

        // Assert
        for (var i = 0; i < 5; i++)
        {
            actualResult.MoveNext();
            Assert.Equal(expectedResult[i], actualResult.Current);
        }
    }

    [Fact]
    public void Test_MatchstickTriangleSequence_LargeValues()
    {
        // Arrange
        var matchstickTriangleSequence = new MatchstickTriangleSequence();
        var largeValue = BigInteger.Parse("123456789");
        var expectedLargeResult = BigInteger.Parse("946921438585956860");

        // Act
        var actualResult = matchstickTriangleSequence.Sequence.GetEnumerator();

        // Move iterator to largeValue-th element
        for (var i = BigInteger.Zero; i < largeValue; i++)
        {
            actualResult.MoveNext();
        }

        // Assert
        Assert.Equal(expectedLargeResult, actualResult.Current);
    }

    [Fact]
    public void Test_MatchstickTriangleSequence_NextValues()
    {
        // Arrange
        var matchstickTriangleSequence = new MatchstickTriangleSequence();
        var expectedResult = new[] {BigInteger.Parse("43"), BigInteger.Parse("61"), BigInteger.Parse("85"), BigInteger.Parse("133"), BigInteger.Parse("181")};

        // Act
        var actualResult = matchstickTriangleSequence.Sequence.GetEnumerator();

        // Move iterator to expectedResult[0]-th element
        for (var i = BigInteger.Zero; i < BigInteger.Parse("43"); i++)
        {
            actualResult.MoveNext();
        }

        // Assert
        for (var i = 0; i < 5; i++)
        {
            actualResult.MoveNext();
            Assert.Equal(expectedResult[i], actualResult.Current);
        }
    }

    [Fact]
    public void Test_MatchstickTriangleSequence_SmallNegativeValues()
    {
        // Arrange
        var matchstickTriangleSequence = new MatchstickTriangleSequence();
        var smallNegativeValue = BigInteger.Parse("-5");
        var expectedSmallNegativeResult = new[] {BigInteger.Parse("-57"), BigInteger.Parse("-5"), BigInteger.Zero, BigInteger.One, BigInteger.Parse("5")};

        // Act
        var actualResult = matchstickTriangleSequence.Sequence.GetEnumerator();

        // Move iterator to smallNegativeValue-th element
        for (var i = BigInteger.Zero; i < smallNegativeValue; i++)
        {
            actualResult.MoveNext();
        }

        // Assert
        for (var i = 0; i < 5; i++)
        {
            actualResult.MoveNext();
            Assert.Equal(expectedSmallNegativeResult[i], actualResult.Current);
        }
    }

    [Fact]
    public void Test_MatchstickTriangleSequence_LargeNegativeValues()
    {
        // Arrange
        var matchstickTriangleSequence = new MatchstickTriangleSequence();
        var largeNegativeValue = BigInteger.Parse("-123456789");
        var expectedLargeNegativeResult = BigInteger.Parse("-215022631879875838");

        // Act
        var actualResult = matchstickTriangleSequence.Sequence.GetEnumerator();

        // Move iterator to largeNegativeValue-th element
        for (var i = BigInteger.Zero; i < largeNegativeValue; i++)
        {
            actualResult.MoveNext();
        }

        // Assert
        Assert.Equal(expectedLargeNegativeResult, actualResult.Current);
    }
}