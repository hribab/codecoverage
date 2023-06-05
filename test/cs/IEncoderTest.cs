using System;
using Xunit;
using Algorithms.Encoders;

namespace Algorithms.Tests
{
    public class EncoderTests
    {
        private class TestEncoder : IEncoder<int>
        {
            public string Encode(string text, int key)
            {
                return new string(Array.ConvertAll(text.ToCharArray(), c => (char)(c + key)));
            }

            public string Decode(string text, int key)
            {
                return new string(Array.ConvertAll(text.ToCharArray(), c => (char)(c - key)));
            }
        }

        private readonly TestEncoder _testEncoder;

        public EncoderTests()
        {
            _testEncoder = new TestEncoder();
        }

        // Test case 1: Empty text and key = 0
        [Fact]
        public void Test_EmptyText_ZeroKey()
        {
            string text = "";
            int key = 0;

            string encoded = _testEncoder.Encode(text, key);
            string decoded = _testEncoder.Decode(encoded, key);

            Assert.Equal(text, decoded);
        }

        // Test case 2: Simple text and key = 1
        [Fact]
        public void Test_SimpleText_PositiveKey()
        {
            string text = "Hello";
            int key = 1;

            string encoded = _testEncoder.Encode(text, key);
            string decoded = _testEncoder.Decode(encoded, key);

            Assert.Equal(text, decoded);
        }

        // Test case 3: Simple text and key = -1
        [Fact]
        public void Test_SimpleText_NegativeKey()
        {
            string text = "Hello";
            int key = -1;

            string encoded = _testEncoder.Encode(text, key);
            string decoded = _testEncoder.Decode(encoded, key);

            Assert.Equal(text, decoded);
        }

        // Test case 4: Text with special characters and key = 5
        [Fact]
        public void Test_TextWithSpecialCharacters_PositiveKey()
        {
            string text = "H@ll0 W@rld!";
            int key = 5;

            string encoded = _testEncoder.Encode(text, key);
            string decoded = _testEncoder.Decode(encoded, key);

            Assert.Equal(text, decoded);
        }

        // Test case 5: Text with special characters and key = -5
        [Fact]
        public void Test_TextWithSpecialCharacters_NegativeKey()
        {
            string text = "H@ll0 W@rld!";
            int key = -5;

            string encoded = _testEncoder.Encode(text, key);
            string decoded = _testEncoder.Decode(encoded, key);

            Assert.Equal(text, decoded);
        }
    }
}