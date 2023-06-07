using System;
using Xunit;
using Algorithms.Numeric;

namespace Algorithms.Tests.Numeric
{
    public class KeithNumberCheckerTests
    {
        /// <summary>
        /// Test case for negative number.
        /// </summary>
        [Fact]
        public void IsKeithNumber_NegativeNumber_ThrowsArgumentException()
        {
            Assert.Throws<ArgumentException>(() => KeithNumberChecker.IsKeithNumber(-5));
        }

        /// <summary>
        /// Test case for zero which should return false.
        /// </summary>
        [Fact]
        public void IsKeithNumber_Zero_ReturnsFalse()
        {
            Assert.False(KeithNumberChecker.IsKeithNumber(0));
        }

        /// <summary>
        /// Test case for known Keith numbers in the range 10-100.
        /// </summary>
        [Theory]
        [InlineData(14)]
        [InlineData(19)]
        [InlineData(28)]
        [InlineData(47)]
        [InlineData(61)]
        [InlineData(75)]
        public void IsKeithNumber_KnownKeithNumbers_ReturnsTrue(int number)
        {
            Assert.True(KeithNumberChecker.IsKeithNumber(number));
        }

        /// <summary>
        /// Test case for known Non-Keith numbers in the range 10-100.
        /// </summary>
        [Theory]
        [InlineData(12)]
        [InlineData(16)]
        [InlineData(20)]
        [InlineData(25)]
        [InlineData(30)]
        public void IsKeithNumber_NonKeithNumbers_ReturnsFalse(int number)
        {
            Assert.False(KeithNumberChecker.IsKeithNumber(number));
        }

        /// <summary>
        /// Test case for very large number.
        /// </summary>
        [Fact]
        public void IsKeithNumber_VeryLargeNumber_ReturnsFalse()
        {
            Assert.False(KeithNumberChecker.IsKeithNumber(987654321));
        }
    }
}