using System;
using Algorithms.Numeric.Decomposition;
using NUnit.Framework;

namespace Algorithms.Tests.Numeric.Decomposition
{
    [TestFixture]
    public class ThinSvdTests
    {
        [Test]
        public void TestRandomUnitVector_DifferentDimensions()
        {
            int[] dimensions = {2, 3, 4, 5, 6};

            foreach (var dimension in dimensions)
            {
                double[] result = ThinSvd.RandomUnitVector(dimension);
                Assert.AreEqual(dimension, result.Length);

                // Test that the vector is a unit vector by checking ||result|| = 1
                double sumOfSquares = 0;
                for (int i = 0; i < result.Length; i++)
                {
                    sumOfSquares += result[i] * result[i];
                }

                double magnitude = Math.Sqrt(sumOfSquares);
                Assert.AreEqual(1, magnitude, 1e-9);
            }
        }

        [Test]
        public void TestDecompose1D_SimpleMatrix()
        {
            double[,] matrix = {
                {1, 2},
                {3, 4}
            };

            double[] result = ThinSvd.Decompose1D(matrix);
            Assert.AreEqual(2, result.Length);
        }

        [Test]
        public void TestDecompose1D_DifferentParameters()
        {
            double[,] matrix = {
                {1, 2, 3},
                {4, 5, 6}
            };

            double[] result = ThinSvd.Decompose1D(matrix, 1e-8, 1000);
            Assert.AreEqual(3, result.Length);
        }

        [TestCase(4)]
        [TestCase(5)]
        [TestCase(6)]
        public void TestDecompose_DifferentDimensions(int numValues)
        {
            double[,] matrix = new double[numValues, numValues];

            for (int i = 0; i < numValues; i++) // create a square matrix
            {
                for (int j = 0; j < numValues; j++)
                {
                    matrix[i, j] = i * numValues + j;
                }
            }

            var (U, S, V) = ThinSvd.Decompose(matrix);

            Assert.AreEqual(numValues, S.Length);
            Assert.AreEqual(numValues, U.GetLength(0));
            Assert.AreEqual(numValues, U.GetLength(1));
            Assert.AreEqual(numValues, V.GetLength(0));
            Assert.AreEqual(numValues, V.GetLength(1));
        }

        [Test]
        public void TestDecompose_DifferentParameters()
        {
            double[,] matrix = {
                {1, 2, 3},
                {4, 5, 6}
            };

            var (U, S, V) = ThinSvd.Decompose(matrix, 1e-8, 1000);

            Assert.AreEqual(2, S.Length);
            Assert.AreEqual(2, U.GetLength(0));
            Assert.AreEqual(2, U.GetLength(1));
            Assert.AreEqual(3, V.GetLength(0));
            Assert.AreEqual(2, V.GetLength(1));
        }
    }
}