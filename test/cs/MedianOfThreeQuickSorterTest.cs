using System;
using System.Collections.Generic;
using NUnit.Framework;
using Algorithms.Sorters.Comparison;

namespace Algorithms.Tests.Sorters.Comparison
{
    public class MedianOfThreeQuickSorterTests
    {
        [Test]
        public void Sort_AllElementsUnique_CompareToSorted()
        {
            // Arrange
            var sorter = new MedianOfThreeQuickSorter<int>();
            var intComparer = Comparer<int>.Default;
            var arr = new[] { 5, 4, 3, 2, 1 };

            // Act
            sorter.Sort(arr, intComparer);

            // Assert
            CollectionAssert.AreEqual(arr, new[] { 1, 2, 3, 4, 5 });
        }

        [Test]
        public void Sort_WithDuplicates_CompareToSorted()
        {
            // Arrange
            var sorter = new MedianOfThreeQuickSorter<int>();
            var intComparer = Comparer<int>.Default;
            var arr = new[] { 3, 1, 4, 1, 5, 0 };

            // Act
            sorter.Sort(arr, intComparer);

            // Assert
            CollectionAssert.AreEqual(arr, new[] { 0, 1, 1, 3, 4, 5 });
        }

        [Test]
        public void Sort_SortedInput_ReturnsSame()
        {
            // Arrange
            var sorter = new MedianOfThreeQuickSorter<int>();
            var intComparer = Comparer<int>.Default;
            var arr = new[] { 1, 2, 3, 4, 5 };

            // Act
            sorter.Sort(arr, intComparer);

            // Assert
            CollectionAssert.AreEqual(arr, new[] { 1, 2, 3, 4, 5 });
        }

        [Test]
        public void Sort_ReverseSortedInput_CompareToSorted()
        {
            // Arrange
            var sorter = new MedianOfThreeQuickSorter<int>();
            var intComparer = Comparer<int>.Default;
            var arr = new[] { 5, 4, 3, 2, 1 };

            // Act
            sorter.Sort(arr, intComparer);

            // Assert
            CollectionAssert.AreEqual(arr, new[] { 1, 2, 3, 4, 5 });
        }

        [Test]
        public void Sort_SingleElement_ReturnsSame()
        {
            // Arrange
            var sorter = new MedianOfThreeQuickSorter<int>();
            var intComparer = Comparer<int>.Default;
            var arr = new[] { 1 };

            // Act
            sorter.Sort(arr, intComparer);

            // Assert
            CollectionAssert.AreEqual(arr, new[] { 1 });
        }
    }
}