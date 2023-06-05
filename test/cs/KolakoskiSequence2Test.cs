using System.Collections.Generic;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class KolakoskiSequence2Tests
{
    [Fact]
    public void TestFirstTenElements()
    {
        // Arrange
        var kolakoskiSequence = new KolakoskiSequence2();
        var expected = new List<BigInteger> { 1, 2, 2, 1, 1, 2, 1, 2, 2, 1 };

        // Act
        var result = kolakoskiSequence.Sequence;

        // Assert
        Assert.Equal(expected, GetStringFromEnumerator(result, 10));
    }

    [Fact]
    public void TestFifteenElements()
    {
        // Arrange
        var kolakoskiSequence = new KolakoskiSequence2();
        var expected = new List<BigInteger> { 1, 2, 2, 1, 1, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2 };

        // Act
        var result = kolakoskiSequence.Sequence;

        // Assert
        Assert.Equal(expected, GetStringFromEnumerator(result, 15));
    }

    [Fact]
    public void TestTwentiethElement()
    {
        // Arrange
        var kolakoskiSequence = new KolakoskiSequence2();
        var expectedResult = new BigInteger(2);

        // Act
        var result = kolakoskiSequence.Sequence;
        var actualResult = GetElementFromEnumerator(result, 20);

        // Assert
        Assert.Equal(expectedResult, actualResult);
    }

    [Fact]
    public void TestThirtiethElement()
    {
        // Arrange
        var kolakoskiSequence = new KolakoskiSequence2();
        var expectedResult = new BigInteger(2);

        // Act
        var result = kolakoskiSequence.Sequence;
        var actualResult = GetElementFromEnumerator(result, 30);

        // Assert
        Assert.Equal(expectedResult, actualResult);
    }

    [Fact]
    public void TestFourtiethElement()
    {
        // Arrange
        var kolakoskiSequence = new KolakoskiSequence2();
        var expectedResult = new BigInteger(1);

        // Act
        var result = kolakoskiSequence.Sequence;
        var actualResult = GetElementFromEnumerator(result, 40);

        // Assert
        Assert.Equal(expectedResult, actualResult);
    }

    private List<BigInteger> GetStringFromEnumerator(IEnumerable<BigInteger> sequence, int count)
    {
        var resultList = new List<BigInteger>();
        IEnumerator<BigInteger> enumerator = sequence.GetEnumerator();
        for (var i = 0; i < count; ++i)
        {
            enumerator.MoveNext();
            resultList.Add(enumerator.Current);
        }
        return resultList;
    }

    private BigInteger GetElementFromEnumerator(IEnumerable<BigInteger> sequence, int index)
    {
        IEnumerator<BigInteger> enumerator = sequence.GetEnumerator();
        for (var i = 0; i < index; ++i)
        {
            enumerator.MoveNext();
        }
        return enumerator.Current;
    }
}