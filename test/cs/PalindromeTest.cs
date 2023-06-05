using System;
using Xunit;
using Algorithms.Strings;

namespace Algorithms.Tests.Strings
{
    public class PalindromeTests
    {
        [Theory]
        [InlineData("racecar", true)]
        [InlineData("hello", false)]
        [InlineData("1221", true)]
        [InlineData("A man a plan a canal Panama", true)]
        [InlineData("No lemon no melon", true)]
        public void IsStringPalindromeTests(string input, bool expectedResult)
        {
            // Test a valid palindrome
            Assert.Equal(expectedResult, Palindrome.IsStringPalindrome(input));
        }

        [Fact]
        public void IsStringPalindrome_NullInput_ReturnsFalse()
        {
            // Test a null input string
            Assert.False(Palindrome.IsStringPalindrome(null));
        }

        [Fact]
        public void IsStringPalindrome_SingleCharInput_ReturnsTrue()
        {
            // Test a single character string
            Assert.True(Palindrome.IsStringPalindrome("a"));
        }

        [Fact]
        public void IsStringPalindrome_MixedCaseInput_ReturnsTrue()
        {
            // Test a mixed-case palindrome
            Assert.True(Palindrome.IsStringPalindrome("AaBaa"));
        }

        [Fact]
        public void IsStringPalindrome_SpacesAndPunctuation_ReturnsTrue()
        {
            // Test a string with spaces and punctuation
            Assert.True(Palindrome.IsStringPalindrome("Was it a car or a cat I saw?"));
        }

        [Fact]
        public void IsStringPalindrome_EmptyInput_ReturnsTrue()
        {
            // Test an empty string
            Assert.True(Palindrome.IsStringPalindrome(""));
        }
    }
}
