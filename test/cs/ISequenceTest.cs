using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace Algorithms.Tests.Sequences
{
    public class SequenceTests
    {
        // Mock ISequence implementation for testing purposes
        private class MockSequence : ISequence
        {
            public IEnumerable<BigInteger> Sequence { get; }

            public MockSequence(IEnumerable<BigInteger> sequence)
            {
                Sequence = sequence;
            }
        }

        // Test case 1: Valid sequence
        [Fact]
        public void Test_Valid_Sequence()
        {
            var mockSequence = new MockSequence(new BigInteger[] { 1, 1, 2, 3, 5 });

            int index = 0;
            foreach (var number in mockSequence.Sequence)
            {
                Assert.Equal(index switch
                {
                    0 => 1, // 1st number is 1
                    1 => 1, // 2nd number is 1
                    2 => 2, // 3rd number is 2
                    3 => 3, // 4th number is 3
                    4 => 5  // 5th number is 5
                }, number);

                index++;
            }
        }

        // Test case 2: Empty sequence
        [Fact]
        public void Test_Empty_Sequence()
        {
            var mockSequence = new MockSequence(new BigInteger[] { });
            Assert.Empty(mockSequence.Sequence);
        }

        // Test case 3: Single value sequence
        [Fact]
        public void Test_Single_Value_Sequence()
        {
            var mockSequence = new MockSequence(new BigInteger[] { 42 });
            Assert.Single(mockSequence.Sequence, 42);
        }

        // Test case 4: Multiple same values
        [Fact]
        public void Test_Multiple_Same_Values_Sequence()
        {
            var mockSequence = new MockSequence(new BigInteger[] { 7, 7, 7, 7, 7 });
            foreach (var number in mockSequence.Sequence)
            {
                Assert.Equal(7, number);
            }
        }

        // Test case 5: Large values
        [Fact]
        public void Test_Large_Values_Sequence()
        {
            var mockSequence = new MockSequence(new BigInteger[] { BigInteger.MaxValue, BigInteger.MaxValue - 1 });

            int index = 0;
            foreach (var number in mockSequence.Sequence)
            {
                Assert.Equal(index == 0 ? BigInteger.MaxValue : BigInteger.MaxValue - 1, number);
                index++;
            }
        }
    }
}