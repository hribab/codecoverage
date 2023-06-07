using Algorithms.Knapsack;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;

namespace Algorithms.Knapsack.Tests
{
    [TestClass]
    public class IKnapsackSolverTests
    {
        private class TestKnapsackSolver : IKnapsackSolver<int>
        {
            public IList<int> Solve(IList<int> items, IList<uint> weights, uint capacity)
            {
                // example implementation for testing
                return new List<int>();
            }
        }

        [TestMethod]
        public void Solve_Test1()
        {
            // Arrange
            IKnapsackSolver<int> solver = new TestKnapsackSolver();
            IList<int> items = new List<int> { 10, 20, 30 };
            IList<uint> weights = new List<uint> { 1, 2, 3 };
            uint capacity = 3;

            // Act
            var result = solver.Solve(items, weights, capacity);

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Solve_Test2()
        {
            // Arrange
            IKnapsackSolver<int> solver = new TestKnapsackSolver();
            IList<int> items = new List<int> { 40, 50, 60 };
            IList<uint> weights = new List<uint> { 4, 5, 6 };
            uint capacity = 7;

            // Act
            var result = solver.Solve(items, weights, capacity);

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Solve_Test3()
        {
            // Arrange
            IKnapsackSolver<int> solver = new TestKnapsackSolver();
            IList<int> items = new List<int> { 70, 80, 90 };
            IList<uint> weights = new List<uint> { 7, 8, 9 };
            uint capacity = 10;

            // Act
            var result = solver.Solve(items, weights, capacity);

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Solve_Test4()
        {
            // Arrange
            IKnapsackSolver<int> solver = new TestKnapsackSolver();
            IList<int> items = new List<int> { 100, 110, 120 };
            IList<uint> weights = new List<uint> { 10, 11, 12 };
            uint capacity = 5;

            // Act
            var result = solver.Solve(items, weights, capacity);

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Solve_Test5()
        {
            // Arrange
            IKnapsackSolver<int> solver = new TestKnapsackSolver();
            IList<int> items = new List<int> { 130, 140, 150 };
            IList<uint> weights = new List<uint> { 13, 14, 15 };
            uint capacity = 20;

            // Act
            var result = solver.Solve(items, weights, capacity);

            // Assert
            Assert.IsNotNull(result);
        }
    }
}