using System;
using DataStructures.Graph;
using Algorithms.Graph;
using Xunit;

namespace Algorithms.Tests
{
    public class GraphSearchTests
    {
        private class GraphSearchMock : IGraphSearch<int>
        {
            public void VisitAll(IDirectedWeightedGraph<int> graph, Vertex<int> startVertex, Action<Vertex<int>>? action = null)
            {
                // Mock implementation
            }
        }

        [Fact]
        public void VisitAll_StartVertex_ActionNotNull()
        {
            // Arrange
            var graphSearch = new GraphSearchMock();
            var graph = new DirectedWeightedGraph<int>();
            var vertex1 = new Vertex<int>(1);
            var vertex2 = new Vertex<int>(2);
            graph.AddEdge(vertex1, vertex2, 1);
            bool actionCalled = false;

            // Act
            graphSearch.VisitAll(graph, vertex1, v => actionCalled = true);

            // Assert
            Assert.True(actionCalled);
        }

        [Fact]
        public void VisitAll_StartVertex_ActionNull()
        {
            // Arrange
            var graphSearch = new GraphSearchMock();
            var graph = new DirectedWeightedGraph<int>();
            var vertex1 = new Vertex<int>(1);
            var vertex2 = new Vertex<int>(2);
            graph.AddEdge(vertex1, vertex2, 1);

            // Act
            graphSearch.VisitAll(graph, vertex1, null);

            // Assert
            // This test case does not have any failing/assertion side-effect; it checks that the code can be executed without throwing an exception
        }

        [Fact]
        public void VisitAll_GraphWithMultipleVertices_ActionNotNull()
        {
            // Arrange
            var graphSearch = new GraphSearchMock();
            var graph = new DirectedWeightedGraph<int>();
            var vertex1 = new Vertex<int>(1);
            var vertex2 = new Vertex<int>(2);
            var vertex3 = new Vertex<int>(3);
            graph.AddEdge(vertex1, vertex2, 1);
            graph.AddEdge(vertex1, vertex3, 2);
            int visitedVertices = 0;

            // Act
            graphSearch.VisitAll(graph, vertex1, v => visitedVertices++);

            // Assert
            Assert.Equal(3, visitedVertices);
        }

        [Fact]
        public void VisitAll_GraphWithWeightedEdges_ActionNotNull()
        {
            // Arrange
            var graphSearch = new GraphSearchMock();
            var graph = new DirectedWeightedGraph<int>();
            var vertex1 = new Vertex<int>(1);
            var vertex2 = new Vertex<int>(2);
            graph.AddEdge(vertex1, vertex2, 5);
            int totalEdgeWeight = 0;

            // Act
            graphSearch.VisitAll(graph, vertex1, v => totalEdgeWeight += graph.GetEdgeWeight(vertex1, v));

            // Assert
            Assert.Equal(5, totalEdgeWeight);
        }

        [Fact]
        public void VisitAll_GraphWithCycle_ActionNotNull()
        {
            // Arrange
            var graphSearch = new GraphSearchMock();
            var graph = new DirectedWeightedGraph<int>();
            var vertex1 = new Vertex<int>(1);
            var vertex2 = new Vertex<int>(2);
            var vertex3 = new Vertex<int>(3);
            graph.AddEdge(vertex1, vertex2, 1);
            graph.AddEdge(vertex2, vertex3, 2);
            graph.AddEdge(vertex3, vertex1, 3);
            int visitedVertices = 0;

            // Act
            graphSearch.VisitAll(graph, vertex1, v => visitedVertices++);

            // Assert
            Assert.Equal(3, visitedVertices);
        }
    }
}