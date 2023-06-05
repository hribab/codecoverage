using System.Collections.Generic;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class TetrahedralSequenceTests
{
    [Fact]
    public void Test_Sequence()
    {
        // Arrange
        var expected = new List<BigInteger>
        {
            0, 1, 4, 10, 20, 35, 56, 84, 120, 165
        };

        var sequence = new TetrahedralSequence();

        // Act
        var actual = sequence.Sequence.GetEnumerator();
        
        // Assert
        for (int i = 0; i < 10; i++)
        {
            actual.MoveNext();
            Assert.Equal(expected[i], actual.Current);
        }
    }

    [Fact]
    public void Test_Sequence6()
    {
        // Arrange
        var expected = new BigInteger(56);

        var sequence = new TetrahedralSequence();

        // Act
        var actual = sequence.Sequence.GetEnumerator();
        
        // Assert
        for (int i = 0; i < 6; i++)
        {
            actual.MoveNext();
        }
        Assert.Equal(expected, actual.Current);
    }
    
    [Fact]
    public void Test_Sequence15()
    {
        // Arrange
        var expected = new BigInteger(680);

        var sequence = new TetrahedralSequence();

        // Act
        var actual = sequence.Sequence.GetEnumerator();
        
        // Assert
        for (int i = 0; i < 15; i++)
        {
            actual.MoveNext();
        }
        Assert.Equal(expected, actual.Current);
    }
    
    [Fact]
    public void Test_Sequence0()
    {
        // Arrange
        var expected = new BigInteger(0);

        var sequence = new TetrahedralSequence();

        // Act
        var actual = sequence.Sequence.GetEnumerator();
        actual.MoveNext();
        
        // Assert
        Assert.Equal(expected, actual.Current);
    }
    
    [Fact]
    public void Test_Sequence20()
    {
        // Arrange
        var expected = new BigInteger(1540);

        var sequence = new TetrahedralSequence();

        // Act
        var actual = sequence.Sequence.GetEnumerator();
        
        // Assert
        for (int i = 0; i < 20; i++)
        {
            actual.MoveNext();
        }
        Assert.Equal(expected, actual.Current);
    }
}