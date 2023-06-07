using System;
using Xunit;
using Algorithms.Other;

public class RgbHsvConversionTests
{
    [Fact]
    public void HsvToRgb_0_0_0()
    {
        // Arrange
        double hue = 0;
        double saturation = 0;
        double value = 0;

        // Act
        var result = RgbHsvConversion.HsvToRgb(hue, saturation, value);

        // Assert
        Assert.Equal((byte)0, result.red);
        Assert.Equal((byte)0, result.green);
        Assert.Equal((byte)0, result.blue);
    }

    [Fact]
    public void HsvToRgb_120_1_1()
    {
        // Arrange
        double hue = 120;
        double saturation = 1;
        double value = 1;

        // Act
        var result = RgbHsvConversion.HsvToRgb(hue, saturation, value);

        // Assert
        Assert.Equal((byte)0, result.red);
        Assert.Equal((byte)255, result.green);
        Assert.Equal((byte)0, result.blue);
    }

    [Fact]
    public void HsvToRgb_240_1_1()
    {
        // Arrange
        double hue = 240;
        double saturation = 1;
        double value = 1;

        // Act
        var result = RgbHsvConversion.HsvToRgb(hue, saturation, value);

        // Assert
        Assert.Equal((byte)0, result.red);
        Assert.Equal((byte)0, result.green);
        Assert.Equal((byte)255, result.blue);
    }

    [Fact]
    public void HsvToRgb_180_0_1()
    {
        // Arrange
        double hue = 180;
        double saturation = 0;
        double value = 1;

        // Act
        var result = RgbHsvConversion.HsvToRgb(hue, saturation, value);

        // Assert
        Assert.Equal((byte)255, result.red);
        Assert.Equal((byte)255, result.green);
        Assert.Equal((byte)255, result.blue);
    }

    [Fact]
    public void HsvToRgb_45_0_0()
    {
        // Arrange
        double hue = 45;
        double saturation = 0;
        double value = 0;

        // Act
        var result = RgbHsvConversion.HsvToRgb(hue, saturation, value);

        // Assert
        Assert.Equal((byte)0, result.red);
        Assert.Equal((byte)0, result.green);
        Assert.Equal((byte)0, result.blue);
    }

    [Fact]
    public void RgbToHsv_0_0_0()
    {
        // Arrange
        byte red = 0;
        byte green = 0;
        byte blue = 0;

        // Act
        var result = RgbHsvConversion.RgbToHsv(red, green, blue);

        // Assert
        Assert.Equal(0, result.hue);
        Assert.Equal(0, result.saturation);
        Assert.Equal(0, result.value);
    }

    [Fact]
    public void RgbToHsv_0_255_0()
    {
        // Arrange
        byte red = 0;
        byte green = 255;
        byte blue = 0;

        // Act
        var result = RgbHsvConversion.RgbToHsv(red, green, blue);

        // Assert
        Assert.Equal(120, result.hue);
        Assert.Equal(1, result.saturation);
        Assert.Equal(1, result.value);
    }

    [Fact]
    public void RgbToHsv_0_0_255()
    {
        // Arrange
        byte red = 0;
        byte green = 0;
        byte blue = 255;

        // Act
        var result = RgbHsvConversion.RgbToHsv(red, green, blue);

        // Assert
        Assert.Equal(240, result.hue);
        Assert.Equal(1, result.saturation);
        Assert.Equal(1, result.value);
    }

    [Fact]
    public void RgbToHsv_255_255_255()
    {
        // Arrange
        byte red = 255;
        byte green = 255;
        byte blue = 255;

        // Act
        var result = RgbHsvConversion.RgbToHsv(red, green, blue);

        // Assert
        Assert.Equal(0, result.hue);
        Assert.Equal(0, result.saturation);
        Assert.Equal(1, result.value);
    }

    [Fact]
    public void RgbToHsv_255_128_64()
    {
        // Arrange
        byte red = 255;
        byte green = 128;
        byte blue = 64;

        // Act
        var result = RgbHsvConversion.RgbToHsv(red, green, blue);

        // Assert
        Assert.Equal(20, result.hue, 1);
        Assert.Equal(0.749, result.saturation, 3);
        Assert.Equal(1, result.value);
    }
}