using System.Collections.Generic;
using Algorithms.DataCompression;
using Algorithms.Knapsack;
using Xunit;

namespace Algorithms.Tests
{
    public class ShannonFanoCompressorTest
    {
        [Fact]
        public void Compress_EmptyText_ReturnsEmptyStringAndEmptyDictionary()
        {
            // Arrange
            var compressor = new ShannonFanoCompressor(new LinearKnapsackSolver<(char, double)>(), new Translator());
            var input = string.Empty;

            // Act
            var (compressedText, decompressionKeys) = compressor.Compress(input);

            // Assert
            Assert.Equal(string.Empty, compressedText);
            Assert.Empty(decompressionKeys);
        }

        [Fact]
        public void Compress_TextWithOneUniqueCharacter_ReturnsAllOnesAndOneKeyDictionary()
        {
            // Arrange
            var compressor = new ShannonFanoCompressor(new LinearKnapsackSolver<(char, double)>(), new Translator());
            var input = "aaaa";

            // Act
            var (compressedText, decompressionKeys) = compressor.Compress(input);

            // Assert
            Assert.Equal("1111", compressedText);
            Assert.Single(decompressionKeys);
            Assert.Equal("1", decompressionKeys.Keys.First());
            Assert.Equal("a", decompressionKeys.Values.First());
        }

        [Fact]
        public void Compress_ValidText_ReturnsCompressedTextAndCorrectDecompressionKeys()
        {
            // Arrange
            var compressor = new ShannonFanoCompressor(new LinearKnapsackSolver<(char, double)>(), new Translator());
            var input = "hello world";

            // Act
            var (compressedText, decompressionKeys) = compressor.Compress(input);

            // Assert
            Assert.NotEqual(input, compressedText);
            Assert.Equal("e", decompressionKeys["00"]);
            Assert.Equal("o", decompressionKeys["10"]);
            Assert.Equal(" ", decompressionKeys["110"]);
            Assert.Equal("r", decompressionKeys["111"]);
            Assert.Equal("h", decompressionKeys["0100"]);
            Assert.Equal("l", decompressionKeys["0101"]);
            Assert.Equal("d", decompressionKeys["0110"]);
            Assert.Equal("w", decompressionKeys["0111"]);
        }

        [Fact]
        public void Compress_TextWithAllCharacters_ReturnsCompressedTextAndCorrectDecompressionKeys()
        {
            // Arrange
            var compressor = new ShannonFanoCompressor(new LinearKnapsackSolver<(char, double)>(), new Translator());
            var input = "abcdefghijklmnopqrstuvwxyz";

            // Act
            var (compressedText, decompressionKeys) = compressor.Compress(input);

            // Assert
            Assert.NotEqual(input, compressedText);
            Assert.Equal(9, decompressionKeys.Count);
            Assert.Equal("b", decompressionKeys["0000001"]);
            Assert.Equal("c", decompressionKeys["000001"]);
            Assert.Equal("d", decompressionKeys["00001"]);
            Assert.Equal("e", decompressionKeys["0001"]);

            // More assertions for the rest of the decompression keys
        }

        [Fact]
        public void Compress_TextWithManyRepeatingCharacters_ReturnsCompressedTextAndCorrectDecompressionKeys()
        {
            // Arrange
            var compressor = new ShannonFanoCompressor(new LinearKnapsackSolver<(char, double)>(), new Translator());
            var input = "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr";

            // Act
            var (compressedText, decompressionKeys) = compressor.Compress(input);

            // Assert
            Assert.NotEqual(input, compressedText);
            Assert.Single(decompressionKeys);
            Assert.Equal("r", decompressionKeys["0"]);
        }
    }
}