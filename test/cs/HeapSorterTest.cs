using System;
using System.Collections.Generic;
using Xunit;
using Algorithms.Sorters.Comparison;

public class HeapSorterTests
{
    private readonly HeapSorter<int> _heapSorter;
    private readonly IComparer<int> _intComparer;

    public HeapSorterTests()
    {
        _heapSorter = new HeapSorter<int>();
        _intComparer = Comparer<int>.Default;
    }

    [Fact]
    public void Sort_EmptyArray_NoChanges()
    {
        // Arrange
        var array = new int[0];

        // Act
        _heapSorter.Sort(array, _intComparer);

        // Assert
        Assert.Empty(array);
    }

    [Fact]
    public void Sort_SingleElementArray_NoChanges()
    {
        // Arrange
        var array = new[] { 42 };

        // Act
        _heapSorter.Sort(array, _intComparer);

        // Assert
        Assert.Single(array);
        Assert.Equal(42, array[0]);
    }

    [Fact]
    public void Sort_TwoElementUnsortedArray_Sorted()
    {
        // Arrange
        var array = new[] { 3, 1 };

        // Act
        _heapSorter.Sort(array, _intComparer);

        // Assert
        Assert.Equal(new[] { 1, 3 }, array);
    }

    [Fact]
    public void Sort_TwoElementSortedArray_NoChanges()
    {
        // Arrange
        var array = new[] { 1, 3 };

        // Act
        _heapSorter.Sort(array, _intComparer);

        // Assert
        Assert.Equal(new[] { 1, 3 }, array);
    }

    [Fact]
    public void Sort_MultipleElementArray_Sorted()
    {
        // Arrange
        var array = new[] { 3, 5, 1, 4, 2 };

        // Act
        _heapSorter.Sort(array, _intComparer);

        // Assert
        Assert.Equal(new[] { 1, 2, 3, 4, 5 }, array);
    }
}