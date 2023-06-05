using System;
using Algorithms.Encoders;
using Xunit;

namespace Algorithm.Tests.Encoders
{
    public class VigenereEncoderTests
    {
        private readonly VigenereEncoder _encoder;

        public VigenereEncoderTests()
        {
            _encoder = new VigenereEncoder();
        }

        // Test for Encode method
        [Theory]
        // Test with a simple sentence and a simple key
        [InlineData("hello world", "key", "rirom vgksr")]
        // Test with an all-uppercase sentence and a simple key
        [InlineData("HELLO WORLD", "key", "RIROM VGKSR")]
        // Test with a sentence containing numbers and special characters and a simple key
        [InlineData("hello w0rld!", "key", "rirom vgksr!")]
        // Test with a simple sentence and an all-uppercase key
        [InlineData("hello world", "KEY", "rirom vgksr")]
        // Test with a simple sentence and a longer key
        [InlineData("hello world", "encryption", "dioee koyrn")]
        public void Encode_ValidInput_ReturnsEncodedText(string text, string key, string expected)
        {
            var result = _encoder.Encode(text, key);

            Assert.Equal(expected, result);
        }

        // Test for Decode method
        [Theory]
        // Test with a simple encoded text and a simple key
        [InlineData("rirom vgksr", "key", "hello world")]
        // Test with an all-uppercase encoded text and a simple key
        [InlineData("RIROM VGKSR", "key", "HELLO WORLD")]
        // Test with an encoded text containing numbers and special characters and a simple key
        [InlineData("rirom vgksr!", "key", "hello w0rld!")]
        // Test with a simple encoded text and an all-uppercase key
        [InlineData("rirom vgksr", "KEY", "hello world")]
        // Test with a simple encoded text and a longer key
        [InlineData("dioee koyrn", "encryption", "hello world")]
        public void Decode_ValidInput_ReturnsDecodedText(string text, string key, string expected)
        {
            var result = _encoder.Decode(text, key);

            Assert.Equal(expected, result);
        }
    }
}