using System;
using System.Globalization;
using Xunit;
using Algorithms.Other;

namespace Algorithms.Tests.Other
{
    public class JulianEasterTests
    {
        /// <summary>
        /// Test cases for JulianEaster.Calculate function.
        /// </summary>
        /// <param name="year">The year to calculate the date of Easter.</param>
        /// <param name="expectedDate">The expected date of Easter.</param>
        [Theory]
        [InlineData(2000, "04/30/2000")]
        [InlineData(1900, "04/15/1900")]
        [InlineData(1800, "04/07/1800")]
        [InlineData(1700, "04/20/1700")]
        [InlineData(1600, "04/20/1600")]
        public void Calculate_EasterDates(int year, string expectedDate)
        {
            // Arrange
            DateTime expected = DateTime.ParseExact(expectedDate, "MM/dd/yyyy", null, DateTimeStyles.AssumeUniversal);

            // Act
            DateTime actual = JulianEaster.Calculate(year);

            // Assert
            Assert.Equal(expected, actual);
        }

        /// <summary>
        /// Test cases with leap years.
        /// </summary>
        /// <param name="year">The leap year to calculate the date of Easter.</param>
        /// <param name="expectedDate">The expected date of Easter.</param>
        [Theory]
        [InlineData(2004, "04/18/2004")]
        [InlineData(1904, "05/01/1904")]
        [InlineData(1804, "04/30/1804")]
        [InlineData(1704, "04/20/1704")]
        [InlineData(1604, "04/31/1604")]
        public void Calculate_EasterDates_LeapYears(int year, string expectedDate)
        {
            // Arrange
            DateTime expected = DateTime.ParseExact(expectedDate, "MM/dd/yyyy", null, DateTimeStyles.AssumeUniversal);

            // Act
            DateTime actual = JulianEaster.Calculate(year);

            // Assert
            Assert.Equal(expected, actual);
        }

        /// <summary>
        /// Test cases with minimum and maximum years.
        /// </summary>
        /// <param name="year">The year to calculate the date of Easter.</param>
        /// <param name="expectedDate">The expected date of Easter.</param>
        [Theory]
        [InlineData(1, "03/31/0001")]
        [InlineData(9999, "04/17/9999")]
        public void Calculate_EasterDates_MinMaxYears(int year, string expectedDate)
        {
            // Arrange
            DateTime expected = DateTime.ParseExact(expectedDate, "MM/dd/yyyy", null, DateTimeStyles.AssumeUniversal);

            // Act
            DateTime actual = JulianEaster.Calculate(year);

            // Assert
            Assert.Equal(expected, actual);
        }
    }
}