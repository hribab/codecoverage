using System;
using Xunit;
using Algorithms.Search.AStar;

namespace Algorithms.Tests.Search.AStar
{
    public class VecNTests
    {
        [Fact]
        public void Test_SqrLength()
        {
            // Arrange
            VecN vecA = new VecN(3, 4);
            VecN vecB = new VecN(-2, 5, 1);
            VecN vecC = new VecN(0, 0, 0, 0);

            // Act
            double sqrLenA = vecA.SqrLength();
            double sqrLenB = vecB.SqrLength();
            double sqrLenC = vecC.SqrLength();

            // Assert
            Assert.Equal(25, sqrLenA);
            Assert.Equal(30, sqrLenB);
            Assert.Equal(0, sqrLenC);
        }

        [Fact]
        public void Test_Length()
        {
            // Arrange
            VecN vecA = new VecN(3, 4);
            VecN vecB = new VecN(-2, 5, 1);
            VecN vecC = new VecN(0, 0, 0, 0);

            // Act
            double lenA = vecA.Length();
            double lenB = vecB.Length();
            double lenC = vecC.Length();

            // Assert
            Assert.Equal(5, lenA);
            Assert.Equal(Math.Sqrt(30), lenB);
            Assert.Equal(0, lenC);
        }

        [Fact]
        public void Test_Distance()
        {
            // Arrange
            VecN vecA = new VecN(3, 4);
            VecN vecB = new VecN(6, 8);
            VecN vecC = new VecN(0, 0, 0, 0);

            // Act
            double distAB = vecA.Distance(vecB);
            double distAC = vecA.Distance(vecC);
            double distBC = vecB.Distance(vecC);

            // Assert
            Assert.Equal(5, distAB);
            Assert.Equal(vecA.Length(), distAC);
            Assert.Equal(vecB.Length(), distBC);
        }

        [Fact]
        public void Test_SqrDistance()
        {
            // Arrange
            VecN vecA = new VecN(1, 2, 3);
            VecN vecB = new VecN(4, 6);
            VecN vecC = new VecN(0, 0, 0, 0);

            // Act
            double sqrDistAB = vecA.SqrDistance(vecB);
            double sqrDistAC = vecA.SqrDistance(vecC);
            double sqrDistBC = vecB.SqrDistance(vecC);

            // Assert
            Assert.Equal(14, sqrDistAB);
            Assert.Equal(vecA.SqrLength(), sqrDistAC);
            Assert.Equal(vecB.SqrLength(), sqrDistBC);
        }

        [Fact]
        public void Test_Subtract()
        {
            // Arrange
            VecN vecA = new VecN(1, 2, 3);
            VecN vecB = new VecN(4, 6);
            VecN vecC = new VecN(0, 5);
            VecN expectedAB = new VecN(-3, -4, 3);
            VecN expectedAC = new VecN(1, -3, 3);
            VecN expectedBC = new VecN(4, 1, 0);

            // Act
            VecN resultAB = vecA.Subtract(vecB);
            VecN resultAC = vecA.Subtract(vecC);
            VecN resultBC = vecB.Subtract(vecC);

            // Assert
            Assert.Equal(expectedAB, resultAB);
            Assert.Equal(expectedAC, resultAC);
            Assert.Equal(expectedBC, resultBC);
        }

        [Fact]
        public void Test_Equals()
        {
            // Arrange
            VecN vecA = new VecN(1.0, 2.0);
            VecN vecB = new VecN(1.0, 2.0, 3.0);
            VecN vecC = new VecN(1.0, 2.0000001);
            VecN vecD = new VecN(1.0, 2.000001);

            // Act
            bool equalsAB = vecA.Equals(vecB);
            bool equalsAC = vecA.Equals(vecC);
            bool equalsAD = vecA.Equals(vecD);

            // Assert
            Assert.False(equalsAB);
            Assert.True(equalsAC);
            Assert.False(equalsAD);
        }
    }
}