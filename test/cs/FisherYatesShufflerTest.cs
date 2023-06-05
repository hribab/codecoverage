using System;
using Xunit;
using Algorithms.Shufflers;

namespace Algorithms.Tests
{
    public class FisherYatesShufflerTests
    {
        private readonly FisherYatesShuffler<int> _shuffler;

        public FisherYatesShufflerTests()
        {
            _shuffler = new FisherYatesShuffler<int>();
        }

        [Fact]
        public void Shuffle_NullArray_ThrowsArgumentNullException()
        {
            // Arrange
            int[] array = null;

            // Act & Assert
            Assert.Throws<ArgumentNullException>(() => _shuffler.Shuffle(array));
        }

        [Fact]
        public void Shuffle_EmptyArray_ShouldNotModifyArray()
        {
            // Arrange
            int[] array = new int[0];
            int[] expected = new int[0];

            // Act
            _shuffler.Shuffle(array);

            // Assert
            Assert.Equal(expected, array);
        }

        [Theory]
        [InlineData(new int[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 })]
        public void Shuffle_ShuffleOnceAndThenShuffleWithSameSeed_ResultShouldBeTheSame(int[] array)
        {
            // Arrange
            int[] shuffledFirstTime = new int[array.Length];
            Array.Copy(array, shuffledFirstTime, array.Length);
            _shuffler.Shuffle(shuffledFirstTime, seed: 42);

            // Act
            int[] shuffledSecondTime = new int[array.Length];
            Array.Copy(array, shuffledSecondTime, array.Length);
            _shuffler.Shuffle(shuffledSecondTime, seed: 42);

            // Assert
            Assert.Equal(shuffledFirstTime, shuffledSecondTime);
        }

        [Theory]
        [InlineData(new int[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 })]
        public void Shuffle_ShuffleWithDifferentSeeds_ShouldNotBeTheSame(int[] array)
        {
            // Arrange
            int[] shuffledFirstTime = new int[array.Length];
            Array.Copy(array, shuffledFirstTime, array.Length);
            _shuffler.Shuffle(shuffledFirstTime, seed: 42);

            // Act
            int[] shuffledSecondTime = new int[array.Length];
            Array.Copy(array, shuffledSecondTime, array.Length);
            _shuffler.Shuffle(shuffledSecondTime, seed: 1337);

            // Assert
            Assert.NotEqual(shuffledFirstTime, shuffledSecondTime);
        }

        [Theory]
        [InlineData(new int[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 })]
        public void Shuffle_ShuffleSingleElementArray_ShouldNotModifyArray(int[] array)
        {
            // Arrange
            int[] singleElementArray = new int[] { array[0] };
            int[] expected = new int[] { array[0] };

            // Act
            _shuffler.Shuffle(singleElementArray);

            // Assert
            Assert.Equal(expected, singleElementArray);
        }
    }
}