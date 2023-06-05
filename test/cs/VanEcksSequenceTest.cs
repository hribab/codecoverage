using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

public class VanEcksSequenceTests
{
    [Fact]
    public void VanEcksSequence_First5Elements()
    {
        // Arrange
        var vanEcksSequence = new VanEcksSequence();

        // Act
        var first5Elements = vanEcksSequence.Sequence.Take(5).ToList();

        // Assert
        Assert.Equal(new List<BigInteger> { 0, 0, 1, 0, 2 }, first5Elements);
    }

    [Fact]
    public void VanEcksSequence_First10Elements()
    {
        // Arrange
        var vanEcksSequence = new VanEcksSequence();

        // Act
        var first10Elements = vanEcksSequence.Sequence.Take(10).ToList();

        // Assert
        Assert.Equal(new List<BigInteger> { 0, 0, 1, 0, 2, 0, 2, 2, 1, 6 }, first10Elements);
    }

    [Fact]
    public void VanEcksSequence_ElementAtIndex20()
    {
        // Arrange
        var vanEcksSequence = new VanEcksSequence();

        // Act
        var elementAtIndex20 = vanEcksSequence.Sequence.Skip(19).First();

        // Assert
        Assert.Equal((BigInteger)17, elementAtIndex20);
    }

    [Fact]
    public void VanEcksSequence_ElementAtIndex50()
    {
        // Arrange
        var vanEcksSequence = new VanEcksSequence();

        // Act
        var elementAtIndex50 = vanEcksSequence.Sequence.Skip(49).First();

        // Assert
        Assert.Equal((BigInteger)25, elementAtIndex50);
    }

    [Fact]
    public void VanEcksSequence_ElementAtIndex100()
    {
        // Arrange
        var vanEcksSequence = new VanEcksSequence();

        // Act
        var elementAtIndex100 = vanEcksSequence.Sequence.Skip(99).First();

        // Assert
        Assert.Equal((BigInteger)112, elementAtIndex100);
    }
}