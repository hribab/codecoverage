using System;
using System.Collections.Generic;
using Algorithms.Sorters.Comparison;
using Xunit;

namespace Algorithms.Tests
{
    public class RandomPivotQuickSorterTests
    {
        // Test with an already sorted array
        [Fact]
        public void SortedArray_ExpectNoChanges()
        {
            // Arrange
            var array = new int[] { 1, 2, 3, 4, 5 };
            var sorter = new RandomPivotQuickSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(new int[] { 1, 2, 3, 4, 5 }, array);
        }

        // Test with an unsorted array
        [Fact]
        public void UnsortedArray_ExpectSorted()
        {
            // Arrange
            var array = new int[] { 5, 3, 2, 4, 1 };
            var sorter = new RandomPivotQuickSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(new int[] { 1, 2, 3, 4, 5 }, array);
        }

        // Test with an array containing duplicate values
        [Fact]
        public void ArrayWithDuplicates_ExpectSorted()
        {
            // Arrange
            var array = new int[] { 5, 3, 2, 3, 5 };
            var sorter = new RandomPivotQuickSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(new int[] { 2, 3, 3, 5, 5 }, array);
        }

        // Test with an array containing negative values
        [Fact]
        public void ArrayWithNegatives_ExpectSorted()
        {
            // Arrange
            var array = new int[] { -5, 3, 2, -4, 1 };
            var sorter = new RandomPivotQuickSorter<int>();
            var comparer = Comparer<int>.Default;

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(new int[] { -5, -4, 1, 2, 3 }, array);
        }

        // Test with an array of custom objects
        [Fact]
        public void ArrayOfCustomObjects_ExpectSorted()
        {
            // Arrange
            var array = new[]
            {
                new TestObject { Value = 5 },
                new TestObject { Value = 3 },
                new TestObject { Value = 1 },
                new TestObject { Value = 4 },
                new TestObject { Value = 2 }
            };
            var sorter = new RandomPivotQuickSorter<TestObject>();
            var comparer = Comparer<TestObject>.Create((x, y) => x.Value.CompareTo(y.Value));

            // Act
            sorter.Sort(array, comparer);

            // Assert
            Assert.Equal(new[] { 1, 2, 3, 4, 5 }, Array.ConvertAll(array, obj => obj.Value));
        }

        private class TestObject
        {
            public int Value { get; set; }
        }
    }
}