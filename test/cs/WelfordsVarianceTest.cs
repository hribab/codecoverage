using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.Other;

namespace Algorithms.Tests.Other
{
    [TestClass]
    public class WelfordsVarianceTests
    {
        [TestMethod]
        // Test empty constructor
        public void TestEmptyConstructor()
        {
            var variance = new WelfordsVariance();
            Assert.AreEqual(0, variance.Count);
            Assert.AreEqual(double.NaN, variance.Mean);
            Assert.AreEqual(double.NaN, variance.Variance);
            Assert.AreEqual(double.NaN, variance.SampleVariance);
        }

        [TestMethod]
        // Test constructor with initial values
        public void TestConstructorWithValues()
        {
            var initialValues = new double[] { 1, 2, 3 };
            var variance = new WelfordsVariance(initialValues);
            Assert.AreEqual(3, variance.Count);
            Assert.AreEqual(2, variance.Mean);
            Assert.AreEqual(2 / 3.0, variance.Variance);
            Assert.AreEqual(1, variance.SampleVariance);
        }

        [TestMethod]
        // Test AddValue method
        public void TestAddValue()
        {
            var variance = new WelfordsVariance();
            variance.AddValue(1);
            variance.AddValue(2);
            variance.AddValue(3);
            Assert.AreEqual(3, variance.Count);
            Assert.AreEqual(2, variance.Mean);
            Assert.AreEqual(2 / 3.0, variance.Variance);
            Assert.AreEqual(1, variance.SampleVariance);
        }

        [TestMethod]
        // Test AddRange method
        public void TestAddRange()
        {
            var variance = new WelfordsVariance();
            variance.AddRange(new double[] { 1, 2, 3 });
            Assert.AreEqual(3, variance.Count);
            Assert.AreEqual(2, variance.Mean);
            Assert.AreEqual(2 / 3.0, variance.Variance);
            Assert.AreEqual(1, variance.SampleVariance);
        }

        [TestMethod]
        // Test updating variance with mixed values
        public void TestMixedValues()
        {
            var initialValues = new double[] { -2, 3, 7 };
            var variance = new WelfordsVariance(initialValues);
            Assert.AreEqual(3, variance.Count);
            Assert.AreEqual(8 / 3.0, variance.Mean);
            Assert.AreEqual(14 / 3.0, variance.Variance);
            Assert.AreEqual(7, variance.SampleVariance);

            variance.AddValue(8);
            Assert.AreEqual(4, variance.Count);
            Assert.AreEqual(4, variance.Mean);
            Assert.AreEqual(15.5, variance.Variance);
            Assert.AreEqual(62 / 3.0, variance.SampleVariance);

            variance.AddRange(new double[] { -1, 4 });
            Assert.AreEqual(6, variance.Count);
            Assert.AreEqual(19 / 6.0, variance.Mean);
            Assert.AreEqual(39 / 6.0, variance.Variance);
            Assert.AreEqual(13, variance.SampleVariance);
        }
    }
}