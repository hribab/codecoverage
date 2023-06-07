using Xunit;
using Algorithms.Encoders;
using System.Globalization;

namespace Algorithms.Tests.Encoders
{
    public class NysiisEncoderTests
    {
        private readonly NysiisEncoder _encoder;

        public NysiisEncoderTests()
        {
            _encoder = new NysiisEncoder();
        }

        [Theory]
        [InlineData("Jenkins", "JENKNS")]
        [InlineData("Robert", "RABAD")]
        [InlineData("Elizabeth", "ALZABAD")]
        [InlineData("Alexander", "ALAXAND")]
        // Ensure casing doesn't affect result
        [InlineData("jEnKiNs", "JENKNS")]
        [InlineData("ElIzaBeTh", "ALZABAD")]
        public void Encode_ReturnsCorrectNysiisEncoding(string text, string expectedResult)
        {
            // Act
            string result = _encoder.Encode(text);

            // Assert
            Assert.Equal(expectedResult, result);
        }

        [Fact]
        public void Encode_EmptyString_ReturnsEmptyString()
        {
            // Act
            string result = _encoder.Encode(string.Empty);

            // Assert
            Assert.Equal(string.Empty, result);
        }

        [Fact]
        public void Encode_AllVowels_ReturnsSingleA()
        {
            // Arrange
            string text = "AEIOU";

            // Act
            string result = _encoder.Encode(text);

            // Assert
            Assert.Equal("A", result);
        }

        [Fact]
        public void Encode_AllConsonants_ReturnsCorrectEncoding()
        {
            // Arrange
            string text = "BCDFGHJKLMNPQRSTVWXYZ";

            // Act
            string result = _encoder.Encode(text);

            // Assert
            Assert.Equal("BCDFFGJLNNPQRSTVYS", result);
        }

        [Fact]
        public void Encode_SpecialCharacters_ReturnsCorrectEncoding()
        {
            // Arrange
            string text = "Th@ O^d - C!ty_r";

            // Act
            string result = _encoder.Encode(text);

            // Assert
            Assert.Equal("THAD OCATAR", result);
        }
    }
}