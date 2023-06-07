using System;
using Xunit;
using Algorithms.Strings;

namespace GeneralStringAlgorithmsTests
{
    public class GeneralStringAlgorithmsTests
    {
        [Fact]
        public void FindLongestConsecutiveCharacters_BasicTest()
        {
            // Arrange
            string input = "aaabbccccd";
            Tuple<char, int> expected = new Tuple<char, int>('c', 4);

            // Act
            Tuple<char, int> actual = GeneralStringAlgorithms.FindLongestConsecutiveCharacters(input);

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void FindLongestConsecutiveCharacters_WholeString()
        {
            // Arrange
            string input = "aaaaa";
            Tuple<char, int> expected = new Tuple<char, int>('a', 5);

            // Act
            Tuple<char, int> actual = GeneralStringAlgorithms.FindLongestConsecutiveCharacters(input);

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void FindLongestConsecutiveCharacters_SingleCharacter()
        {
            // Arrange
            string input = "abcde";
            Tuple<char, int> expected = new Tuple<char, int>('a', 1);

            // Act
            Tuple<char, int> actual = GeneralStringAlgorithms.FindLongestConsecutiveCharacters(input);

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void FindLongestConsecutiveCharacters_AtStart()
        {
            // Arrange
            string input = "aaabcdef";
            Tuple<char, int> expected = new Tuple<char, int>('a', 3);

            // Act
            Tuple<char, int> actual = GeneralStringAlgorithms.FindLongestConsecutiveCharacters(input);

            // Assert
            Assert.Equal(expected, actual);
        }

        [Fact]
        public void FindLongestConsecutiveCharacters_AtEnd()
        {
            // Arrange
            string input = "abcdefuuuu";
            Tuple<char, int> expected = new Tuple<char, int>('u', 4);

            // Act
            Tuple<char, int> actual = GeneralStringAlgorithms.FindLongestConsecutiveCharacters(input);

            // Assert
            Assert.Equal(expected, actual);
        }
    }
}