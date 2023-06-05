using Xunit;
using Algorithms.Shufflers;
using System;

namespace Algorithms.Tests
{
    public class IShufflerTests
    {
        private class MyShuffler : IShuffler<int>
        {
            public void Shuffle(int[] array, int? seed = null)
            {
                Random rnd = seed.HasValue ? new Random(seed.Value) : new Random();
                for (int i = array.Length - 1; i > 0; i--)
                {
                    int randomIndex = rnd.Next(0, i + 1);
                    int temp = array[i];
                    array[i] = array[randomIndex];
                    array[randomIndex] = temp;
                }
            }
        }

        [Fact]
        public void Test_Shuffle_OriginalOrder()
        {
            // Arrange
            MyShuffler shuffle = new MyShuffler();
            int[] array1 = {1, 2, 3, 4, 5};

            // Act
            shuffle.Shuffle(array1);

            // Assert
            Assert.NotEqual("{1,2,3,4,5}", $"{array1[0]},{array1[1]},{array1[2]},{array1[3]},{array1[4]}");
        }

        [Fact]
        public void Test_Shuffle_SameSeed()
        {
            // Arrange
            MyShuffler shuffle = new MyShuffler();
            int[] array1 = {1, 2, 3, 4, 5};
            int[] array2 = {1, 2, 3, 4, 5};

            // Act
            shuffle.Shuffle(array1, 123);
            shuffle.Shuffle(array2, 123);

            // Assert
            Assert.Equal($"{array1[0]},{array1[1]},{array1[2]},{array1[3]},{array1[4]}", $"{array2[0]},{array2[1]},{array2[2]},{array2[3]},{array2[4]}");
        }

        [Fact]
        public void Test_Shuffle_DifferentSeeds()
        {
            // Arrange
            MyShuffler shuffle = new MyShuffler();
            int[] array1 = {1, 2, 3, 4, 5};
            int[] array2 = {1, 2, 3, 4, 5};

            // Act
            shuffle.Shuffle(array1, 123);
            shuffle.Shuffle(array2, 456);

            // Assert
            Assert.NotEqual($"{array1[0]},{array1[1]},{array1[2]},{array1[3]},{array1[4]}", $"{array2[0]},{array2[1]},{array2[2]},{array2[3]},{array2[4]}");
        }

        [Fact]
        public void Test_Shuffle_SingleElementArray()
        {
            // Arrange
            MyShuffler shuffle = new MyShuffler();
            int[] array1 = {1};

            // Act
            shuffle.Shuffle(array1);

            // Assert
            Assert.Equal(1, array1[0]);
        }

        [Fact]
        public void Test_Shuffle_EmptyArray()
        {
            // Arrange
            MyShuffler shuffle = new MyShuffler();
            int[] array1 = {};

            // Act
            shuffle.Shuffle(array1);

            // Assert
            Assert.Empty(array1);
        }
    }
}