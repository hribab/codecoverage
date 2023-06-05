using System.Collections.Generic;
using NUnit.Framework;
using Algorithms.Sorters.Comparison;

namespace Algorithms.Tests.Sorters
{
    [TestFixture]
    public class InsertionSorterTests
    {
        [Test]
        public void Sort_EmptyArray_ReturnsEmptyArray()
        {
            // Arrange
            var sorter = new InsertionSorter<int>();
            var array = new int[] { };
            var expectedResult = new int[] { };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            CollectionAssert.AreEqual(expectedResult, array);
        }

        [Test]
        public void Sort_SingleElementArray_ReturnsSameArray()
        {
            // Arrange
            var sorter = new InsertionSorter<int>();
            var array = new int[] { 42 };
            var expectedResult = new int[] { 42 };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            CollectionAssert.AreEqual(expectedResult, array);
        }

        [Test]
        public void Sort_AlreadySortedArray_ReturnsSameArray()
        {
            // Arrange
            var sorter = new InsertionSorter<int>();
            var array = new int[] { 1, 2, 3, 4, 5 };
            var expectedResult = new int[] { 1, 2, 3, 4, 5 };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            CollectionAssert.AreEqual(expectedResult, array);
        }

        [Test]
        public void Sort_ReverseSortedArray_ReturnsSortedArray()
        {
            // Arrange
            var sorter = new InsertionSorter<int>();
            var array = new int[] { 5, 4, 3, 2, 1 };
            var expectedResult = new int[] { 1, 2, 3, 4, 5 };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            CollectionAssert.AreEqual(expectedResult, array);
        }

        [Test]
        public void Sort_UnsortedArray_ReturnsSortedArray()
        {
            // Arrange
            var sorter = new InsertionSorter<int>();
            var array = new int[] { 3, 5, 1, 4, 2 };
            var expectedResult = new int[] { 1, 2, 3, 4, 5 };

            // Act
            sorter.Sort(array, Comparer<int>.Default);

            // Assert
            CollectionAssert.AreEqual(expectedResult, array);
        }
    }
}