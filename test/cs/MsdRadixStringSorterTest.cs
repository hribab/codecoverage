using System;
using Xunit;
using Algorithms.Sorters.String;

namespace Algorithms.Tests
{
    public class MsdRadixStringSorterTests
    {
        [Fact]
        public void Sort_AllEmptyStrings_Succeeds()
        {
            // Arrange
            var array = new string[] { "", "", "", "", "" };
            var sorter = new MsdRadixStringSorter();

            // Act
            sorter.Sort(array);

            // Assert
            Assert.Equal(new string[] { "", "", "", "", "" }, array);
        }

        [Fact]
        public void Sort_SortedStrings_Succeeds()
        {
            // Arrange
            var array = new string[] { "a", "abc", "b", "bd", "zzz" };
            var sorter = new MsdRadixStringSorter();

            // Act
            sorter.Sort(array);

            // Assert
            Assert.Equal(new string[] { "a", "abc", "b", "bd", "zzz" }, array);
        }

        [Fact]
        public void Sort_UnsortedStrings_Succeeds()
        {
            // Arrange
            var array = new string[] { "zzz", "bd", "b", "abc", "a" };
            var sorter = new MsdRadixStringSorter();

            // Act
            sorter.Sort(array);

            // Assert
            Assert.Equal(new string[] { "a", "abc", "b", "bd", "zzz" }, array);
        }

        [Fact]
        public void Sort_StringsOfSameLength_Succeeds()
        {
            // Arrange
            var array = new string[] { "bzc", "axa", "ayy", "zcc", "abb" };
            var sorter = new MsdRadixStringSorter();

            // Act
            sorter.Sort(array);

            // Assert
            Assert.Equal(new string[] { "abb", "axa", "ayy", "bzc", "zcc" }, array);
        }

        [Fact]
        public void Sort_StringsOfDifferentLengths_Succeeds()
        {
            // Arrange
            var array = new string[] { "zz", "aaa", "a", "z", "zzzz" };
            var sorter = new MsdRadixStringSorter();

            // Act
            sorter.Sort(array);

            // Assert
            Assert.Equal(new string[] { "a", "aaa", "z", "zz", "zzzz" }, array);
        }
    }
}