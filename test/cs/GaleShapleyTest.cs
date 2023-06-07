using System;
using System.Collections.Generic;
using Xunit;
using Algorithms.Problems.StableMarriage;

public class GaleShapleyTests
{
    [Fact]
    public void Test_Match_Successful()
    {
        // Arrange
        var proposers = new GaleShapley.Proposer[]
        {
            new GaleShapley.Proposer {Name = "A"},
            new GaleShapley.Proposer {Name = "B"},
            new GaleShapley.Proposer {Name = "C"},
        };

        var accepters = new GaleShapley.Accepter[]
        {
            new GaleShapley.Accepter {Name = "X"},
            new GaleShapley.Accepter {Name = "Y"},
            new GaleShapley.Accepter {Name = "Z"},
        };

        // Add preferences
        proposers[0].PreferenceOrder = new LinkedList<GaleShapley.Accepter>(new[] {accepters[0], accepters[1], accepters[2]});
        proposers[1].PreferenceOrder = new LinkedList<GaleShapley.Accepter>(new[] {accepters[2], accepters[1], accepters[0]});
        proposers[2].PreferenceOrder = new LinkedList<GaleShapley.Accepter>(new[] {accepters[1], accepters[2], accepters[0]});

        accepters[0].AddPreference(proposers[0]);
        accepters[0].AddPreference(proposers[1]);
        accepters[0].AddPreference(proposers[2]);

        accepters[1].AddPreference(proposers[2]);
        accepters[1].AddPreference(proposers[0]);
        accepters[1].AddPreference(proposers[1]);

        accepters[2].AddPreference(proposers[2]);
        accepters[2].AddPreference(proposers[1]);
        accepters[2].AddPreference(proposers[0]);

        // Act
        GaleShapley.Match(proposers, accepters);

        // Assert
        Assert.Equal(accepters[0], proposers[0].EngagedTo);
        Assert.Equal(proposers[0], accepters[0].EngagedTo);
        Assert.Equal(accepters[2], proposers[1].EngagedTo);
        Assert.Equal(proposers[1], accepters[2].EngagedTo);
        Assert.Equal(accepters[1], proposers[2].EngagedTo);
        Assert.Equal(proposers[2], accepters[1].EngagedTo);
    }

    [Fact]
    public void Test_Match_DifferentLengths()
    {
        // Arrange
        var proposers = new GaleShapley.Proposer[]
        {
            new GaleShapley.Proposer {Name = "A"},
        };

        var accepters = new GaleShapley.Accepter[]
        {
            new GaleShapley.Accepter {Name = "X"},
            new GaleShapley.Accepter {Name = "Y"},
        };

        // Act & Assert
        Assert.Throws<ArgumentException>(() => GaleShapley.Match(proposers, accepters));
    }

    [Fact]
    public void Test_Match_EmptyArrays()
    {
        // Arrange
        var proposers = Array.Empty<GaleShapley.Proposer>();
        var accepters = Array.Empty<GaleShapley.Accepter>();

        // Act & Assert
        GaleShapley.Match(proposers, accepters); // Should not throw
    }

    [Fact]
    public void Test_Match_SinglePair()
    {
        // Arrange
        var proposers = new GaleShapley.Proposer[]
        {
            new GaleShapley.Proposer {Name = "A"},
        };

        var accepters = new GaleShapley.Accepter[]
        {
            new GaleShapley.Accepter {Name = "X"},
        };

        // Add preferences
        proposers[0].PreferenceOrder = new LinkedList<GaleShapley.Accepter>(new[] {accepters[0]});
        accepters[0].AddPreference(proposers[0]);

        // Act
        GaleShapley.Match(proposers, accepters);

        // Assert
        Assert.Equal(accepters[0], proposers[0].EngagedTo);
        Assert.Equal(proposers[0], accepters[0].EngagedTo);
    }

    [Fact]
    public void Test_Match_UnorderedPreferences()
    {
        // Arrange
        var proposers = new GaleShapley.Proposer[]
        {
            new GaleShapley.Proposer {Name = "A"},
            new GaleShapley.Proposer {Name = "B"},
            new GaleShapley.Proposer {Name = "C"},
        };

        var accepters = new GaleShapley.Accepter[]
        {
            new GaleShapley.Accepter {Name = "X"},
            new GaleShapley.Accepter {Name = "Y"},
            new GaleShapley.Accepter {Name = "Z"},
        };

        // Add preferences
        proposers[0].PreferenceOrder = new LinkedList<GaleShapley.Accepter>(new[] {accepters[1], accepters[0], accepters[2]});
        proposers[1].PreferenceOrder = new LinkedList<GaleShapley.Accepter>(new[] {accepters[2], accepters[0], accepters[1]});
        proposers[2].PreferenceOrder = new LinkedList<GaleShapley.Accepter>(new[] {accepters[0], accepters[1], accepters[2]});

        accepters[0].AddPreference(proposers[2]);
        accepters[0].AddPreference(proposers[0]);
        accepters[0].AddPreference(proposers[1]);

        accepters[1].AddPreference(proposers[1]);
        accepters[1].AddPreference(proposers[2]);
        accepters[1].AddPreference(proposers[0]);

        accepters[2].AddPreference(proposers[0]);
        accepters[2].AddPreference(proposers[1]);
        accepters[2].AddPreference(proposers[2]);

        // Act
        GaleShapley.Match(proposers, accepters);

        // Assert
        Assert.Equal(accepters[0], proposers[2].EngagedTo);
        Assert.Equal(proposers[2], accepters[0].EngagedTo);
        Assert.Equal(accepters[1], proposers[0].EngagedTo);
        Assert.Equal(proposers[0], accepters[1].EngagedTo);
        Assert.Equal(accepters[2], proposers[1].EngagedTo);
        Assert.Equal(proposers[1], accepters[2].EngagedTo);
    }
}