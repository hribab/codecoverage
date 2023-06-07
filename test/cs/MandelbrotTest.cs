using System;
using System.Drawing;
using Xunit;
using Algorithms.Other;

namespace Algorithms.Tests
{
    public class MandelbrotTests
    {
        [Fact]
        public void GetBitmap_ValidParameters_ReturnsBitmap()
        {
            // Arrange
            int bitmapWidth = 800;
            int bitmapHeight = 600;
            double figureCenterX = -0.6;
            double figureCenterY = 0;
            double figureWidth = 3.2;
            int maxStep = 50;
            bool useDistanceColorCoding = true;

            // Act
            Bitmap result = Mandelbrot.GetBitmap(bitmapWidth, bitmapHeight, figureCenterX, figureCenterY, figureWidth, maxStep, useDistanceColorCoding);

            // Assert
            Assert.IsType<Bitmap>(result);
            Assert.Equal(bitmapWidth, result.Width);
            Assert.Equal(bitmapHeight, result.Height);
        }

        [Theory]
        [InlineData(0)]
        [InlineData(-1)]
        [InlineData(-100)]
        public void GetBitmap_InvalidBitmapWidth_ThrowsException(int invalidBitmapWidth)
        {
            // Arrange
            int bitmapWidth = invalidBitmapWidth;
            int bitmapHeight = 600;
            double figureCenterX = -0.6;
            double figureCenterY = 0;
            double figureWidth = 3.2;
            int maxStep = 50;
            bool useDistanceColorCoding = true;

            // Act & Assert
            Assert.Throws<ArgumentOutOfRangeException>(() => Mandelbrot.GetBitmap(bitmapWidth, bitmapHeight, figureCenterX, figureCenterY, figureWidth, maxStep, useDistanceColorCoding));
        }

        [Theory]
        [InlineData(0)]
        [InlineData(-1)]
        [InlineData(-100)]
        public void GetBitmap_InvalidBitmapHeight_ThrowsException(int invalidBitmapHeight)
        {
            // Arrange
            int bitmapWidth = 800;
            int bitmapHeight = invalidBitmapHeight;
            double figureCenterX = -0.6;
            double figureCenterY = 0;
            double figureWidth = 3.2;
            int maxStep = 50;
            bool useDistanceColorCoding = true;

            // Act & Assert
            Assert.Throws<ArgumentOutOfRangeException>(() => Mandelbrot.GetBitmap(bitmapWidth, bitmapHeight, figureCenterX, figureCenterY, figureWidth, maxStep, useDistanceColorCoding));
        }

        [Theory]
        [InlineData(0)]
        [InlineData(-1)]
        [InlineData(-100)]
        public void GetBitmap_InvalidMaxStep_ThrowsException(int invalidMaxStep)
        {
            // Arrange
            int bitmapWidth = 800;
            int bitmapHeight = 600;
            double figureCenterX = -0.6;
            double figureCenterY = 0;
            double figureWidth = 3.2;
            int maxStep = invalidMaxStep;
            bool useDistanceColorCoding = true;

            // Act & Assert
            Assert.Throws<ArgumentOutOfRangeException>(() => Mandelbrot.GetBitmap(bitmapWidth, bitmapHeight, figureCenterX, figureCenterY, figureWidth, maxStep, useDistanceColorCoding));
        }

        [Fact]
        public void GetBitmap_BlackAndWhiteColorCoding_ReturnsBitmap()
        {
            // Arrange
            int bitmapWidth = 800;
            int bitmapHeight = 600;
            double figureCenterX = -0.6;
            double figureCenterY = 0;
            double figureWidth = 3.2;
            int maxStep = 50;
            bool useDistanceColorCoding = false;

            // Act
            Bitmap result = Mandelbrot.GetBitmap(bitmapWidth, bitmapHeight, figureCenterX, figureCenterY, figureWidth, maxStep, useDistanceColorCoding);

            // Assert
            Assert.IsType<Bitmap>(result);
            Assert.Equal(bitmapWidth, result.Width);
            Assert.Equal(bitmapHeight, result.Height);
        }
    }
}