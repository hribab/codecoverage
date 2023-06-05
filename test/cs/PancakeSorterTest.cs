using System;
using System.Collections.Generic;
using Xunit;
using Algorithms.Sorters.Comparison;

namespace Algorithms.Tests
{
    public class PancakeSorterTests
    {
        [Fact]
        public void Sort_ArrayOfIntegers_SortedAscending()
        {
            // Arrange
            var sorter = new PancakeSorter<int>();
            var array = new int[] { 4, 2, 7, 1, 3 };
            var expectedArray = new int[] { 1, 2, 3, 4, 7 };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expectedArray, array);
        }

        [Fact]
        public void Sort_ArrayOfChars_SortedAlphabetically()
        {
            // Arrange
            var sorter = new PancakeSorter<char>();
            var array = new char[] { 'z', 'c', 'b', 'a', 'x' };
            var expectedArray = new char[] { 'a', 'b', 'c', 'x', 'z' };

            // Act
            sorter.Sort(array, Comparer<char>.Default);

            // Assert
            Assert.Equal(expectedArray, array);
        }

        [Fact]
        public void Sort_AlreadySortedIntArray_NoChanges()
        {
            // Arrange
            var sorter = new PancakeSorter<int>();
            var array = new int[] { 1, 2, 3, 4, 5 };
            var expectedArray = new int[] { 1, 2, 3, 4, 5 };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expectedArray, array);
        }

        [Fact]
        public void Sort_SingleElementArray_NoChanges()
        {
            // Arrange
            var sorter = new PancakeSorter<int>();
            var array = new int[] { 5 };
            var expectedArray = new int[] { 5 };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expectedArray, array);
        }

        [Fact]
        public void Sort_EmptyArray_NoChanges()
        {
            // Arrange
            var sorter = new PancakeSorter<int>();
            var array = new int[] { };
            var expectedArray = new int[] { };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expectedArray, array);
        }
    }
}