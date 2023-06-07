using System;
using Xunit;
using Algorithms.Numeric;
using System.Collections.Generic;

namespace Algorithms.Tests
{
    public class RungeKuttaMethodTests
    {
        [Theory]
        [InlineData(0, 1, 0.1, 0, (Func<double, double, double>)((x, y) => x+y))]
        [InlineData(0, 2, 0.1, 1, (Func<double, double, double>)((x, y) => x*y))]
        [InlineData(1, 3, 0.1, 2, (Func<double, double, double>)((x, y) => x+y*y))]
        [InlineData(-2, 2, 0.1, 1, (Func<double, double, double>)((x, y) => x*y*y))]
        [InlineData(-1, 1, 0.1, 0, (Func<double, double, double>)((x, y) => x+y*x))]
        public void ClassicRungeKuttaMethod_ValidInputs_ReturnsExpectedResult(double xStart, double xEnd, double stepSize, 
            double yStart, Func<double, double, double> function)
        {
            // Arrange
            List<double[]> expected = new List<double[]>
            {
                { xStart, yStart }
            };

            // Act
            var actual = RungeKuttaMethod.ClassicRungeKuttaMethod(xStart, xEnd, stepSize, yStart, function);

            // Assert
            Assert.Equal(expected[0][0], actual[0][0]);
            Assert.Equal(expected[0][1], actual[0][1]);
        }

        [Fact]
        public void ClassicRungeKuttaMethod_StepSizeLessThanOrEqualToZero_ThrowsArgumentOutOfRangeException()
        {
            // Arrange
            double xStart = 0;
            double xEnd = 1;
            double stepSize = 0;
            double yStart = 0;
            Func<double, double, double> function = (x, y) => x * y;

            // Act and Assert
            Assert.Throws<ArgumentOutOfRangeException>(() => 
                RungeKuttaMethod.ClassicRungeKuttaMethod(xStart, xEnd, stepSize, yStart, function));
        }

        [Fact]
        public void ClassicRungeKuttaMethod_xEndLessThanOrEqualToxStart_ThrowsArgumentOutOfRangeException()
        {
            // Arrange
            double xStart = 1;
            double xEnd = 0;
            double stepSize = 0.1;
            double yStart = 0;
            Func<double, double, double> function = (x, y) => x + y;

            // Act and Assert
            Assert.Throws<ArgumentOutOfRangeException>(() => 
                RungeKuttaMethod.ClassicRungeKuttaMethod(xStart, xEnd, stepSize, yStart, function));
        }

        [Fact]
        public void ClassicRungeKuttaMethod_FunctionIsNull_ThrowsArgumentNullException()
        {
            // Arrange
            double xStart = 0;
            double xEnd = 1;
            double stepSize = 0.1;
            double yStart = 0;
            Func<double, double, double> function = null;

            // Act and Assert
            Assert.Throws<ArgumentNullException>(() => 
                RungeKuttaMethod.ClassicRungeKuttaMethod(xStart, xEnd, stepSize, yStart, function));
        }
    }
}