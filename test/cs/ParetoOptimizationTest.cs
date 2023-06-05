using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using Algorithms.Other;

namespace Algorithms_tests.Other
{
    [TestClass]
    public class ParetoOptimizationTests
    {
        [TestMethod]
        public void Optimize_Test1()
        {
            // Arrange
            var pareto = new ParetoOptimization();
            var input = new List<List<decimal>>
            {
                new List<decimal> { 1, 2 },
                new List<decimal> { 2, 1 }
            };

            var expected = new List<List<decimal>>
            {
                new List<decimal> { 1, 2 },
                new List<decimal> { 2, 1 }
            };

            // Act
            var result = pareto.Optimize(input);

            // Assert
            CollectionAssert.AreEqual(expected, result);
        }

        [TestMethod]
        public void Optimize_Test2()
        {
            // Arrange
            var pareto = new ParetoOptimization();
            var input = new List<List<decimal>>
            {
                new List<decimal> { 1, 2 },
                new List<decimal> { 3, 1 }
            };

            var expected = new List<List<decimal>>
            {
                new List<decimal> { 1, 2 },
                new List<decimal> { 3, 1 }
            };

            // Act
            var result = pareto.Optimize(input);

            // Assert
            CollectionAssert.AreEqual(expected, result);
        }

        [TestMethod]
        public void Optimize_Test3()
        {
            // Arrange
            var pareto = new ParetoOptimization();
            var input = new List<List<decimal>>
            {
                new List<decimal> { 1, 2 },
                new List<decimal> { 1, 1 }
            };

            var expected = new List<List<decimal>>
            {
                new List<decimal> { 1, 1 }
            };

            // Act
            var result = pareto.Optimize(input);

            // Assert
            CollectionAssert.AreEqual(expected, result);
        }

        [TestMethod]
        public void Optimize_Test4()
        {
            // Arrange
            var pareto = new ParetoOptimization();
            var input = new List<List<decimal>>
            {
                new List<decimal> { 1, 2, 3 },
                new List<decimal> { 4, 1, 2 },
                new List<decimal> { 2, 2, 3 },
                new List<decimal> { 3, 3, 1 }
            };

            var expected = new List<List<decimal>>
            {
                new List<decimal> { 1, 2, 3 },
                new List<decimal> { 4, 1, 2 },
                new List<decimal> { 3, 3, 1 }
            };

            // Act
            var result = pareto.Optimize(input);

            // Assert
            CollectionAssert.AreEqual(expected, result);
        }

        [TestMethod]
        public void Optimize_Test5()
        {
            // Arrange
            var pareto = new ParetoOptimization();
            var input = new List<List<decimal>>
            {
                new List<decimal> { 1, 2, 2 },
                new List<decimal> { 2, 1, 1 }
            };

            var expected = new List<List<decimal>>
            {
                new List<decimal> { 1, 2, 2 },
                new List<decimal> { 2, 1, 1 }
            };

            // Act
            var result = pareto.Optimize(input);

            // Assert
            CollectionAssert.AreEqual(expected, result);
        }
    }
}