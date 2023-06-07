using System;
using System.Linq;
using Algorithms.Sorters.String;
using NUnit.Framework;

namespace Algorithms.Tests.Sorters.String
{
    public class StringSorterTests
    {
        [Test]
        public void Test_Sort_EmptyArray()
        {
            // Arrange
            var stringSorter = new StringSorter();
            var array = new string[0];

            // Act
            stringSorter.Sort(array);

            // Assert
            Assert.AreEqual(new string[0], array);
        }

        [Test]
        public void Test_Sort_SingleElementArray()
        {
            // Arrange
            var stringSorter = new StringSorter();
            var array = new[] { "hello" };

            // Act
            stringSorter.Sort(array);

            // Assert
            Assert.AreEqual(new[] { "hello" }, array);
        }

        [Test]
        public void Test_Sort_PreSortedArray()
        {
            // Arrange
            var stringSorter = new StringSorter();
            var array = new[] { "apple", "banana", "carrot" };

            // Act
            stringSorter.Sort(array);

            // Assert
            Assert.AreEqual(new[] { "apple", "banana", "carrot" }, array);
        }

        [Test]
        public void Test_Sort_UnsortedArray()
        {
            // Arrange
            var stringSorter = new StringSorter();
            var array = new[] { "carrot", "banana", "apple" };

            // Act
            stringSorter.Sort(array);

            // Assert
            Assert.AreEqual(new[] { "apple", "banana", "carrot" }, array);
        }

        [Test]
        public void Test_Sort_ReverseSortedArray()
        {
            // Arrange
            var stringSorter = new StringSorter();
            var array = new[] { "carrot", "banana", "apple", "apple" };

            // Act
            stringSorter.Sort(array);

            // Assert
            Assert.AreEqual(new[] { "apple", "apple", "banana", "carrot"}, array);
        }
    }

    public class StringSorter : IStringSorter
    {
        public void Sort(string[] array)
        {
            // A sample implementation for sorting strings using LINQ
            Array.Sort(array);
        }
    }
}