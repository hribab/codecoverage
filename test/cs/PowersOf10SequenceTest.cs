using System.Collections.Generic;
using System.Numerics;
using Xunit;
using Algorithms.Sequences;

namespace Algorithms.Tests
{
    public class PowersOf10SequenceTests
    {
        private readonly PowersOf10Sequence _powersOf10Sequence;

        public PowersOf10SequenceTests()
        {
            _powersOf10Sequence = new PowersOf10Sequence();
        }

        [Fact]
        public void Test_PowersOf10Sequence()
        {
            // Arrange
            BigInteger[] expectedPowersOf10 = { 1, 10, 100, 1000, 10000 };
            var enumerator = _powersOf10Sequence.Sequence.GetEnumerator();

            // Act & Assert
            foreach (var expectedPower in expectedPowersOf10)
            {
                enumerator.MoveNext();
                Assert.Equal(expectedPower, enumerator.Current);
            }
        }
    }
}