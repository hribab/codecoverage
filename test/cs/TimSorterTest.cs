using System;
using NUnit.Framework;
using Algorithms.Sorters.Comparison;

[TestFixture]
public class TimSorterTests
{
    [Test]
    public void Sort_EmptyArray_ReturnsEmptyArray()
    {
        // Arrange
        var array = new int[0];
        var sorter = new TimSorter<int>();

        // Act
        sorter.Sort(array, Comparer<int>.Default);

        // Assert
        Assert.IsEmpty(array);
    }

    [Test]
    public void Sort_OneElementArray_ReturnsSameArray()
    {
        // Arrange
        var array = new[] { 42 };
        var sorter = new TimSorter<int>();

        // Act
        sorter.Sort(array, Comparer<int>.Default);

        // Assert
        Assert.AreEqual(new[] { 42 }, array);
    }

    [Test]
    public void Sort_SortedArray_ReturnsSameArray()
    {
        // Arrange
        var array = new[] { 1, 2, 3, 4, 5 };
        var sorter = new TimSorter<int>();

        // Act
        sorter.Sort(array, Comparer<int>.Default);

        // Assert
        Assert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
    }

    [Test]
    public void Sort_ReversedArray_ReturnsSortedArray()
    {
        // Arrange
        var array = new[] { 5, 4, 3, 2, 1 };
        var sorter = new TimSorter<int>();

        // Act
        sorter.Sort(array, Comparer<int>.Default);

        // Assert
        Assert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
    }

    [Test]
    public void Sort_UnsortedArray_ReturnsSortedArray()
    {
        // Arrange
        var array = new[] { 4, 2, 1, 5, 3 };
        var sorter = new TimSorter<int>();

        // Act
        sorter.Sort(array, Comparer<int>.Default);

        // Assert
        Assert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
    }
}
