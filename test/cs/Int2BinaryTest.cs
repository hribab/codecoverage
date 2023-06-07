using System;
using Xunit;
using Algorithms.Other;

namespace Algorithms.Tests.Other
{
    public class Int2BinaryTests
    {
        [Theory]
        [InlineData(ushort.MaxValue, "1111111111111111")]
        [InlineData(0, "0000000000000000")]
        [InlineData(1, "0000000000000001")]
        [InlineData(10, "0000000000001010")]
        [InlineData(65534, "1111111111111110")]
        public void Int2Bin_ushort_ShouldReturnCorrectBinaryRepresentation(ushort input, string expectedResult)
        {
            string result = Int2Binary.Int2Bin(input);
            Assert.Equal(expectedResult, result);
        }

        [Theory]
        [InlineData(uint.MaxValue, "11111111111111111111111111111111")]
        [InlineData(0U, "00000000000000000000000000000000")]
        [InlineData(1U, "00000000000000000000000000000001")]
        [InlineData(10U, "00000000000000000000000000001010")]
        [InlineData(4294967294U, "11111111111111111111111111111110")]
        public void Int2Bin_uint_ShouldReturnCorrectBinaryRepresentation(uint input, string expectedResult)
        {
            string result = Int2Binary.Int2Bin(input);
            Assert.Equal(expectedResult, result);
        }

        [Theory]
        [InlineData(ulong.MaxValue, "1111111111111111111111111111111111111111111111111111111111111111")]
        [InlineData(0UL, "0000000000000000000000000000000000000000000000000000000000000000")]
        [InlineData(1UL, "0000000000000000000000000000000000000000000000000000000000000001")]
        [InlineData(10UL, "0000000000000000000000000000000000000000000000000000000000001010")]
        [InlineData(18446744073709551614UL, "1111111111111111111111111111111111111111111111111111111111111110")]
        public void Int2Bin_ulong_ShouldReturnCorrectBinaryRepresentation(ulong input, string expectedResult)
        {
            string result = Int2Binary.Int2Bin(input);
            Assert.Equal(expectedResult, result);
        }
    }
}