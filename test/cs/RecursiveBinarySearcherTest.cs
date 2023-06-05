using System;
using System.Collections.Generic;
using Algorithms.Search;
using Xunit;

namespace Algorithms.Tests
{
    public class RecursiveBinarySearcherTests
    {
        [Fact]
        public void FindIndex_NullCollection_ThrowsException()
        {
            // Arrange
            var searcher = new RecursiveBinarySearcher<int>();

            // Act
            Action action = () => searcher.FindIndex(null, 5);

            // Assert
            Assert.Throws<ArgumentNullException>(action);
        }

        [Theory]
        [InlineData(new int[] { }, 2, -1)]
        [InlineData(new int[] { 1, 2, 3, 4, 5 }, 2, 1)]
        [InlineData(new int[] { 1, 2, 3, 4, 5 }, 5, 4)]
        [InlineData(new int[] { 1, 2, 3, 4, 5 }, 1, 0)]
        [InlineData(new int[] { 1, 2, 3, 4, 5 }, 3, 2)]
        public void FindIndex_ValidCollection_ReturnsIndex(int[] collection, int item, int expectedIndex)
        {
            // Arrange
            var searcher = new RecursiveBinarySearcher<int>();

            // Act
            int actualIndex = searcher.FindIndex(collection, item);

            // Assert
            Assert.Equal(expectedIndex, actualIndex);
        }

        [Fact]
        public void FindIndex_ItemNotFound_ReturnsNegativeOne()
        {
            // Arrange
            var searcher = new RecursiveBinarySearcher<int>();
            var collection = new List<int> { 10, 15, 20, 25, 30 };

            // Act
            int result = searcher.FindIndex(collection, 5);

            // Assert
            Assert.Equal(-1, result);
        }

        [Fact]
        public void FindIndex_DuplicateItems_ReturnsFirstIndex()
        {
            // Arrange
            var searcher = new RecursiveBinarySearcher<int>();
            var collection = new List<int> { 10, 15, 15, 20, 25, 30 };

            // Act
            int result = searcher.FindIndex(collection, 15);

            // Assert
            Assert.Equal(1, result);
        }

        [Fact]
        public void FindIndex_StringCollection_ReturnsIndex()
        {
            // Arrange
            var searcher = new RecursiveBinarySearcher<string>();
            var collection = new List<string> { "apple", "banana", "kiwi", "orange", "watermelon" };

            // Act
            int result = searcher.FindIndex(collection, "kiwi");

            // Assert
            Assert.Equal(2, result);
        }
    }
}