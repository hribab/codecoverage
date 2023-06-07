using System;
using System.Collections.Generic;
using NUnit.Framework;
using Algorithms.Knapsack;

namespace AlgorithmsTests
{
    public class NaiveKnapsackSolverTests
    {
        [Test]
        // Test when capacity is 0, expect an empty array.
        public void Test_CapacityIs0_ReturnEmptyArray()
        {
            double[] items = new double[] { 10, 5, 3, 7, 2, 6 };
            double capacity = 0;
            var naiveKnapsack = new NaiveKnapsackSolver<double>();

            var result = naiveKnapsack.Solve(items, capacity, weight => weight, value => value);

            Assert.AreEqual(0, result.Length);
        }

        [Test]
        // Test when all items can fit into the capacity.
        public void Test_AllItemsFit_ReturnAllItems()
        {
            double[] items = new double[] { 10, 5, 3, 7, 2, 6 };
            double capacity = 50;
            var naiveKnapsack = new NaiveKnapsackSolver<double>();

            var result = naiveKnapsack.Solve(items, capacity, weight => weight, value => value);

            Assert.AreEqual(items.Length, result.Length);
            CollectionAssert.AreEquivalent(items, result);
        }

        [Test]
        // Test when some items can fit into the capacity.
        public void Test_SomeItemsFit_ReturnSomeItems()
        {
            double[] items = new double[] { 10, 11, 3, 30, 15, 17 };
            double capacity = 20;
            var naiveKnapsack = new NaiveKnapsackSolver<double>();

            var result = naiveKnapsack.Solve(items, capacity, weight => weight, value => value);

            double[] expectedResult = new double[] { 10, 3 };
            CollectionAssert.AreEquivalent(expectedResult, result);
        }

        [Test]
        // Test when only the first item can fit into the capacity.
        public void Test_OnlyFirstItemFit_ReturnFirstItem()
        {
            double[] items = new double[] { 5, 15, 9, 12, 21 };
            double capacity = 7;
            var naiveKnapsack = new NaiveKnapsackSolver<double>();

            var result = naiveKnapsack.Solve(items, capacity, weight => weight, value => value);

            double[] expectedResult = new double[] { 5 };
            CollectionAssert.AreEquivalent(expectedResult, result);
        }

        [Test]
        // Test when none of the items can fit into the capacity.
        public void Test_NoneOfItemsFit_ReturnEmptyArray()
        {
            double[] items = new double[] { 10, 8, 6, 5, 9 };
            double capacity = 2;
            var naiveKnapsack = new NaiveKnapsackSolver<double>();

            var result = naiveKnapsack.Solve(items, capacity, weight => weight, value => value);

            Assert.AreEqual(0, result.Length);
        }
    }
}