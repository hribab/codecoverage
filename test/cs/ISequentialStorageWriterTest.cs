using System;
using System.IO;
using Algorithms.Sorters.External;
using Xunit;

namespace Algorithms.Tests
{
    public class SequentialStorageWriterTests : IDisposable
    {
        private readonly string _tempFilePath;

        public SequentialStorageWriterTests()
        {
            _tempFilePath = Path.GetTempFileName();
        }

        [Fact]
        // Test writing a single value.
        public void Write_SingleValue_CreatesFileWithSingleValue()
        {
            // Arrange
            using (var writer = CreateSequentialStorageWriter<string>(_tempFilePath))
            {
                // Act
                writer.Write("hello");
            }

            // Assert
            Assert.Equal("hello", ReadFromFile(_tempFilePath));
        }

        [Fact]
        // Test writing multiple values.
        public void Write_MultipleValues_CreatesCorrectFileContents()
        {
            // Arrange
            using (var writer = CreateSequentialStorageWriter<string>(_tempFilePath))
            {
                // Act
                writer.Write("hello");
                writer.Write("world");
            }

            // Assert
            Assert.Equal("hello\nworld", ReadFromFile(_tempFilePath));
        }

        [Fact]
        // Test writing values of different types.
        public void Write_DifferentTypes_WritesCorrectValues()
        {
        // Arrange
            using (var writer = CreateSequentialStorageWriter<int>(_tempFilePath))
            {
                // Act
                writer.Write(42);
                writer.Write(314);
            }

            // Assert
            Assert.Equal("42\n314", ReadFromFile(_tempFilePath));
        }

        [Fact]
        // Test opening and closing the file multiple times.
        public void Write_OpenAndCloseMultipleTimes_WritesCorrectValues()
        {
            // Arrange
            using (var writer = CreateSequentialStorageWriter<string>(_tempFilePath))
            {
                // Act
                writer.Write("value1");
            }
            using (var writer = CreateSequentialStorageWriter<string>(_tempFilePath))
            {
                writer.Write("value2");
            }

            // Assert
            Assert.Equal("value1\nvalue2", ReadFromFile(_tempFilePath));
        }

        [Fact]
        // Test disposing the object.
        public void IDisposable_Dispose_DeletesFile()
        {
            // Arrange
            var writer = CreateSequentialStorageWriter<string>(_tempFilePath);

            // Act
            writer.Dispose();

            // Assert
            Assert.False(File.Exists(_tempFilePath));
        }

        public void Dispose()
        {
            if (File.Exists(_tempFilePath))
            {
                File.Delete(_tempFilePath);
            }
        }

        private ISequentialStorageWriter<T> CreateSequentialStorageWriter<T>(string filePath)
        {
            return new SequentialStorageWriter<T>(filePath);
        }

        private string ReadFromFile(string filePath)
        {
            return File.ReadAllText(filePath);
        }
    }
}