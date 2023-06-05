using System;
using Algorithms.Numeric;
using Xunit;

namespace Algorithms.Tests
{
    public class ModularExponentiationTests
    {
        private readonly ModularExponentiation _modularExponentiation;

        public ModularExponentiationTests()
        {
            _modularExponentiation = new ModularExponentiation();
        }

        [Fact]
        public void Test_ModularPow_ZeroModulus()
        {
            // Test if modular exponentiation returns 0 when m = 1
            int result = _modularExponentiation.ModularPow(5, 7, 1);
            Assert.Equal(0, result);
        }

        [Fact]
        public void Test_ModularPow_InvalidModulus()
        {
            // Test if modular exponentiation throws an ArgumentException when m <= 0
            Assert.Throws<ArgumentException>(() => _modularExponentiation.ModularPow(5, 7, 0));
        }

        [Fact]
        public void Test_ModularPow_BaseCase()
        {
            // Test if modular exponentiation returns the correct base case when e = 0
            int result = _modularExponentiation.ModularPow(5, 0, 11);
            Assert.Equal(1, result);
        }

        [Fact]
        public void Test_ModularPow_SimpleCase()
        {
            // Test if modular exponentiation returns the correct result for a simple case
            int result = _modularExponentiation.ModularPow(3, 3, 7);
            Assert.Equal(6, result);
        }

        [Fact]
        public void Test_ModularPow_LargeNumbers()
        {
            // Test if modular exponentiation returns the correct result for large numbers
            int result = _modularExponentiation.ModularPow(123456, 78901234, 987654321);
            Assert.Equal(752029608, result);
        }
    }
}