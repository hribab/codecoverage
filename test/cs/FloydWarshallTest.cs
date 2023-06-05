using System;
using Xunit;
using Algorithms.Graph;
using DataStructures.Graph;

public class FloydWarshallTest
{
    [Fact]
    public void Run_Test1()
    {
        // Arrange
        var graph = new DirectedWeightedGraph<string>();
        graph.AddVertex("A");
        graph.AddVertex("B");
        graph.AddVertex("C");
        graph.AddEdge("A", "B", 7);
        graph.AddEdge("B", "C", 1);
        graph.AddEdge("A", "C", 9);

        var fw = new FloydWarshall<string>();

        // Act
        var distances = fw.Run(graph);

        // Assert
        Assert.Equal(0, distances[0, 0]);
        Assert.Equal(7, distances[0, 1]);
        Assert.Equal(8, distances[0, 2]);
        Assert.Equal(double.PositiveInfinity, distances[1, 0]);
        Assert.Equal(0, distances[1, 1]);
        Assert.Equal(1, distances[1, 2]);
        Assert.Equal(double.PositiveInfinity, distances[2, 0]);
        Assert.Equal(double.PositiveInfinity, distances[2, 1]);
        Assert.Equal(0, distances[2, 2]);
    }

    [Fact]
    public void Run_Test2()
    {
        // Arrange
        var graph = new DirectedWeightedGraph<string>();
        graph.AddVertex("A");
        graph.AddVertex("B");

        var fw = new FloydWarshall<string>();

        // Act
        var distances = fw.Run(graph);

        // Assert
        Assert.Equal(0, distances[0, 0]);
        Assert.Equal(double.PositiveInfinity, distances[0, 1]);
        Assert.Equal(double.PositiveInfinity, distances[1, 0]);
        Assert.Equal(0, distances[1, 1]);
    }

    [Fact]
    public void Run_Test3()
    {
        // Arrange
        var graph = new DirectedWeightedGraph<string>();
        graph.AddVertex("A");

        var fw = new FloydWarshall<string>();

        // Act
        var distances = fw.Run(graph);

        // Assert
        Assert.Equal(0, distances[0, 0]);
    }

    [Fact]
    public void Run_Test4()
    {
        // Arrange
        var graph = new DirectedWeightedGraph<string>();
        graph.AddVertex("A");
        graph.AddVertex("B");
        graph.AddVertex("C");
        graph.AddEdge("A", "B", 1);
        graph.AddEdge("B", "C", 1);
        graph.AddEdge("C", "A", 1);

        var fw = new FloydWarshall<string>();

        // Act
        var distances = fw.Run(graph);

        // Assert
        Assert.Equal(0, distances[0, 0]);
        Assert.Equal(1, distances[0, 1]);
        Assert.Equal(2, distances[0, 2]);
        Assert.Equal(2, distances[1, 0]);
        Assert.Equal(0, distances[1, 1]);
        Assert.Equal(1, distances[1, 2]);
        Assert.Equal(1, distances[2, 0]);
        Assert.Equal(2, distances[2, 1]);
        Assert.Equal(0, distances[2, 2]);
    }

    [Fact]
    public void Run_Test5()
    {
        // Arrange
        var graph = new DirectedWeightedGraph<string>();
        graph.AddVertex("A");
        graph.AddVertex("B");
        graph.AddVertex("C");
        graph.AddEdge("A", "B", 5);
        graph.AddEdge("B", "C", 6);
        graph.AddEdge("A", "C", 2);

        var fw = new FloydWarshall<string>();

        // Act
        var distances = fw.Run(graph);

        // Assert
        Assert.Equal(0, distances[0, 0]);
        Assert.Equal(5, distances[0, 1]);
        Assert.Equal(2, distances[0, 2]);
        Assert.Equal(double.PositiveInfinity, distances[1, 0]);
        Assert.Equal(0, distances[1, 1]);
        Assert.Equal(6, distances[1, 2]);
        Assert.Equal(double.PositiveInfinity, distances[2, 0]);
        Assert.Equal(double.PositiveInfinity, distances[2, 1]);
        Assert.Equal(0, distances[2, 2]);
    }
}