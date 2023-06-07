using System;
using Algorithms.Strings;
using Xunit;

namespace AlgorithmsTests.Strings
{
    public class JaroSimilarityTests
    {
        /// <summary>
        /// Test with identical strings.
        /// </summary>
        [Fact]
        public void TestIdenticalStrings()
        {
            var result = JaroSimilarity.Calculate("hello", "hello");
            Assert.Equal(1.0, result);
        }

        /// <summary>
        /// Test with completely different strings.
        /// </summary>
        [Fact]
        public void TestCompletelyDifferentStrings()
        {
            var result = JaroSimilarity.Calculate("hello", "world");
            Assert.Equal(0.0, result);
        }

        /// <summary>
        /// Test with partially similar strings.
        /// </summary>
        [Fact]
        public void TestPartiallySimilarStrings()
        {
            var result = JaroSimilarity.Calculate("hello", "helly");
            Assert.Equal(0.8666666666666667, result);
        }

        /// <summary>
        /// Test with similar strings and transpositions.
        /// </summary>
        [Fact]
        public void TestSimilarStringsAndTranspositions()
        {
            var result = JaroSimilarity.Calculate("hello", "lehlo");
            Assert.Equal(0.7333333333333333, result);
        }

        /// <summary>
        /// Test with empty strings.
        /// </summary>
        [Fact]
        public void TestEmptyStrings()
        {
            var result = JaroSimilarity.Calculate("", "");
            Assert.Equal(1.0, result);
        }

        /// <summary>
        /// Test with one empty string and one non-empty string.
        /// </summary>
        [Fact]
        public void TestOneEmptyString()
        {
            var result = JaroSimilarity.Calculate("hello", "");
            Assert.Equal(0.0, result);
        }
    }
}