using System;
using Xunit;
using Algorithms.Numeric;

public class JosephusProblemTests
{
    [Fact]
    public void FindWinner_InvalidStep_ThrowsArgumentException()
    {
        // Arrange
        long n = 5;
        long k = -1;

        // Act & Assert
        Assert.Throws<ArgumentException>(() => JosephusProblem.FindWinner(n, k));
    }

    [Fact]
    public void FindWinner_StepGreaterThanSize_ThrowsArgumentException()
    {
        // Arrange
        long n = 6;
        long k = 8;

        // Act & Assert
        Assert.Throws<ArgumentException>(() => JosephusProblem.FindWinner(n, k));
    }

    [Fact]
    public void FindWinner_BaseCase_ReturnsCorrectResult()
    {
        // Arrange
        long n = 1;
        long k = 1;

        // Act
        long result = JosephusProblem.FindWinner(n, k);

        // Assert
        Assert.Equal(1, result);
    }

    [Fact]
    public void FindWinner_NormalCase_ReturnsCorrectResult()
    {
        // Arrange
        long n = 7;
        long k = 3;

        // Act
        long result = JosephusProblem.FindWinner(n, k);

        // Assert
        Assert.Equal(3, result);
    }

    [Fact]
    public void FindWinner_LargeNumbersCase_ReturnsCorrectResult()
    {
        // Arrange
        long n = 150;
        long k = 21;

        // Act
        long result = JosephusProblem.FindWinner(n, k);

        // Assert
        Assert.Equal(138, result);
    }
}