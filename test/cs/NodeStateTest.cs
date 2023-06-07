using Algorithms.Search.AStar;
using Xunit;

namespace AStarTests
{
    public class NodeStateTests
    {
        /// <summary>
        /// Test if the value of NodeState.Unconsidered is 0.
        ///</summary>
        [Fact]
        public void UnconsideredValue_IsZero()
        {
            Assert.Equal(0, (int)NodeState.Unconsidered);
        }
        
        /// <summary>
        /// Test if the value of NodeState.Open is 1.
        ///</summary>
        [Fact]
        public void OpenValue_IsOne()
        {
            Assert.Equal(1, (int)NodeState.Open);
        }

        /// <summary>
        /// Test if the value of NodeState.Closed is 2.
        ///</summary>
        [Fact]
        public void ClosedValue_IsTwo()
        {
            Assert.Equal(2, (int)NodeState.Closed);
        }

        /// <summary>
        /// Test if there are no other enum values except Unconsidered, Open, and Closed.
        ///</summary>
        [Fact]
        public void EnumValuesCount_IsThree()
        {
            int enumValuesCount = Enum.GetNames(typeof(NodeState)).Length;
            Assert.Equal(3, enumValuesCount);
        }

        /// <summary>
        /// Test if stringValue of enum values are as expected
        ///</summary>
        [Fact]
        public void EnumStringValue_IsExpected()
        {
            Assert.Equal("Unconsidered", NodeState.Unconsidered.ToString());
            Assert.Equal("Open", NodeState.Open.ToString());
            Assert.Equal("Closed", NodeState.Closed.ToString());
        }
    }
}