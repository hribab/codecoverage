using System.Collections.Generic;
using Xunit;
using Algorithms.Sorters.Comparison;

namespace UnitTests
{
    public class ShellSorterTest
    {
        private readonly ShellSorter<int> _shellSorter = new ShellSorter<int>();

        [Fact]
        public void Test_Sort_EmptyArray()
        {
            // Arrange
            var array = new int[] { };
            var expected = new int[] { };

            // Act
            _shellSorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Test_Sort_SingleElementArray()
        {
            // Arrange
            var array = new int[] { 4 };
            var expected = new int[] { 4 };

            // Act
            _shellSorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Test_Sort_AlreadySortedArray()
        {
            // Arrange
            var array = new int[] { 1, 2, 3, 4, 5 };
            var expected = new int[] { 1, 2, 3, 4, 5 };

            // Act
            _shellSorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Test_Sort_ReverseSortedArray()
        {
            // Arrange
            var array = new int[] { 5, 4, 3, 2, 1 };
            var expected = new int[] { 1, 2, 3, 4, 5 };

            // Act
            _shellSorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expected, array);
        }

        [Fact]
        public void Test_Sort_UnsortedArray()
        {
            // Arrange
            var array = new int[] { 3, 1, 5, 2, 4 };
            var expected = new int[] { 1, 2, 3, 4, 5 };

            // Act
            _shellSorter.Sort(array, Comparer<int>.Default);

            // Assert
            Assert.Equal(expected, array);
        }
    }
}