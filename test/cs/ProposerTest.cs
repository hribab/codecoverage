using System.Collections.Generic;
using Xunit;
using Algorithms.Problems.StableMarriage;

namespace Algorithms.Tests
{
    public class ProposerTests
    {
        [Fact]
        public void EngagedTo_Property_HasDefaultValue()
        {
            // Arrange
            var proposer = new Proposer();

            // Act & Assert
            Assert.Null(proposer.EngagedTo);
        }

        [Fact]
        public void EngagedTo_Property_HasNonDefaultValue()
        {
            // Arrange
            var proposer = new Proposer();
            var accepter = new Accepter();

            // Act
            proposer.EngagedTo = accepter;

            // Assert
            Assert.Equal(accepter, proposer.EngagedTo);
        }

        [Fact]
        public void PreferenceOrder_Property_InitializesEmptyList()
        {
            // Arrange & Act
            var proposer = new Proposer();

            // Assert
            Assert.Empty(proposer.PreferenceOrder);
        }

        [Fact]
        public void PreferenceOrder_Property_AllowsAddingItems()
        {
            // Arrange
            var proposer = new Proposer();
            var accepter = new Accepter();

            // Act
            proposer.PreferenceOrder.AddLast(accepter);

            // Assert
            Assert.Single(proposer.PreferenceOrder);
            Assert.Contains(accepter, proposer.PreferenceOrder);
        }

        [Fact]
        public void PreferenceOrder_Property_AllowsRemovingItems()
        {
            // Arrange
            var proposer = new Proposer();
            var accepter = new Accepter();
            proposer.PreferenceOrder.AddLast(accepter);

            // Act
            proposer.PreferenceOrder.Remove(accepter);

            // Assert
            Assert.Empty(proposer.PreferenceOrder);
        }
    }
}