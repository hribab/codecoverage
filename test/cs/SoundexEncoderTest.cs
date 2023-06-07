using System;
using Xunit;
using Algorithms.Encoders;
using System.Collections.Generic;

namespace Algorithms.Tests
{
    public class SoundexEncoderTests
    {
        private readonly SoundexEncoder _soundexEncoder = new SoundexEncoder();

        [Fact]
        public void Encode_GivenSimilarWords_ReturnsSimilarCodes()
        {
            // Test case 1: Encoding "Robert" and "Rupert" should return similar codes
            string testCase1_word1 = "Robert";
            string testCase1_word2 = "Rupert";
            string encoded_word1 = _soundexEncoder.Encode(testCase1_word1);
            string encoded_word2 = _soundexEncoder.Encode(testCase1_word2);
            Assert.Equal(encoded_word1, encoded_word2);

            // Test case 2: Encoding "Rubin" and "Raben" should return similar codes
            string testCase2_word1 = "Rubin";
            string testCase2_word2 = "Raben";
            encoded_word1 = _soundexEncoder.Encode(testCase2_word1);
            encoded_word2 = _soundexEncoder.Encode(testCase2_word2);
            Assert.Equal(encoded_word1, encoded_word2);
        }

        [Fact]
        public void Encode_GivenDifferentWords_ReturnsDifferentCodes()
        {
            // Test case 1: Encoding "John" and "Jen" should return different codes
            string testCase1_word1 = "John";
            string testCase1_word2 = "Jen";
            string encoded_word1 = _soundexEncoder.Encode(testCase1_word1);
            string encoded_word2 = _soundexEncoder.Encode(testCase1_word2);
            Assert.NotEqual(encoded_word1, encoded_word2);

            // Test case 2: Encoding "Michael" and "Matthew" should return different codes
            string testCase2_word1 = "Michael";
            string testCase2_word2 = "Matthew";
            encoded_word1 = _soundexEncoder.Encode(testCase2_word1);
            encoded_word2 = _soundexEncoder.Encode(testCase2_word2);
            Assert.NotEqual(encoded_word1, encoded_word2);
        }

        [Fact]
        public void Encode_GivenEmptyString_ReturnsEmptyCode()
        {
            string emptyWord = string.Empty;
            string encodedWord = _soundexEncoder.Encode(emptyWord);
            Assert.Equal("000", encodedWord); // No letter (000)
        }

        [Fact]
        public void Encode_GivenSingleCharacterWord_ReturnsCodeWithThreeZeros()
        {
            string singleCharacterWord = "A";
            string encodedWord = _soundexEncoder.Encode(singleCharacterWord);
            Assert.Equal("A000", encodedWord);
        }

        [Fact]
        public void Encode_GivenWordsWithNonAlphaCharacters_ThrowsArgumentException()
        {
            // Test case 1: Encoding "J0hn" should throw ArgumentException
            string testCase1_word = "J0hn";
            Assert.Throws<ArgumentException>(() => _soundexEncoder.Encode(testCase1_word));

            // Test case 2: Encoding "Jane!" should throw ArgumentException
            string testCase2_word = "Jane!";
            Assert.Throws<ArgumentException>(() => _soundexEncoder.Encode(testCase2_word));
        }
    }
}