using System;
using Xunit;
using Algorithms.Knapsack;
using System.Linq;

public class HeuristicKnapsackSolverTests
{
    // Sample class to use as generic type for test cases
    private class SampleItem
    {
        public double Weight { get; set; }
        public double Value { get; set; }
    }

    // Implement the IHeuristicKnapsackSolver to use in test cases
    private class SampleHeuristicKnapsackSolver : IHeuristicKnapsackSolver<SampleItem>
    {
        public SampleItem[] Solve(
            SampleItem[] items, 
            double capacity, 
            Func<SampleItem, double> weightSelector, 
            Func<SampleItem, double> valueSelector)
        {
            // Dummy implementation where we only add items until reaching the capacity
            var result = new SampleItem[0];

            foreach (var item in items.OrderBy(valueSelector).Reverse())
            {
                if (weightSelector(item) + result.Sum(x => weightSelector(x)) <= capacity)
                {
                    Array.Resize(ref result, result.Length + 1);
                    result[result.Length - 1] = item;
                }
            }

            return result;
        }
    }

    [Fact]
    public void Solve_ItemsAreNull_ReturnsEmptyArray()
    {
        // Arrange
        var solver = new SampleHeuristicKnapsackSolver();
        SampleItem[] items = null;

        // Act
        var result = solver.Solve(items, 10, x => x.Weight, x => x.Value);

        // Assert
        Assert.Empty(result);
    }

    [Fact]
    public void Solve_EmptyItems_ReturnsEmptyArray()
    {
        // Arrange
        var solver = new SampleHeuristicKnapsackSolver();
        var items = new SampleItem[0];

        // Act
        var result = solver.Solve(items, 10, x => x.Weight, x => x.Value);

        // Assert
        Assert.Empty(result);
    }

    [Fact]
    public void Solve_CapacityIsZero_ReturnsEmptyArray()
    {
        // Arrange
        var solver = new SampleHeuristicKnapsackSolver();
        var items = new[]
        {
            new SampleItem { Weight = 1, Value = 1 },
            new SampleItem { Weight = 2, Value = 2 },
            new SampleItem { Weight = 3, Value = 3 },
        };

        // Act
        var result = solver.Solve(items, 0, x => x.Weight, x => x.Value);

        // Assert
        Assert.Empty(result);
    }

    [Fact]
    public void Solve_CapacityIsNegative_ReturnsEmptyArray()
    {
        // Arrange
        var solver = new SampleHeuristicKnapsackSolver();
        var items = new[]
        {
            new SampleItem { Weight = 1, Value = 1 },
            new SampleItem { Weight = 2, Value = 2 },
            new SampleItem { Weight = 3, Value = 3 },
        };

        // Act
        var result = solver.Solve(items, -1, x => x.Weight, x => x.Value);

        // Assert
        Assert.Empty(result);
    }

    [Fact]
    public void Solve_ValidInput_ReturnsExpectedSolution()
    {
        // Arrange
        var solver = new SampleHeuristicKnapsackSolver();
        var items = new[]
        {
            new SampleItem { Weight = 1, Value = 1 },
            new SampleItem { Weight = 2, Value = 4 },
            new SampleItem { Weight = 3, Value = 3 },
        };

        // Act
        var result = solver.Solve(items, 4, x => x.Weight, x => x.Value);

        // Assert
        Assert.Equal(2, result.Length);
        Assert.Contains(items[0], result);
        Assert.Contains(items[1], result);
    }
}