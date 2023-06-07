using System.Collections.Generic;
using Algorithms.Sorters.Comparison;
using Xunit;

namespace Algorithms.Tests.Sorters.Comparison
{
    public class SelectionSorterTests
    {
        [Fact]
        public void Sort_SortsArrayWithDistinctElements()
        {
            // Arrange
            var array = new[] { 5, 2, 1, 4, 3 };
            var expected = new[] { 1, 2, 3, 4, 5 };
            var sorter = new SelectionSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Sort_SortsArrayWithDuplicatedElements()
        {
            // Arrange
            var array = new[] { 5, 2, 1, 4, 1, 3 };
            var expected = new[] { 1, 1, 2, 3, 4, 5 };
            var sorter = new SelectionSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Sort_SortsEmptyArray()
        {
            // Arrange
            var array = new int[0];
            var expected = new int[0];
            var sorter = new SelectionSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Sort_SortsArrayWithSingleElement()
        {
            // Arrange
            var array = new[] { 1 };
            var expected = new[] { 1 };
            var sorter = new SelectionSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Sort_SortsSortedArray()
        {
            // Arrange
            var array = new[] { 1, 2, 3, 4, 5 };
            var expected = new[] { 1, 2, 3, 4, 5 };
            var sorter = new SelectionSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(expected, array);
        }
    }
}