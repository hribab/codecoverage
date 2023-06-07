using System;
using System.Collections.Generic;
using Algorithms.Sorters.Comparison;
using NUnit.Framework;

namespace UnitTestProject
{
    public class QuickSorterTests
    {
        private IComparer<int> _intComparer;

        [SetUp]
        public void SetUp()
        {
            _intComparer = Comparer<int>.Default;
        }

        [Test]
        public void TestUnsortedArray()
        {
            // Arrange
            var sorter = new TestQuickSorter();
            int[] array = {5, 2, 3, 1, 4};

            // Act
            sorter.Sort(array, _intComparer);

            // Assert
            Assert.AreEqual(new[] {1, 2, 3, 4, 5}, array);
        }

        [Test]
        public void TestEmptyArray()
        {
            // Arrange
            var sorter = new TestQuickSorter();
            int[] array = {};

            // Act
            sorter.Sort(array, _intComparer);

            // Assert
            Assert.AreEqual(new int[0], array);
        }

        [Test]
        public void TestOneElementArray()
        {
            // Arrange
            var sorter = new TestQuickSorter();
            int[] array = { 42 };

            // Act
            sorter.Sort(array, _intComparer);

            // Assert
            Assert.AreEqual(new[] { 42 }, array);
        }

        [Test]
        public void TestSortedArray()
        {
            // Arrange
            var sorter = new TestQuickSorter();
            int[] array = { 1, 2, 3, 4, 5 };

            // Act
            sorter.Sort(array, _intComparer);

            // Assert
            Assert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
        }

        [Test]
        public void TestReversedArray()
        {
            // Arrange
            var sorter = new TestQuickSorter();
            int[] array = { 5, 4, 3, 2, 1 };

            // Act
            sorter.Sort(array, _intComparer);

            // Assert
            Assert.AreEqual(new[] { 1, 2, 3, 4, 5 }, array);
        }
    }

    public class TestQuickSorter : QuickSorter<int>
    {
        protected override int SelectPivot(int[] array, IComparer<int> comparer, int left, int right)
        {
            return array[(left + right) / 2];
        }
    }
}