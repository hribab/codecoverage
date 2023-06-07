using System;
using System.Collections.Generic;
using Algorithms.Sorters.Comparison;
using Algorithms.DataCompression;
using Xunit;

namespace HuffmanCompressorTests
{
    public class HuffmanCompressorTests
    {
        private readonly HuffmanCompressor _compressor;

        public HuffmanCompressorTests()
        {
            var sorter = new BubbleSorter<ListNode>(); // Using BubbleSorter for the algorithm
            var translator = new Translator(); // Assuming the Translator class is available
            _compressor = new HuffmanCompressor(sorter, translator);
        }

        [Fact]
        public void Compress_EmptyString_ReturnEmptyResult()
        {
            // Arrange
            var input = string.Empty;

            // Act
            var (compressedText, decompressionKeys) = _compressor.Compress(input);

            // Assert
            Assert.Equal(string.Empty, compressedText);
            Assert.Empty(decompressionKeys);
        }

        [Fact]
        public void Compress_SingleCharacterString_ReturnCompressedResult()
        {
            // Arrange
            var input = "aaaaaa";

            // Act
            var (compressedText, decompressionKeys) = _compressor.Compress(input);

            // Assert
            Assert.Equal("111111", compressedText);
            Assert.Single(decompressionKeys);
            Assert.True(decompressionKeys.ContainsKey("1"));
            Assert.Equal("a", decompressionKeys["1"]);
        }

        [Fact]
        public void Compress_MultiCharacterStringSameFrequency_ReturnCompressedResult()
        {
            // Arrange
            var input = "ababab";

            // Act
            var (compressedText, decompressionKeys) = _compressor.Compress(input);

            // Assert
            // The result could be "010101" or "101010" depending on the tree generated
            Assert.True(compressedText == "010101" || compressedText == "101010");
            Assert.Equal(2, decompressionKeys.Count);
            Assert.True(decompressionKeys.ContainsKey("0"));
            Assert.True(decompressionKeys.ContainsKey("1"));
            Assert.Contains("a", decompressionKeys.Values);
            Assert.Contains("b", decompressionKeys.Values);
        }

        [Fact]
        public void Compress_MultiCharacterStringDifferentFrequency_ReturnCompressedResult()
        {
            // Arrange
            var input = "aaabbc";

            // Act
            var (compressedText, decompressionKeys) = _compressor.Compress(input);

            // Assert
            // The result could be "00001123" or other combinations depending on the tree generated
            Assert.Equal(8, compressedText.Length);
            Assert.Equal(3, decompressionKeys.Count);
            Assert.Contains("a", decompressionKeys.Values);
            Assert.Contains("b", decompressionKeys.Values);
            Assert.Contains("c", decompressionKeys.Values);
        }

        [Fact]
        public void Compress_LongString_ReturnCompressedResult()
        {
            // Arrange
            var input = "The quick brown fox jumps over the lazy dog";

            // Act
            var (compressedText, decompressionKeys) = _compressor.Compress(input);

            // Assert
            Assert.True(compressedText.Length > 0);
            Assert.True(decompressionKeys.Count > 0);

            // Ensure all characters appear in decompression keys
            foreach (var ch in input)
            {
                var compressedCode = string.Empty;
                foreach (var kvp in decompressionKeys)
                {
                    if (kvp.Value == ch.ToString())
                    {
                        compressedCode = kvp.Key;
                        break;
                    }
                }

                Assert.False(string.IsNullOrEmpty(compressedCode));
            }
        }
    }
}