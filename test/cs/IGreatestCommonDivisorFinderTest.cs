using Xunit;
using Algorithms.Numeric.GreatestCommonDivisor;

namespace Algorithms.Tests.Numeric.GreatestCommonDivisor
{
    public class IGreatestCommonDivisorFinderTests
    {
        private readonly IGreatestCommonDivisorFinder _gcdFinder;

        public IGreatestCommonDivisorFinderTests()
        {
            _gcdFinder = new GreatestCommonDivisorFinder();
        }

        // Test when both numbers are equal
        [Fact]
        public void FindGcd_BothNumbersEqual_ReturnsSameNumber()
        {
            var result = _gcdFinder.FindGcd(7, 7);
            Assert.Equal(7, result);
        }

        // Test when one number is a multiple of the other
        [Fact]
        public void FindGcd_NumberIsMultipleOfOther_ReturnsSmallerNumber()
        {
            var result = _gcdFinder.FindGcd(15, 5);
            Assert.Equal(5, result);
        }

        // Test when one number is a prime number
        [Fact]
        public void FindGcd_OneNumberIsPrime_ReturnsOne()
        {
            var result = _gcdFinder.FindGcd(13, 4);
            Assert.Equal(1, result);
        }

        // Test when both numbers are zeros
        [Fact]
        public void FindGcd_BothNumbersZero_ReturnsZero()
        {
            var result = _gcdFinder.FindGcd(0, 0);
            Assert.Equal(0, result);
        }

        // Test when both numbers are negative
        [Fact]
        public void FindGcd_BothNumbersNegative_ReturnsGcd()
        {
            var result = _gcdFinder.FindGcd(-8, -12);
            Assert.Equal(4, result);
        }
    }
}