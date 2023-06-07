using System;
using Xunit;
using Algorithms.Numeric.Decomposition;
using Algorithms.Numeric.Pseudoinverse;

namespace Algorithms.Numeric.Tests
{
    public class PseudoInverseTests
    {
        [Fact]
        public void PInvTest_Matrix1()
        {
            // Prepare input matrix
            double[,] matrix = new double[,]
            {
                { 1, 2 },
                { 3, 4 }
            };

            // Call PInv method for the input matrix
            double[,] result = PseudoInverse.PInv(matrix);

            // Expected result matrix
            double[,] expectedResult = new double[,]
            {
                { -2, 1 },
                { 1.5, -0.5 }
            };

            // Check if the result and expected result matrices have the same values.
            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                for (int j = 0; j < matrix.GetLength(1); j++)
                {
                    Assert.Equal(expectedResult[i, j], result[i, j], 5);
                }
            }
        }

        [Fact]
        public void PInvTest_Matrix2()
        {
            // Prepare input matrix
            double[,] matrix = new double[,]
            {
                { 5, 7 },
                { 6, 10 },
                { 2, 4 }
            };

            // Call PInv method for the input matrix
            double[,] result = PseudoInverse.PInv(matrix);

            // Expected result matrix
            double[,] expectedResult = new double[,]
            {
                { 0.10344828, -0.11494253, 0.34482759 },
                { -0.13793103, 0.18390805, 0.08045977 }
            };

            // Check if the result and expected result matrices have the same values.
            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                for (int j = 0; j < matrix.GetLength(1); j++)
                {
                    Assert.Equal(expectedResult[i, j], result[i, j], 5);
                }
            }
        }

        [Fact]
        public void PInvTest_IdentityMatrix()
        {
            // Prepare input matrix
            double[,] matrix = new double[,]
            {
                { 1, 0 },
                { 0, 1 }
            };

            // Call PInv method for the input matrix
            double[,] result = PseudoInverse.PInv(matrix);

            // Check if the result and input matrices have the same values.
            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                for (int j = 0; j < matrix.GetLength(1); j++)
                {
                    Assert.Equal(matrix[i, j], result[i, j], 5);
                }
            }
        }

        [Fact]
        public void PInvTest_ZeroMatrix()
        {
            // Prepare input matrix
            double[,] matrix = new double[,]
            {
                { 0, 0 },
                { 0, 0 }
            };

            // Call PInv method for the input matrix
            double[,] result = PseudoInverse.PInv(matrix);

            // Check if the result values are approximately zero.
            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                for (int j = 0; j < matrix.GetLength(1); j++)
                {
                    Assert.True(Math.Abs(result[i, j]) < 0.0001);
                }
            }
        }

        [Fact]
        public void PInvTest_OneElementMatrix()
        {
            // Prepare input matrix
            double[,] matrix = new double[,]
            {
                { 5 }
            };

            // Call PInv method for the input matrix
            double[,] result = PseudoInverse.PInv(matrix);

            // Expected result
            double[,] expectedResult = new double[,]
            {
                { 0.2 }
            };

            // Check if the expected result and result matrices have the same values.
            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                for (int j = 0; j < matrix.GetLength(1); j++)
                {
                    Assert.Equal(expectedResult[i, j], result[i, j], 5);
                }
            }
        }
    }
}