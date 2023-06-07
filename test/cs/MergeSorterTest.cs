using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Sorters.Comparison;

namespace Algorithms.Tests.Sorters.Comparison
{
    [TestClass]
    public class MergeSorterTests
    {
        private MergeSorter<int> _mergeSorter;

        [TestInitialize]
        public void Setup()
        {
            _mergeSorter = new MergeSorter<int>();
        }

        [TestMethod]
        public void Sort_SortedArray_KeepsSorted()
        {
            // Arrange
            var array = new[] { 1, 2, 3, 4, 5 };
            var comparer = Comparer<int>.Default;

            // Act
            _mergeSorter.Sort(array, comparer);

            // Assert
            CollectionAssert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
        }

        [TestMethod]
        public void Sort_ReverseSortedArray_Sorts()
        {
            // Arrange
            var array = new[] { 5, 4, 3, 2, 1 };
            var comparer = Comparer<int>.Default;

            // Act
            _mergeSorter.Sort(array, comparer);

            // Assert
            CollectionAssert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
        }

        [TestMethod]
        public void Sort_UnsortedArray_Sorts()
        {
            // Arrange
            var array = new[] { 3, 5, 1, 4, 2 };
            var comparer = Comparer<int>.Default;

            // Act
            _mergeSorter.Sort(array, comparer);

            // Assert
            CollectionAssert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
        }

        [TestMethod]
        public void Sort_EmptyArray_KeepsEmpty()
        {
            // Arrange
            var array = Array.Empty<int>();
            var comparer = Comparer<int>.Default;

            // Act
            _mergeSorter.Sort(array, comparer);

            // Assert
            CollectionAssert.AreEqual(Array.Empty<int>(), array);
        }

        [TestMethod]
        public void Sort_OneElementArray_KeepsSame()
        {
            // Arrange
            var array = new[] { 1 };
            var comparer = Comparer<int>.Default;

            // Act
            _mergeSorter.Sort(array, comparer);

            // Assert
            CollectionAssert.AreEqual(new[] { 1 }, array);
        }
    }
}