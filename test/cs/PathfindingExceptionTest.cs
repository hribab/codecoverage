using System;
using Xunit;
using Algorithms.Search.AStar;

namespace Algorithms.Tests.Search.AStar
{
    public class PathfindingExceptionTests
    {
        [Fact]
        public void Constructor_SetsDefaultMessage()
        {
            // Arrange
            string expectedMessage = "Custom exception message";

            // Act
            var exception = new PathfindingException(expectedMessage);

            // Assert
            Assert.Equal(expectedMessage, exception.Message);
        }

        [Fact]
        public void Constructor_SetsNullMessage()
        {
            // Arrange
            string expectedMessage = null;

            // Act
            var exception = new PathfindingException(expectedMessage);

            // Assert
            Assert.Equal(expectedMessage, exception.Message);
        }

        [Fact]
        public void Constructor_SetsEmptyMessage()
        {
            // Arrange
            string expectedMessage = string.Empty;

            // Act
            var exception = new PathfindingException(expectedMessage);

            // Assert
            Assert.Equal(expectedMessage, exception.Message);
        }

        [Fact]
        public void Constructor_SetsWhiteSpaceMessage()
        {
            // Arrange
            string expectedMessage = "   ";

            // Act
            var exception = new PathfindingException(expectedMessage);

            // Assert
            Assert.Equal(expectedMessage, exception.Message);
        }

        [Fact]
        public void Constructor_SetsLongMessage()
        {
            // Arrange
            string expectedMessage = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";

            // Act
            var exception = new PathfindingException(expectedMessage);

            // Assert
            Assert.Equal(expectedMessage, exception.Message);
        }
    }
}