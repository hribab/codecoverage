using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

public class PrimorialNumbersSequenceTests
{
    private readonly PrimorialNumbersSequence _sut = new();
    
    [Fact]
    public void Sequence_FirstTenElements_AreCorrect()
    {
        // Arrange
        var expected = new List<BigInteger> { 1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870 };

        // Act
        var actual = _sut.Sequence.Take(10).ToList();

        // Assert
        Assert.Equal(expected, actual);
    }

    [Fact]
    public void Sequence_ElementAtIndex20_IsCorrect()
    {
        // Arrange
        const int index = 20;
        BigInteger expectedResult = BigInteger.Parse("5354228880");

        // Act
        BigInteger actualResult = _sut.Sequence.ElementAt(index);
        
        // Assert
        Assert.Equal(expectedResult, actualResult);
    }

    [Fact]
    public void Sequence_ElementAtIndex40_IsCorrect()
    {
        // Arrange
        const int index = 40;
        BigInteger expectedResult = BigInteger.Parse("160626866400");

        // Act
        BigInteger actualResult = _sut.Sequence.ElementAt(index);
        
        // Assert
        Assert.Equal(expectedResult, actualResult);
    }

    [Fact]
    public void Sequence_ElementAtIndex60_IsCorrect()
    {
        // Arrange
        const int index = 60;
        BigInteger expectedResult = BigInteger.Parse("203944756084660");

        // Act
        BigInteger actualResult = _sut.Sequence.ElementAt(index);
        
        // Assert
        Assert.Equal(expectedResult, actualResult);
    }

    [Fact]
    public void Sequence_ElementAtIndex80_IsCorrect()
    {
        // Arrange
        const int index = 80;
        BigInteger expectedResult = BigInteger.Parse("494737584044213689472")(;

        // Act
        BigInteger actualResult = _sut.Sequence.ElementAt(index);
        
        // Assert
        Assert.Equal(expectedResult, actualResult);
    }
}