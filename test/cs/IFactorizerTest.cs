using Xunit;
using Algorithms.Numeric.Factorization;

public class IFactorizerTests
{
    private class FactorizerTestClass : IFactorizer
    {
        public bool TryFactor(int n, out int factor)
        {
            if (n <= 1)
            {
                factor = 1;
                return false;
            }

            for (int i = 2; i * i <= n; i++)
            {
                if (n % i == 0)
                {
                    factor = i;
                    return true;
                }
            }

            factor = n;
            return false;
        }
    }

    [Fact]
    public void TestIfPrimeNumber_ReturnsFalse()
    {
        // Arrange
        var factorizer = new FactorizerTestClass();

        // Act
        bool result = factorizer.TryFactor(7, out int factor);

        // Assert
        Assert.False(result);
        Assert.Equal(7, factor);
    }

    [Fact]
    public void TestIfNonPrimeNumber_ReturnsTrue()
    {
        // Arrange
        var factorizer = new FactorizerTestClass();

        // Act
        bool result = factorizer.TryFactor(8, out int factor);

        // Assert
        Assert.True(result);
        Assert.Equal(2, factor);
    }

    [Fact]
    public void TestIfOne_ReturnsFalse()
    {
        // Arrange
        var factorizer = new FactorizerTestClass();

        // Act
        bool result = factorizer.TryFactor(1, out int factor);

        // Assert
        Assert.False(result);
        Assert.Equal(1, factor);
    }

    [Fact]
    public void TestIfNegNumber_ReturnsFalse()
    {
        // Arrange
        var factorizer = new FactorizerTestClass();

        // Act
        bool result = factorizer.TryFactor(-7, out int factor);

        // Assert
        Assert.False(result);
        Assert.Equal(1, factor);
    }

    [Fact]
    public void TestIfZero_ReturnsFalse()
    {
        // Arrange
        var factorizer = new FactorizerTestClass();

        // Act
        bool result = factorizer.TryFactor(0, out int factor);

        // Assert
        Assert.False(result);
        Assert.Equal(1, factor);
    }
}