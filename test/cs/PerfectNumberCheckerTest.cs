using System;
using Xunit;
using Algorithms.Numeric;

public class PerfectNumberCheckerTests
{
    [Fact]
    public void IsPerfectNumber_ThrowsArgumentException_WhenNumberIsNegative()
    {
        // Arrange
        var negativeNumber = -1;

        // Act & Assert
        Assert.Throws<ArgumentException>(() => PerfectNumberChecker.IsPerfectNumber(negativeNumber));
    }

    [Fact]
    public void IsPerfectNumber_ReturnsTrue_WhenNumberIsPerfect()
    {
        // Arrange
        var perfectNumber = 6; // 1 + 2 + 3 = 6, so 6 is a perfect number.

        // Act
        var result = PerfectNumberChecker.IsPerfectNumber(perfectNumber);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void IsPerfectNumber_ReturnsFalse_WhenNumberIsNotPerfect()
    {
        // Arrange
        var notPerfectNumber = 10;

        // Act
        var result = PerfectNumberChecker.IsPerfectNumber(notPerfectNumber);

        // Assert
        Assert.False(result);
    }

    [Theory]
    [InlineData(0, false)]
    [InlineData(1, false)]
    [InlineData(2, false)]
    [InlineData(28, true)]
    [InlineData(33550336, true)]
    public void IsPerfectNumber_ReturnsExpectedResult_WhenNumberIsValid(int number, bool expectedResult)
    {
        // Act
        var result = PerfectNumberChecker.IsPerfectNumber(number);

        // Assert
        Assert.Equal(expectedResult, result);
    }
}