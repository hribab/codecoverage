using System;
using Xunit;
using Algorithms.Other;

namespace Algorithms.Tests
{
    public class PollardsRhoFactorizingTests
    {
        [Fact]
        public void Calculate_PrimeNumber_ReturnsOne()
        {
            // Arrange
            int primeNumber = 37;

            // Act
            int result = PollardsRhoFactorizing.Calculate(primeNumber);

            // Assert
            Assert.Equal(1, result);
        }

        [Fact]
        public void Calculate_CompositeNumber_ReturnsNonTrivialFactor()
        {
            // Arrange
            int compositeNumber = 24;

            // Act
            int factor = PollardsRhoFactorizing.Calculate(compositeNumber);

            // Assert
            Assert.True(compositeNumber % factor == 0 && factor != 1 && factor != compositeNumber);
        }

        [Fact]
        public void Calculate_CompositeNumberWithLargePrimeFactor_ReturnsNonTrivialFactor()
        {
            // Arrange
            int largePrimeFactor = 61;
            int compositeNumber = largePrimeFactor * 8;

            // Act
            int factor = PollardsRhoFactorizing.Calculate(compositeNumber);

            // Assert
            Assert.True(compositeNumber % factor == 0 && factor != 1 && factor != compositeNumber);
        }

        [Fact]
        public void Calculate_NumberOne_ReturnsOne()
        {
            // Arrange
            int number = 1;

            // Act
            int result = PollardsRhoFactorizing.Calculate(number);

            // Assert
            Assert.Equal(1, result);
        }

        [Fact]
        public void Calculate_EvenNumber_ReturnsTwo()
        {
            // Arrange
            int evenNumber = 54;

            // Act
            int result = PollardsRhoFactorizing.Calculate(evenNumber);

            // Assert
            Assert.Equal(2, result);
        }
    }
}