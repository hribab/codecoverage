using System;
using Xunit;
using Algorithms.Search;
using Utilities.Exceptions;

namespace Algorithms.Tests.Search
{
    public class LinearSearcherTests
    {
        private readonly LinearSearcher<int> _linearSearcherInt;

        public LinearSearcherTests()
        {
            _linearSearcherInt = new LinearSearcher<int>();
        }

        // Test cases for Find method
        [Fact]
        public void Find_SingleElementTermTrue_ReturnsElement()
        {
            // Arrange
            int[] data = { 1 };
            Func<int, bool> term = x => x == 1;

            // Act
            int result = _linearSearcherInt.Find(data, term);

            // Assert
            Assert.Equal(1, result);
        }

        [Fact]
        public void Find_MultipleElementsTermTrue_ReturnsFirstMatch()
        {
            // Arrange
            int[] data = { 1, 2, 3, 4, 5 };
            Func<int, bool> term = x => x > 2;

            // Act
            int result = _linearSearcherInt.Find(data, term);

            // Assert
            Assert.Equal(3, result);
        }

        [Fact]
        public void Find_NoMatchingElements_ThrowsItemNotFoundException()
        {
            // Arrange
            int[] data = { 1, 2, 3, 4, 5 };
            Func<int, bool> term = x => x > 6;

            // Act & Assert
            Assert.Throws<ItemNotFoundException>(() => _linearSearcherInt.Find(data, term));
        }

        [Fact]
        public void Find_EmptyArray_ThrowsItemNotFoundException()
        {
            // Arrange
            int[] data = { };
            Func<int, bool> term = x => x > 0;

            // Act & Assert
            Assert.Throws<ItemNotFoundException>(() => _linearSearcherInt.Find(data, term));
        }

        [Fact]
        public void Find_NullArray_ThrowsArgumentNullException()
        {
            // Arrange
            int[] data = null;
            Func<int, bool> term = x => x > 0;

            // Act & Assert
            Assert.Throws<ArgumentNullException>(() => _linearSearcherInt.Find(data, term));
        }

        // Test cases for FindIndex method
        [Fact]
        public void FindIndex_SingleElementTermTrue_ReturnsIndex()
        {
            // Arrange
            int[] data = { 1 };
            Func<int, bool> term = x => x == 1;

            // Act
            int result = _linearSearcherInt.FindIndex(data, term);

            // Assert
            Assert.Equal(0, result);
        }

        [Fact]
        public void FindIndex_MultipleElementsTermTrue_ReturnsFirstMatchIndex()
        {
            // Arrange
            int[] data = { 1, 2, 3, 4, 5 };
            Func<int, bool> term = x => x > 2;

            // Act
            int result = _linearSearcherInt.FindIndex(data, term);

            // Assert
            Assert.Equal(2, result);
        }

        [Fact]
        public void FindIndex_NoMatchingElements_ReturnsMinusOne()
        {
            // Arrange
            int[] data = { 1, 2, 3, 4, 5 };
            Func<int, bool> term = x => x > 6;

            // Act
            int result = _linearSearcherInt.FindIndex(data, term);

            // Assert
            Assert.Equal(-1, result);
        }

        [Fact]
        public void FindIndex_EmptyArray_ReturnsMinusOne()
        {
            // Arrange
            int[] data = { };
            Func<int, bool> term = x => x > 0;

            // Act
            int result = _linearSearcherInt.FindIndex(data, term);

            // Assert
            Assert.Equal(-1, result);
        }

        [Fact]
        public void FindIndex_NullArray_ThrowsArgumentNullException()
        {
            // Arrange
            int[] data = null;
            Func<int, bool> term = x => x > 0;

            // Act & Assert
            Assert.Throws<ArgumentNullException>(() => _linearSearcherInt.FindIndex(data, term));
        }
    }
}