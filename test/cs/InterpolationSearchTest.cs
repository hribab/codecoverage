using System;
using Xunit;
using Algorithms.Search;

namespace Algorithms.Tests.Search
{
    public class InterpolationSearchTests
    {
        [Fact]
        public void FindIndex_ItemPresentInArray_ReturnsIndex()
        {
            // Arrange
            int[] sortedArray = {1, 3, 5, 7, 9};
            int val = 5;

            // Act
            int result = InterpolationSearch.FindIndex(sortedArray, val);

            // Assert
            Assert.Equal(2, result);
        }

        [Fact]
        public void FindIndex_ItemNotPresentInArray_ReturnsNegativeOne()
        {
            // Arrange
            int[] sortedArray = {1, 3, 5, 7, 9};
            int val = 10;

            // Act
            int result = InterpolationSearch.FindIndex(sortedArray, val);

            // Assert
            Assert.Equal(-1, result);
        }

        [Fact]
        public void FindIndex_ItemPresentAtStartOfArray_ReturnsZero()
        {
            // Arrange
            int[] sortedArray = {1, 3, 5, 7, 9};
            int val = 1;

            // Act
            int result = InterpolationSearch.FindIndex(sortedArray, val);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void FindIndex_ItemPresentAtEndOfArray_ReturnsLastIndex()
        {
            // Arrange
            int[] sortedArray = {1, 3, 5, 7, 9};
            int val = 9;

            // Act
            int result = InterpolationSearch.FindIndex(sortedArray, val);

            // Assert
            Assert.Equal(4, result);
        }

        [Fact]
        public void FindIndex_EmptyArray_ReturnsNegativeOne()
        {
            // Arrange
            int[] sortedArray = Array.Empty<int>();
            int val = 5;

            // Act
            int result = InterpolationSearch.FindIndex(sortedArray, val);

            // Assert
            Assert.Equal(-1, result);
        }
    }
}