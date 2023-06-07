using System;
using Algorithms.Strings;
using Xunit;

namespace Algorithms.Tests
{
    public class HammingDistanceTests
    {
        // Test case 1: Two identical strings
        [Fact]
        public void TestIdenticalStrings()
        {
            string s1 = "abcabc";
            string s2 = "abcabc";
            int expected = 0;

            int actual = HammingDistance.Calculate(s1, s2);

            Assert.Equal(expected, actual);
        }

        // Test case 2: Two completely different strings
        [Fact]
        public void TestDifferentStrings()
        {
            string s1 = "abcabc";
            string s2 = "defdef";
            int expected = 6;

            int actual = HammingDistance.Calculate(s1, s2);

            Assert.Equal(expected, actual);
        }

        // Test case 3: Two strings with some differences
        [Fact]
        public void TestSomeDifferences()
        {
            string s1 = "abcdef";
            string s2 = "abcdeF";
            int expected = 1;

            int actual = HammingDistance.Calculate(s1, s2);

            Assert.Equal(expected, actual);
        }

        // Test case 4: One string is empty
        [Fact]
        public void TestEmptyString()
        {
            string s1 = "";
            string s2 = "abc";

            Assert.Throws<ArgumentException>(() => HammingDistance.Calculate(s1, s2));
        }

        // Test case 5: Two strings have different lengths
        [Fact]
        public void TestDifferentLength()
        {
            string s1 = "abc";
            string s2 = "abcd";

            Assert.Throws<ArgumentException>(() => HammingDistance.Calculate(s1, s2));
        }
    }
}