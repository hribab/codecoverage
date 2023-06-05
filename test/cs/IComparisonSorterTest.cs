using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Sorters.Comparison;

namespace AlgorithmsTests.Sorters.Comparison
{
    [TestClass]
    public class IComparisonSorterTests
    {
        private class TestSorter<T> : IComparisonSorter<T>
        {
            public void Sort(T[] array, IComparer<T> comparer)
            {
                Array.Sort(array, comparer);
            }
        }

        private readonly IComparisonSorter<int> _sorter = new TestSorter<int>();

        [TestMethod]
        public void Test_Sort_AllPositive()
        {
            // Test case: All positive numbers

            int[] array = new int[] { 3, 7, 2, 5, 1, 4 };
            int[] expected = new int[] { 1, 2, 3, 4, 5, 7 };

            _sorter.Sort(array, Comparer<int>.Default);

            CollectionAssert.AreEqual(expected, array);
        }

        [TestMethod]
        public void Test_Sort_AllNegative()
        {
            // Test case: All negative numbers

            int[] array = new int[] { -3, -7, -2, -5, -1, -4 };
            int[] expected = new int[] { -7, -5, -4, -3, -2, -1 };

            _sorter.Sort(array, Comparer<int>.Default);

            CollectionAssert.AreEqual(expected, array);
        }

        [TestMethod]
        public void Test_Sort_PositiveAndNegative()
        {
            // Test case: Combination of positive and negative numbers

            int[] array = new int[] { -3, 7, -2, 5, -1, 4 };
            int[] expected = new int[] { -3, -2, -1, 4, 5, 7 };

            _sorter.Sort(array, Comparer<int>.Default);

            CollectionAssert.AreEqual(expected, array);
        }

        [TestMethod]
        public void Test_Sort_SameElements()
        {
            // Test case: Array with same elements

            int[] array = new int[] { 3, 3, 3, 3, 3, 3 };
            int[] expected = new int[] { 3, 3, 3, 3, 3, 3 };

            _sorter.Sort(array, Comparer<int>.Default);

            CollectionAssert.AreEqual(expected, array);
        }

        [TestMethod]
        public void Test_Sort_EmptyArray()
        {
            // Test case: Empty array

            int[] array = new int[] { };
            int[] expected = new int[] { };

            _sorter.Sort(array, Comparer<int>.Default);

            CollectionAssert.AreEqual(expected, array);
        }
    }
}