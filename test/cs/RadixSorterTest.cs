using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Sorters.Integer;

namespace RadixSorterTests
{
    [TestClass]
    public class RadixSorterTests
    {
        [TestMethod]
        public void Sort_ArrayWithIntegers_SortedAscending()
        {
            // Arrange
            var radixSorter = new RadixSorter();
            var array = new int[] { 54, 23, 1, 67, 38 };

            // Act
            radixSorter.Sort(array);

            // Assert
            var expectedArray = new int[] { 1, 23, 38, 54, 67 };
            CollectionAssert.AreEqual(expectedArray, array);
        }

        [TestMethod]
        public void Sort_ReverseOrderArray_SortedAscending()
        {
            // Arrange
            var radixSorter = new RadixSorter();
            var array = new int[] { 65, 49, 32, 27, 11, 9 };

            // Act
            radixSorter.Sort(array);

            // Assert
            var expectedArray = new int[] { 9, 11, 27, 32, 49, 65 };
            CollectionAssert.AreEqual(expectedArray, array);
        }

        [TestMethod]
        public void Sort_AllNegativeIntegers_SortedAscending()
        {
            // Arrange
            var radixSorter = new RadixSorter();
            var array = new int[] { -25, -91, -67, -34, -8 };

            // Act
            radixSorter.Sort(array);

            // Assert
            var expectedArray = new int[] { -91, -67, -34, -25, -8 };
            CollectionAssert.AreEqual(expectedArray, array);
        }

        [TestMethod]
        public void Sort_MixedPositiveNegativeIntegers_SortedAscending()
        {
            // Arrange
            var radixSorter = new RadixSorter();
            var array = new int[] { -5, 13, -18, 43, -27 };

            // Act
            radixSorter.Sort(array);

            // Assert
            var expectedArray = new int[] { -27, -18, -5, 13, 43 };
            CollectionAssert.AreEqual(expectedArray, array);
        }

        [TestMethod]
        public void Sort_SingleElementArray_UnchangedArray()
        {
            // Arrange
            var radixSorter = new RadixSorter();
            var array = new int[] { 5 };

            // Act
            radixSorter.Sort(array);

            // Assert
            var expectedArray = new int[] { 5 };
            CollectionAssert.AreEqual(expectedArray, array);
        }
    }
}