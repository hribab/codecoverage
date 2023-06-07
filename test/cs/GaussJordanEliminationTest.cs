using System;
using Xunit;
using Algorithms.Numeric;

public class GaussJordanEliminationTests
{
    [Fact]
    // Test the CanMatrixBeUsed function with valid input
    public void CanMatrixBeUsed_ValidInput_True()
    {
        var gaussJordanElimination = new GaussJordanElimination();
        var matrix = new double[,] {
            { 1, 2, 3 },
            { 4, 5, 6 },
            { 7, 8, 9 }
        };

        bool canMatrixBeUsed = gaussJordanElimination.CanMatrixBeUsed(matrix);
        Assert.True(canMatrixBeUsed);
    }

    [Fact]
    // Test the CanMatrixBeUsed function with invalid input
    public void CanMatrixBeUsed_InvalidInput_False()
    {
        var gaussJordanElimination = new GaussJordanElimination();
        var matrix = new double[,] {
            { 1, 2 },
            { 3, 4 }
        };

        bool canMatrixBeUsed = gaussJordanElimination.CanMatrixBeUsed(matrix);
        Assert.False(canMatrixBeUsed);
    }

    [Fact]
    // Test the Solve function with a solvable matrix
    public void Solve_SolvableMatrix_True()
    {
        var gaussJordanElimination = new GaussJordanElimination();
        var matrix = new double[,] {
            { 1, 1, 1, 5 },
            { 2, 2, 1, 6 },
            { 3, 2, 1, 7 }
        };

        bool hasSolution = gaussJordanElimination.Solve(matrix);
        Assert.True(hasSolution);
    }

    [Fact]
    // Test the Solve function with an unsolvable matrix
    public void Solve_UnsolvableMatrix_False()
    {
        var gaussJordanElimination = new GaussJordanElimination();
        var matrix = new double[,] {
            { 1, 1, 1, 5 },
            { 0, 0, 0, 0 },
            { 3, 2, 1, 7 }
        };

        bool hasSolution = gaussJordanElimination.Solve(matrix);
        Assert.False(hasSolution);
    }

    [Fact]
    // Test the Solve function with an invalid input
    public void Solve_InvalidInput_ThrowsException()
    {
        var gaussJordanElimination = new GaussJordanElimination();
        var matrix = new double[,] {
            { 1, 1 },
            { 2, 2 },
            { 3, 3 }
        };

        Assert.Throws<ArgumentException>(() => gaussJordanElimination.Solve(matrix));
    }
}