using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

public class OnesCountingSequenceTests
{
    [Fact]
    public void Sequence_InitialSets_CorrectValues()
    {
        // Arrange
        var sequence = new OnesCountingSequence();

        // Act
        IEnumerable<BigInteger> initialSet = sequence.Sequence.Take(6);

        // Assert
        Assert.Equal(new BigInteger[] { 0, 1, 1, 2, 1, 2 }, initialSet);
    }

    [Fact]
    public void Sequence_ElementAtIndex_CorrectValue()
    {
        // Arrange
        var sequence = new OnesCountingSequence();

        // Act
        BigInteger elementAtIndex12 = sequence.Sequence.ElementAt(12);
        BigInteger elementAtIndex20 = sequence.Sequence.ElementAt(20);
        BigInteger elementAtIndex50 = sequence.Sequence.ElementAt(50);

        // Assert
        Assert.Equal(new BigInteger(2), elementAtIndex12);
        Assert.Equal(new BigInteger(3), elementAtIndex20);
        Assert.Equal(new BigInteger(4), elementAtIndex50);
    }

    [Fact]
    public void Sequence_ValidSequence_RecursionDepth()
    {
        // Arrange
        var sequence = new OnesCountingSequence();

        // Act
        IEnumerable<BigInteger> upToDepth3 = sequence.Sequence.Take(16);

        // Assert
        Assert.Equal(new BigInteger[] { 0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4 }, upToDepth3);
    }

    [Fact]
    public void Sequence_ValidSequence_UpToIndex30()
    {
        // Arrange
        var sequence = new OnesCountingSequence();

        // Act
        IEnumerable<BigInteger> upToIndex30 = sequence.Sequence.Take(30);

        // Assert
        Assert.Equal(new BigInteger[] { 0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4 }, upToIndex30);
    }

    [Fact]
    public void Sequence_ValidSequence_UpToIndex50()
    {
        // Arrange
        var sequence = new OnesCountingSequence();

        // Act
        IEnumerable<BigInteger> upToIndex50 = sequence.Sequence.Take(50);

        // Assert
        Assert.Equal(new BigInteger[] { 0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5 }, upToIndex50);
    }
}