using System;
using Xunit;
using Algorithms.Encoders;
using Algorithms.Numeric;

public class HillEncoderTests
{
    // An instance of the HillEncoder class for testing purposes
    private HillEncoder _encoder = new HillEncoder();

    [Fact]
    public void Encode_WithEmptyString_ReturnsEmptyString()
    {
        // Arrange
        string input = "";
        double[,] key = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 } };

        // Act
        string result = _encoder.Encode(input, key);

        // Assert
        Assert.Empty(result);
    }

    [Fact]
    public void Encode_WithValidString_ReturnsEncodedString()
    {
        // Arrange
        string input = "hello world";
        double[,] key = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 } };

        // Act
        string result = _encoder.Encode(input, key);

        // Assert
        Assert.Equal("䓍坶獽挤㲐崾⬼", result);
    }

    [Fact]
    public void Decode_WithEmptyString_ReturnsEmptyString()
    {
        // Arrange
        string input = "";
        double[,] key = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 } };

        // Act
        string result = _encoder.Decode(input, key);

        // Assert
        Assert.Empty(result);
    }

    [Fact]
    public void Decode_WithValidString_ReturnsDecodedString()
    {
        // Arrange
        string input = "䓍坶獽挤㲐崾⬼";
        double[,] key = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 } };

        // Act
        string result = _encoder.Decode(input, key);

        // Assert
        Assert.Equal("hello world", result);
    }

    [Fact]
    public void EncodeAndDecode_WithValidStringAndKey_ReturnsOriginalString()
    {
        // Arrange
        string input = "hello world";
        double[,] key = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 } };

        // Act
        string encoded = _encoder.Encode(input, key);
        string decoded = _encoder.Decode(encoded, key);

        // Assert
        Assert.Equal(input, decoded);
    }
}