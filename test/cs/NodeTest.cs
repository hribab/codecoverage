using System;
using Xunit;
using Algorithms.Search.AStar;
using static Algorithms.Search.AStar.NodeState;

public class NodeTests
{
    [Fact]
    public void TotalCost_Calculation_ReturnsCorrectValue()
    {
        // Arrange
        VecN position = new VecN(0, 0);
        Node node = new Node(position, true, 1);
        node.EstimatedCost = 5;
        node.CurrentCost = 7;

        // Act
        double totalCost = node.TotalCost;

        // Assert
        Assert.Equal(12, totalCost);
    }

    [Fact]
    public void CompareTo_ComparingWithNull_ReturnsOne()
    {
        // Arrange
        VecN position = new VecN(0, 0);
        Node node1 = new Node(position, true, 1);

        // Act
        int compareResult = node1.CompareTo(null);

        // Assert
        Assert.Equal(1, compareResult);
    }

    [Fact]
    public void CompareTo_TotalCostsSame_ReturnsZero()
    {
        // Arrange
        VecN position = new VecN(0, 0);
        Node node1 = new Node(position, true, 1);
        Node node2 = new Node(position, true, 1);
        node1.EstimatedCost = 5;
        node1.CurrentCost = 7;
        node2.EstimatedCost = 5;
        node2.CurrentCost = 7;

        // Act
        int compareResult = node1.CompareTo(node2);

        // Assert
        Assert.Equal(0, compareResult);
    }

    [Fact]
    public void CompareTo_TotalCostsDifferent_ReturnsCorrectComparison()
    {
        // Arrange
        VecN position = new VecN(0, 0);
        Node node1 = new Node(position, true, 1);
        Node node2 = new Node(position, true, 1);
        node1.EstimatedCost = 5;
        node1.CurrentCost = 7;
        node2.EstimatedCost = 4;
        node2.CurrentCost = 7;

        // Act
        int compareResult = node1.CompareTo(node2);

        // Assert
        Assert.Equal(1, compareResult);
    }

    [Fact]
    public void Equals_NodesWithSameTotalCostsAndDifferentPositions_ReturnsFalse()
    {
        // Arrange
        VecN position1 = new VecN(0, 0);
        VecN position2 = new VecN(1, 1);
        Node node1 = new Node(position1, true, 1);
        Node node2 = new Node(position2, true, 1);
        node1.EstimatedCost = 5;
        node1.CurrentCost = 7;
        node2.EstimatedCost = 5;
        node2.CurrentCost = 7;

        // Act
        bool equal = node1.Equals(node2);

        // Assert
        Assert.False(equal);
    }

    [Fact]
    public void GetHashCode_DifferentNodesWithSameValues_ReturnsSameHashCode()
    {
        // Arrange
        VecN position = new VecN(0, 0);
        Node node1 = new Node(position, true, 1);
        Node node2 = new Node(position, true, 1);

        // Act
        int hashCode1 = node1.GetHashCode();
        int hashCode2 = node2.GetHashCode();

        // Assert
        Assert.Equal(hashCode1, hashCode2);
    }

    [Fact]
    public void DistanceTo_DifferentNodes_ReturnsExpectedDistance()
    {
        // Arrange
        VecN position1 = new VecN(0, 0);
        VecN position2 = new VecN(3, 4);
        Node node1 = new Node(position1, true, 1);
        Node node2 = new Node(position2, true, 1);

        // Act
        double distance = node1.DistanceTo(node2);

        // Assert
        Assert.Equal(5, distance);
    }
}