using System;
using Xunit;
using Algorithms.Sorters.External;

namespace Algorithms.Sorters.External.Tests
{
    public class ISequentialStorageTests
    {
        // Test class to implement ISequentialStorage 
        private class TestSequentialStorage : ISequentialStorage<int>
        {
            public int Length { get; private set; }

            public TestSequentialStorage(int length)
            {
                Length = length;
            }

            public ISequentialStorageReader<int> GetReader()
            {
                // Implementation not needed for tests
                return null;
            }

            public ISequentialStorageWriter<int> GetWriter()
            {
                // Implementation not needed for tests
                return null;
            }
        }

        [Fact]
        public void Length_ReturnsCorrectValue()
        {
            // Arrange
            int expectedLength = 5;
            TestSequentialStorage testStorage = new TestSequentialStorage(expectedLength);

            // Act
            int actualLength = testStorage.Length;

            // Assert
            Assert.Equal(expectedLength, actualLength);
        }

        [Fact]
        public void Length_HandlesZeroCase()
        {
            // Arrange
            int expectedLength = 0;
            TestSequentialStorage testStorage = new TestSequentialStorage(expectedLength);

            // Act
            int actualLength = testStorage.Length;

            // Assert
            Assert.Equal(expectedLength, actualLength);
        }

        [Fact]
        public void Length_HandlesMaxValue()
        {
            // Arrange
            int expectedLength = int.MaxValue;
            TestSequentialStorage testStorage = new TestSequentialStorage(expectedLength);

            // Act
            int actualLength = testStorage.Length;

            // Assert
            Assert.Equal(expectedLength, actualLength);
        }

        [Fact]
        public void Length_HandlesMinValue()
        {
            // Arrange
            int expectedLength = int.MinValue;
            TestSequentialStorage testStorage = new TestSequentialStorage(expectedLength);

            // Act
            int actualLength = testStorage.Length;

            // Assert
            Assert.Equal(expectedLength, actualLength);
        }

        [Fact]
        public void GetReader_ReturnsNull()
        {
            // Arrange
            TestSequentialStorage testStorage = new TestSequentialStorage(0);

            // Act
            var actualReader = testStorage.GetReader();

            // Assert
            Assert.Null(actualReader);
        }

        [Fact]
        public void GetWriter_ReturnsNull()
        {
            // Arrange
            TestSequentialStorage testStorage = new TestSequentialStorage(0);

            // Act
            var actualWriter = testStorage.GetWriter();

            // Assert
            Assert.Null(actualWriter);
        }
    }
}