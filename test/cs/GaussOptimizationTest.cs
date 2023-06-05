using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Other;

namespace UnitTests
{
    [TestClass]
    public class GaussOptimizationTests
    {
        // Test function to find extremum
        private static double TestFunction(double x1, double x2)
        {
            return -(x1 * x1 + x2 * x2);
        }

        // Test case #1: Check the extremum found by the GaussOptimization method with a given initial guess.
        [TestMethod]
        public void GaussOptimization_Optimize_GivenInitialGuess()
        {
            // Arrange
            GaussOptimization gaussOptimization = new GaussOptimization();
            double x1 = 3;
            double x2 = 3;

            // Act
            (double optimX1, double optimX2) = gaussOptimization.Optimize(TestFunction, 2, 0.1, 0.0001, x1, x2);

            // Assert
            Assert.IsTrue(Math.Abs(optimX1) < 0.1 && Math.Abs(optimX2) < 0.1);
        }

        // Test case #2: Test the method with high accuracy.
        [TestMethod]
        public void GaussOptimization_Optimize_HighAccuracy()
        {
            // Arrange
            GaussOptimization gaussOptimization = new GaussOptimization();
            double x1 = 3;
            double x2 = 3;

            // Act
            (double optimX1, double optimX2) = gaussOptimization.Optimize(TestFunction, 2, 0.1, 0.0000001, x1, x2);

            // Assert
            Assert.IsTrue(Math.Abs(optimX1) < 0.0001 && Math.Abs(optimX2) < 0.0001);
        }

        // Test case #3: Test the method with a large step size.
        [TestMethod]
        public void GaussOptimization_Optimize_LargeStepSize()
        {
            // Arrange
            GaussOptimization gaussOptimization = new GaussOptimization();
            double x1 = 3;
            double x2 = 3;

            // Act
            (double optimX1, double optimX2) = gaussOptimization.Optimize(TestFunction, 2, 1, 0.0001, x1, x2);

            // Assert
            Assert.IsTrue(Math.Abs(optimX1) < 0.1 && Math.Abs(optimX2) < 0.1);
        }

        // Test case #4: Test the method with a small step size.
        [TestMethod]
        public void GaussOptimization_Optimize_SmallStepSize()
        {
            // Arrange
            GaussOptimization gaussOptimization = new GaussOptimization();
            double x1 = 3;
            double x2 = 3;

            // Act
            (double optimX1, double optimX2) = gaussOptimization.Optimize(TestFunction, 2, 0.01, 0.0001, x1, x2);

            // Assert
            Assert.IsTrue(Math.Abs(optimX1) < 0.1 && Math.Abs(optimX2) < 0.1);
        }

        // Test case #5: Test the method with a large number of step reductions per iteration.
        [TestMethod]
        public void GaussOptimization_Optimize_LargeNumberOfStepReductions()
        {
            // Arrange
            GaussOptimization gaussOptimization = new GaussOptimization();
            double x1 = 3;
            double x2 = 3;

            // Act
            (double optimX1, double optimX2) = gaussOptimization.Optimize(TestFunction, 10, 0.1, 0.0001, x1, x2);

            // Assert
            Assert.IsTrue(Math.Abs(optimX1) < 0.1 && Math.Abs(optimX2) < 0.1);
        }
    }
}