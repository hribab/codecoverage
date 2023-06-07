using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Graph.MinimumSpanningTree;
using DataStructures.DisjointSet;

[TestClass]
public class KruskalTests
{
    // Tests for Solve with adjacency matrix
    [TestMethod]
    public void Solve_adjacencyMatrix_SingleNodeGraph()
    {
        // Arrange
        float[,] adjacencyMatrix = new float[,] { { float.PositiveInfinity } };

        // expected MST
        float[,] expectedMST = new float[,] { { float.PositiveInfinity } };

        // Act
        float[,] mst = Kruskal.Solve(adjacencyMatrix);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }

    [TestMethod]
    public void Solve_adjacencyMatrix_TwoNodesGraph()
    {
        // Arrange
        float[,] adjacencyMatrix = new float[,] { { float.PositiveInfinity, 1 },
                                                  { 1, float.PositiveInfinity } };

        // expected MST
        float[,] expectedMST = new float[,] { { float.PositiveInfinity, 1 },
                                              { 1, float.PositiveInfinity } };

        // Act
        float[,] mst = Kruskal.Solve(adjacencyMatrix);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }

    [TestMethod]
    public void Solve_adjacencyMatrix_ThreeNodesGraph()
    {
        // Arrange
        float[,] adjacencyMatrix = new float[,] { { float.PositiveInfinity, 1, 2 },
                                                  { 1, float.PositiveInfinity, 3 },
                                                  { 2, 3, float.PositiveInfinity } };

        // expected MST
        float[,] expectedMST = new float[,] { { float.PositiveInfinity, 1, 2 },
                                              { 1, float.PositiveInfinity, float.PositiveInfinity },
                                              { 2, float.PositiveInfinity, float.PositiveInfinity } };

        // Act
        float[,] mst = Kruskal.Solve(adjacencyMatrix);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }

    [TestMethod]
    public void Solve_adjacencyMatrix_InvalidMatrix()
    {
        // Arrange
        float[,] adjacencyMatrix = new float[,] { { float.PositiveInfinity, 1 },
                                                  { 2, float.PositiveInfinity } };

        // Act and Assert
        Assert.ThrowsException<ArgumentException>(() => Kruskal.Solve(adjacencyMatrix));
    }

    [TestMethod]
    public void Solve_adjacencyMatrix_ComplexGraph()
    {
        // Arrange
        float[,] adjacencyMatrix = new float[,] { { float.PositiveInfinity, 4, 1, 5, 8, float.PositiveInfinity, float.PositiveInfinity },
                                                  { 4, float.PositiveInfinity, 3, float.PositiveInfinity, 10, 2, float.PositiveInfinity },
                                                  { 1, 3, float.PositiveInfinity, 6, float.PositiveInfinity, 7, 9 },
                                                  { 5, float.PositiveInfinity, 6, float.PositiveInfinity, float.PositiveInfinity, 12, float.PositiveInfinity },
                                                  { 8, 10, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, 1 },
                                                  { float.PositiveInfinity, 2, 7, 12, float.PositiveInfinity, float.PositiveInfinity, 6 },
                                                  { float.PositiveInfinity, float.PositiveInfinity, 9, float.PositiveInfinity, 1, 6, float.PositiveInfinity } };

        // expected MST
        float[,] expectedMST = new float[,] { { float.PositiveInfinity, 4, 1, 5, 8, float.PositiveInfinity, float.PositiveInfinity },
                                              { 4, float.PositiveInfinity, 3, float.PositiveInfinity, float.PositiveInfinity, 2, float.PositiveInfinity },
                                              { 1, 3, float.PositiveInfinity, 6, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity },
                                              { 5, float.PositiveInfinity, 6, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity },
                                              { 8, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, 1 },
                                              { float.PositiveInfinity, 2, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, 6 },
                                              { float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, 1, 6, float.PositiveInfinity } };

        // Act
        float[,] mst = Kruskal.Solve(adjacencyMatrix);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }

    // Tests for Solve with adjacency list
    [TestMethod]
    public void Solve_adjacencyList_SingleNodeGraph()
    {
        // Arrange
        var adjacencyList = new Dictionary<int, float>[] { new Dictionary<int, float>() };

        // expected MST
        var expectedMST = new Dictionary<int, float>[] { new Dictionary<int, float>() };

        // Act
        var mst = Kruskal.Solve(adjacencyList);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }

    [TestMethod]
    public void Solve_adjacencyList_TwoNodesGraph()
    {
        // Arrange
        var adjacencyList = new Dictionary<int, float>[] { new Dictionary<int, float> { { 1, 1 } },
                                                           new Dictionary<int, float> { { 0, 1 } }};

        // expected MST
        var expectedMST = new Dictionary<int, float>[] { new Dictionary<int, float> { { 1, 1 } },
                                                         new Dictionary<int, float> { { 0, 1 } }};
                                                          
        // Act
        var mst = Kruskal.Solve(adjacencyList);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }

    [TestMethod]
    public void Solve_adjacencyList_ThreeNodesGraph()
    {
        // Arrange
        var adjacencyList = new Dictionary<int, float>[] { new Dictionary<int, float> { { 1, 1 }, { 2, 2 } },
                                                           new Dictionary<int, float> { { 0, 1 }, { 2, 3 } },
                                                           new Dictionary<int, float> { { 0, 2 }, { 1, 3 } }};

        // expected MST
        var expectedMST = new Dictionary<int, float>[] { new Dictionary<int, float> { { 1, 1 }, { 2, 2 } },
                                                         new Dictionary<int, float> { { 0, 1 } },
                                                         new Dictionary<int, float> { { 0, 2 } }};
                                                          
        // Act
        var mst = Kruskal.Solve(adjacencyList);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }

    [TestMethod]
    public void Solve_adjacencyList_InvalidGraph()
    {
        // Arrange
        var adjacencyList = new Dictionary<int, float>[] { new Dictionary<int, float> { { 1, 1 } },
                                                           new Dictionary<int, float> { { 0, 2 } }};

        // Act and Assert
        Assert.ThrowsException<ArgumentException>(() => Kruskal.Solve(adjacencyList));
    }

    [TestMethod]
    public void Solve_adjacencyList_ComplexGraph()
    {
        // Arrange
        var adjacencyList = new Dictionary<int, float>[] { new Dictionary<int, float> { { 1, 4 }, { 2, 1 }, { 3, 5 }, { 4, 8 }},
                                                           new Dictionary<int, float> { { 0, 4 }, { 2, 3 }, { 5, 2 }},
                                                           new Dictionary<int, float> { { 0, 1 }, { 1, 3 }, { 3, 6 }, { 5, 7 }, { 6, 9 }},
                                                           new Dictionary<int, float> { { 0, 5 }, { 2, 6 }, { 5, 12 }},
                                                           new Dictionary<int, float> { { 0, 8 }, { 1, 10 }, { 6, 1 }},
                                                           new Dictionary<int, float> { { 1, 2 }, { 2, 7 }, { 3, 12 }, { 6, 6 }},
                                                           new Dictionary<int, float> { { 2, 9 }, { 4, 1 }, { 5, 6 }}};

        // expected MST
        var expectedMST = new Dictionary<int, float>[] { new Dictionary<int, float> { { 1, 4 }, { 2, 1 }, { 3, 5 }, { 4, 8 }},
                                                         new Dictionary<int, float> { { 0, 4 }, { 2, 3 }, { 5, 2 }},
                                                         new Dictionary<int, float> { { 0, 1 }, { 1, 3 }, { 3, 6 }},
                                                         new Dictionary<int, float> { { 0, 5 }, { 2, 6 }},
                                                         new Dictionary<int, float> { { 0, 8 }, { 6, 1 }},
                                                         new Dictionary<int, float> { { 1, 2 }, { 6, 6 }},
                                                         new Dictionary<int, float> { { 4, 1 }, { 5, 6 }}};
                                                          
        // Act
        var mst = Kruskal.Solve(adjacencyList);

        // Assert
        CollectionAssert.AreEqual(expectedMST, mst);
    }
}