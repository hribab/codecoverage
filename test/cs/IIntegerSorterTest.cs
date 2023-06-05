using Algorithms.Sorters.Integer;
using NUnit.Framework;

namespace UnitTests
{
    [TestFixture]
    public class IntegerSorterTests
    {
        private IIntegerSorter _integerSorter;

        [SetUp]
        public void Setup()
        {
            _integerSorter = new ConcreteIntegerSorter(); // Replace ConcreteIntegerSorter with the actual implementation class
        }

        [Test]
        // Test sorting an already sorted array
        public void Sort_SortedArray_ReturnsSameArray()
        {
            int[] input = {1, 2, 3, 4, 5};
            int[] expected = {1, 2, 3, 4, 5};
            _integerSorter.Sort(input);
            
            Assert.AreEqual(expected, input);
        }

        [Test]
        // Test sorting a reverse sorted array
        public void Sort_ReverseSortedArray_ReturnsSortedArray()
        {
            int[] input = {5, 4, 3, 2, 1};
            int[] expected = {1, 2, 3, 4, 5};
            _integerSorter.Sort(input);

            Assert.AreEqual(expected, input);
        }

        [Test]
        // Test sorting an array with duplicate values
        public void Sort_ArrayWithDuplicates_ReturnsSortedArray()
        {
            int[] input = {4, 2, 1, 4, 3};
            int[] expected = {1, 2, 3, 4, 4};
            _integerSorter.Sort(input);

            Assert.AreEqual(expected, input);
        }

        [Test]
        // Test sorting an array with negative values
        public void Sort_NegativeArray_ReturnsSortedArray()
        {
            int[] input = {-1, -3, -2, -4, -5};
            int[] expected = {-5, -4, -3, -2, -1};
            _integerSorter.Sort(input);

            Assert.AreEqual(expected, input);
        }

        [Test]
        // Test sorting an array with both positive and negative values
        public void Sort_MixedArray_ReturnsSortedArray()
        {
            int[] input = {1, -2, 3, -4, -5, 6};
            int[] expected = {-5, -4, -2, 1, 3, 6};
            _integerSorter.Sort(input);

            Assert.AreEqual(expected, input);
        }
    }
}