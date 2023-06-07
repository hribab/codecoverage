using System.Collections.Generic;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

namespace Algorithms.Tests
{
    public class MakeChangeSequenceTests
    {
        private readonly MakeChangeSequence _sequence;

        public MakeChangeSequenceTests()
        {
            _sequence = new MakeChangeSequence();
        }

        [Fact]
        public void Test_FirstFiveValues()
        {
            // Test if the first five values of the sequence are correct
            var expected = new List<BigInteger> { 1, 1, 2, 2, 3 };
            var actual = new List<BigInteger>();

            int count = 0;
            foreach (var value in _sequence.Sequence)
            {
                if (count == expected.Count)
                {
                    break;
                }

                actual.Add(value);
                count++;
            }

            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Test_SequenceIncrement()
        {
            // Test if sequence values are incrementing as expected
            var values = new List<BigInteger>();

            int count = 0;
            foreach (var value in _sequence.Sequence)
            {
                if (count == 20)
                {
                    break;
                }

                values.Add(value);
                count++;
            }

            bool isIncrementing = true;
            for (int i = 1; i < values.Count; i++)
            {
                if (values[i] <= values[i - 1])
                {
                    isIncrementing = false;
                    break;
                }
            }

            Assert.True(isIncrementing, "Sequence values are not incrementing as expected.");
        }

        [Fact]
        public void Test_PartialSumAtTwenty()
        {
            // Test if partial sum at index 20 is correct
            var seq = new List<BigInteger>();
            var sum = new List<BigInteger> { 1 };

            int count = 1;
            foreach (var value in _sequence.Sequence)
            {
                if (count == 20)
                {
                    break;
                }

                count++;
                seq.Add(value);
                sum.Add(value + sum[sum.Count - 1]);
            }

            BigInteger expected = sum[19];
            BigInteger actual = sum[2] + sum[5] - sum[7] + sum[10] - sum[12] - sum[15] + sum[17] + 1;

            Assert.Equal(expected, actual);
        }

        [Fact]
        public void Test_SequenceYield()
        {
            // Test if sequence is yielding correct value at index 30
            BigInteger expected = 673135;
            BigInteger actual = 0;
            int count = 0;

            foreach (var value in _sequence.Sequence)
            {
                if (count == 30)
                {
                    actual = value;
                    break;
                }

                count++;
            }

            Assert.Equal(expected, actual);
        }
    }
}