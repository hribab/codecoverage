using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class KummerNumbersSequenceTests
{
    [Fact]
    public void TestKummerNumbersSequence()
    {
        // Arrange
        var kummerNumbersSequence = new KummerNumbersSequence();

        // Act
        var sequence = kummerNumbersSequence.Sequence.Take(5).ToList();

        // Assert
        var expectedSequence = new List<BigInteger> {1, 5, 29, 209, 2309};
        Assert.Equal(expectedSequence, sequence);
    }

    [Fact]
    public void TestKummerNumbersSequence_FirstElement()
    {
        // Arrange
        var kummerNumbersSequence = new KummerNumbersSequence();

        // Act
        var firstElement = kummerNumbersSequence.Sequence.First();

        // Assert
        Assert.Equal(1, firstElement);
    }

    [Fact]
    public void TestKummerNumbersSequence_SecondElement()
    {
        // Arrange
        var kummerNumbersSequence = new KummerNumbersSequence();

        // Act
        var secondElement = kummerNumbersSequence.Sequence.Skip(1).First();

        // Assert
        Assert.Equal(5, secondElement);
    }

    [Fact]
    public void TestKummerNumbersSequence_ThirdElement()
    {
        // Arrange
        var kummerNumbersSequence = new KummerNumbersSequence();

        // Act
        var thirdElement = kummerNumbersSequence.Sequence.Skip(2).First();

        // Assert
        Assert.Equal(29, thirdElement);
    }

    [Fact]
    public void TestKummerNumbersSequence_FourthElement()
    {
        // Arrange
        var kummerNumbersSequence = new KummerNumbersSequence();

        // Act
        var fourthElement = kummerNumbersSequence.Sequence.Skip(3).First();

        // Assert
        Assert.Equal(209, fourthElement);
    }
}