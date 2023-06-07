using System.Collections.Generic;
using Xunit;
using DataStructures.Graph;
using Algorithms.Graph;
using System.Linq;

namespace KosarajuTests
{
    public class KosarajuTests
    {
        [Fact]
        public void Visit_Test()
        {
            // Arrange
            var graph = new DirectedWeightedGraph<string>();
            var v1 = new Vertex<string>("A");
            var v2 = new Vertex<string>("B");
            var v3 = new Vertex<string>("C");
            var visited = new HashSet<Vertex<string>>();
            var reversed = new Stack<Vertex<string>>();

            graph.AddEdge(v1, v2);
            graph.AddEdge(v2, v3);

            // Act
            Kosaraju<string>.Visit(v1, graph, visited, reversed);

            // Assert
            Assert.Equal(3, visited.Count);
            Assert.True(visited.Contains(v1));
            Assert.True(visited.Contains(v2));
            Assert.True(visited.Contains(v3));

            Assert.Equal(3, reversed.Count);
            Assert.Equal(v1, reversed.Pop());
            Assert.Equal(v3, reversed.Pop());
            Assert.Equal(v2, reversed.Pop());
        }

        [Fact]
        public void Assign_Test()
        {
            // Arrange
            var graph = new DirectedWeightedGraph<string>();
            var v1 = new Vertex<string>("A");
            var v2 = new Vertex<string>("B");
            var v3 = new Vertex<string>("C");
            var roots = new Dictionary<Vertex<string>, Vertex<string>>();

            graph.AddEdge(v1, v2);
            graph.AddEdge(v2, v3);

            // Act
            Kosaraju<string>.Assign(v1, v1, graph, roots);

            // Assert
            Assert.Equal(3, roots.Count);
            Assert.Equal(v1, roots[v1]);
            Assert.Equal(v1, roots[v2]);
            Assert.Equal(v1, roots[v3]);
        }

        [Fact]
        public void GetRepresentatives_Test()
        {
            // Arrange
            var graph = new DirectedWeightedGraph<string>();
            var v1 = new Vertex<string>("A");
            var v2 = new Vertex<string>("B");
            var v3 = new Vertex<string>("C");

            graph.AddEdge(v1, v2);
            graph.AddEdge(v2, v3);

            // Act
            var representatives = Kosaraju<string>.GetRepresentatives(graph);

            // Assert
            Assert.Equal(3, representatives.Count);
            Assert.Equal(v1, representatives[v1]);
            Assert.Equal(v1, representatives[v2]);
            Assert.Equal(v1, representatives[v3]);
        }

        [Fact]
        public void GetScc_SingleComponent_Test()
        {
            // Arrange
            var graph = new DirectedWeightedGraph<string>();
            var v1 = new Vertex<string>("A");
            var v2 = new Vertex<string>("B");
            var v3 = new Vertex<string>("C");

            graph.AddEdge(v1, v2);
            graph.AddEdge(v2, v3);

            // Act
            var scc = Kosaraju<string>.GetScc(graph);

            // Assert
            Assert.Single(scc);
            Assert.True(scc[0].Contains(v1));
            Assert.True(scc[0].Contains(v2));
            Assert.True(scc[0].Contains(v3));
        }

        [Fact]
        public void GetScc_MultipleComponents_Test()
        {
            // Arrange
            var graph = new DirectedWeightedGraph<string>();
            var v1 = new Vertex<string>("A");
            var v2 = new Vertex<string>("B");
            var v3 = new Vertex<string>("C");

            graph.AddEdge(v1, v2);
            graph.AddEdge(v3, v1);

            // Act
            var scc = Kosaraju<string>.GetScc(graph);

            // Assert
            Assert.Equal(2, scc.Length);
            Assert.Single(scc[0]);
            Assert.Single(scc[1]);
            Assert.True(scc.Any(cc => cc.Contains(v1) && cc.Contains(v2)));
            Assert.True(scc.Any(cc => cc.Contains(v3)));
        }
    }
}