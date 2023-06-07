using System.Collections.Generic;
using System.Linq;
using Algorithms.Sorters.Comparison;
using NUnit.Framework;

namespace Algorithms.Tests.Sorters.Comparison
{
    public class MiddlePointQuickSorterTests
    {
        // Test object instance
        private readonly MiddlePointQuickSorter<int> sorter = new();

        // Test array
        private readonly int[] testArray = { 9, 8, 7, 6, 5, 4, 3, 2, 1 };

        // Test array - Sorted
        private readonly int[] sortedTestArray = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };

        // Test with comparer
        private readonly IComparer<int> testCaseComparer = Comparer<int>.Create((x, y) => x.CompareTo(y));

        // Test arrays with duplicate elements
        private readonly int[] arrayWithDuplicates = { 3, 5, 6, 7, 3, 1, 7, 9, 0 };
        private readonly int[] sortedArrayWithDuplicates = { 0, 1, 3, 3, 5, 6, 7, 7, 9 };

        [Test]
        public void MiddlePointQuickSorter_CheckSorting_ExpectedResults()
        {
            // Execute sorting
            sorter.Sort(testArray, testCaseComparer);

            // Assert array is sorted correctly
            Assert.AreEqual(sortedTestArray, testArray);
        }

        [Test]
        public void MiddlePointQuickSorter_CheckSortingWithDuplicateElements_ExpectedResults()
        {
            // Execute sorting
            sorter.Sort(arrayWithDuplicates, testCaseComparer);

            // Assert array is sorted correctly
            Assert.AreEqual(sortedArrayWithDuplicates, arrayWithDuplicates);
        }

        [Test]
        public void MiddlePointQuickSorter_CheckSortingWithEmptyArray_ExpectNoException()
        {
            // Arrange
            var emptyArray = new int[0];

            // Act
            sorter.Sort(emptyArray, testCaseComparer);

            // Assert - No exceptions should occur
        }

        [Test]
        public void MiddlePointQuickSorter_CheckSortingWithSingleElementArray_ExpectNoException()
        {
            // Arrange
            var singleElementArray = new[] { 1 };

            // Act
            sorter.Sort(singleElementArray, testCaseComparer);

            // Assert - No exceptions should occur
        }

        [Test]
        public void MiddlePointQuickSorter_CheckSortingWithAlreadySortedArray_ExpectedResults()
        {
            // Arrange
            var alreadySortedArray = sortedTestArray.ToArray();

            // Act
            sorter.Sort(alreadySortedArray, testCaseComparer);

            // Assert - Array should still be in the same sorted state
            Assert.AreEqual(sortedTestArray, alreadySortedArray);
        }
    }
}