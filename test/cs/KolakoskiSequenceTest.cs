using System.Collections.Generic;
using System.Numerics;
using Algorithms.Sequences;
using Xunit;

namespace Algorithms.Tests.Sequences
{
    public class KolakoskiSequenceTests
    {
        private readonly KolakoskiSequence _kolakoskiSequence;

        public KolakoskiSequenceTests()
        {
            _kolakoskiSequence = new KolakoskiSequence();
        }

        // Test case 1: Check if the first five elements are correct.
        [Fact]
        public void FirstFiveElements_Are_Correct()
        {
            // Arrange
            IEnumerable<BigInteger> expected = new List<BigInteger> { 1, 2, 2, 1, 1 };

            // Act
            IEnumerable<BigInteger> result = _kolakoskiSequence.Sequence;

            // Assert
            Assert.Equal(expected, new List<BigInteger>(result).GetRange(0, 5));
        }

        // Test case 2: Check if the sequence changes correctly based on run length.
        [Fact]
        public void Sequence_Changes_Correctly_Based_On_RunLength()
        {
            // Arrange
            IEnumerable<BigInteger> expected = new List<BigInteger> { 1, 2, 2, 1, 1, 2, 1, 2, 2 };

            // Act
            IEnumerable<BigInteger> result = _kolakoskiSequence.Sequence;

            // Assert
            Assert.Equal(expected, new List<BigInteger>(result).GetRange(0, 9));
        }

        // Test case 3: Check if the sequence can generate a larger number of elements.
        [Fact]
        public void Sequence_Can_Generate_15_Elements()
        {
            // Arrange
            int count = 15;

            // Act
            IEnumerable<BigInteger> result = _kolakoskiSequence.Sequence;

            // Assert
            Assert.Equal(count, new List<BigInteger>(result).GetRange(0, count).Count);
        }

        // Test case 4: Check if the next run function works properly.
        [Fact]
        public void NextRun_Function_Works_Properly()
        {
            // Arrange
            IEnumerable<BigInteger> expectedResult = new List<BigInteger> { 1, 2, 2, 1, 1, 2, 1, 2, 2, 1, 1, 2, 2, 1, 1 };

            // Act
            IEnumerable<BigInteger> result = _kolakoskiSequence.Sequence;

            // Assert
            Assert.Equal(expectedResult, new List<BigInteger>(result).GetRange(0, 15));
        }

        // Test case 5: Check if the sequence element alternates correctly.
        [Fact]
        public void Sequence_Alternates_Correctly()
        {
            // Arrange
            IEnumerable<BigInteger> expectedSequence = new List<BigInteger> { 1, 2, 2, 1, 1, 2, 1, 2, 2, 1, 1, 2, 2, 1, 1 };

            // Act
            IEnumerable<BigInteger> result = _kolakoskiSequence.Sequence;

            // Assert
            Assert.Equal(expectedSequence, new List<BigInteger>(result).GetRange(0, 15));
        }
    }
}