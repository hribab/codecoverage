using System;
using Xunit;
using Algorithms.Search;

namespace Algorithms.Search.Tests
{
    public class JumpSearcherTests
    {
        [Fact]
        public void FindIndex_SearchItemInArray_ReturnsIndexOfItem()
        {
            // Arrange
            int[] sortedArray = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
            int searchItem = 4;
            JumpSearcher<int> searcher = new JumpSearcher<int>();

            // Act
            int result = searcher.FindIndex(sortedArray, searchItem);

            // Assert
            Assert.Equal(3, result);
        }

        [Fact]
        public void FindIndex_SearchItemNotInArray_ReturnsMinusOne()
        {
            // Arrange
            int[] sortedArray = new int[] { 1, 3, 4, 6, 8 };
            int searchItem = 5;
            JumpSearcher<int> searcher = new JumpSearcher<int>();

            // Act
            int result = searcher.FindIndex(sortedArray, searchItem);

            // Assert
            Assert.Equal(-1, result);
        }

        [Fact]
        public void FindIndex_SearchInEmptyArray_ReturnsMinusOne()
        {
            // Arrange
            int[] sortedArray = new int[] { };
            int searchItem = 5;
            JumpSearcher<int> searcher = new JumpSearcher<int>();

            // Act
            int result = searcher.FindIndex(sortedArray, searchItem);

            // Assert
            Assert.Equal(-1, result);
        }

        [Fact]
        public void FindIndex_SearchItemAsFirstElement_ReturnsZero()
        {
            // Arrange
            int[] sortedArray = new int[] { 2, 4, 6, 8, 10 };
            int searchItem = 2;
            JumpSearcher<int> searcher = new JumpSearcher<int>();

            // Act
            int result = searcher.FindIndex(sortedArray, searchItem);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void FindIndex_SearchItemAsLastElement_ReturnsLastIndex()
        {
            // Arrange
            int[] sortedArray = new int[] { 1, 3, 5, 7, 9 };
            int searchItem = 9;
            JumpSearcher<int> searcher = new JumpSearcher<int>();

            // Act
            int result = searcher.FindIndex(sortedArray, searchItem);

            // Assert
            Assert.Equal(4, result);
        }
    }
}