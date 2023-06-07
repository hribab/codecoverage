using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Strings;

namespace AlgorithmsTests.Strings
{
    [TestClass]
    public class PermutationTests
    {
        // Test case 1: Test with an empty string
        [TestMethod]
        public void TestEmptyString()
        {
            string testWord = "";
            var expectedResult = new List<string> { testWord };
            var result = Permutation.GetEveryUniquePermutation(testWord);
            CollectionAssert.AreEquivalent(expectedResult, result);
        }

        // Test case 2: Test with a single character string
        [TestMethod]
        public void TestSingleCharacterString()
        {
            string testWord = "a";
            var expectedResult = new List<string> { testWord };
            var result = Permutation.GetEveryUniquePermutation(testWord);
            CollectionAssert.AreEquivalent(expectedResult, result);
        }

        // Test case 3: Test with a two-character string
        [TestMethod]
        public void TestTwoCharacterString()
        {
            string testWord = "ab";
            var expectedResult = new List<string> { "ab", "ba" };
            var result = Permutation.GetEveryUniquePermutation(testWord);
            CollectionAssert.AreEquivalent(expectedResult, result);
        }

        // Test case 4: Test with a three-character string
        [TestMethod]
        public void TestThreeCharacterString()
        {
            string testWord = "abc";
            var expectedResult = new List<string> { "abc", "acb", "bac", "bca", "cab", "cba" };
            var result = Permutation.GetEveryUniquePermutation(testWord);
            CollectionAssert.AreEquivalent(expectedResult, result);
        }

        // Test case 5: Test with a string containing duplicate characters
        [TestMethod]
        public void TestStringWithDuplicateCharacters()
        {
            string testWord = "aabc";
            var expectedResult = new List<string>
            {
                "aabc", "aacb", "abac", "abca", "acab", "acba",
                "aabc", "aacb", "abac", "abca", "acab", "acba",
                "baac", "baca", "bac", "bca", "baca", "bcaa",
                "caab", "caba", "cab", "cba", "caba", "cbaa"
            };
            var result = Permutation.GetEveryUniquePermutation(testWord);
            CollectionAssert.AreEquivalent(expectedResult, result);
        }
    }
}