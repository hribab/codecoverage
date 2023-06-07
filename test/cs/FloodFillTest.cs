using System;
using System.Drawing;
using Algorithms.Other;
using Xunit;

namespace FloodFillTests
{
    public class FloodFillTests
    {
        private readonly Bitmap _sampleBitmap = new Bitmap(5, 5);

        public FloodFillTests()
        {
            // Initialize sampleBitmap with a red cross inside a blue frame, and a green background.
            for (int i = 0; i < _sampleBitmap.Width; i++)
            {
                for (int j = 0; j < _sampleBitmap.Height; j++)
                {
                    if (i == 0 || i == _sampleBitmap.Width - 1 || j == 0 || j == _sampleBitmap.Height - 1)
                    {
                        _sampleBitmap.SetPixel(i, j, Color.Blue);
                    }
                    else if (i == j || _sampleBitmap.Width - i - 1 == j)
                    {
                        _sampleBitmap.SetPixel(i, j, Color.Red);
                    }
                    else
                    {
                        _sampleBitmap.SetPixel(i, j, Color.Green);
                    }
                }
            }
        }

        [Fact]
        public void BreadthFirstSearch_OutOfBounds_ThrowsArgumentOutOfRangeException()
        {
            Assert.Throws<ArgumentOutOfRangeException>(() => FloodFill.BreadthFirstSearch(_sampleBitmap, (-1, -1), Color.Green, Color.Yellow));
        }

        [Fact]
        public void DepthFirstSearch_OutOfBounds_ThrowsArgumentOutOfRangeException()
        {
            Assert.Throws<ArgumentOutOfRangeException>(() => FloodFill.DepthFirstSearch(_sampleBitmap, (-1, -1), Color.Green, Color.Yellow));
        }

        [Fact]
        public void BreadthFirstSearch_FillGreenWithYellow_Success()
        {
            Bitmap resultBitmap = (Bitmap)_sampleBitmap.Clone();
            FloodFill.BreadthFirstSearch(resultBitmap, (2, 2), Color.Green, Color.Yellow);

            Assert.True(AllPixelsEqualToColor(resultBitmap, Color.Green, Color.Yellow));
        }

        [Fact]
        public void DepthFirstSearch_FillGreenWithYellow_Success()
        {
            Bitmap resultBitmap = (Bitmap)_sampleBitmap.Clone();
            FloodFill.DepthFirstSearch(resultBitmap, (2, 2), Color.Green, Color.Yellow);

            Assert.True(AllPixelsEqualToColor(resultBitmap, Color.Green, Color.Yellow));
        }

        private bool AllPixelsEqualToColor(Bitmap bitmap, Color oldColor, Color newColor)
        {
            for (int i = 0; i < bitmap.Width; i++)
            {
                for (int j = 0; j < bitmap.Height; j++)
                {
                    Color pixelColor = bitmap.GetPixel(i, j);
                    if (pixelColor == oldColor)
                    {
                        return false;
                    }

                    if (pixelColor != newColor)
                    {
                        Assert.Equal(_sampleBitmap.GetPixel(i, j), pixelColor);
                    }
                }
            }

            return true;
        }
    }
}