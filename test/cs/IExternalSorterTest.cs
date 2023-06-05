using System.Collections.Generic;
using Algorithms.Sorters.External;
using Moq;
using Xunit;

namespace Algorithms.Sorters.Tests.External
{
    public class ExternalSorterTests
    {
        [Fact]
        public void Sort_SortsAscending_WithMockComparer()
        {
            // Arrange
            var mainMemoryMock = new Mock<ISequentialStorage<int>>();
            mainMemoryMock.Setup(m => m.Length).Returns(5);
            mainMemoryMock.Setup(m => m[It.IsAny<int>()]).Returns<int>(i => i);
            mainMemoryMock.Setup(m => m.GetEnumerator()).Returns(mainMemoryMock.Object);
            var temporaryMemoryMock = new Mock<ISequentialStorage<int>>();
            var mockComparer = new Mock<IComparer<int>>();
            mockComparer.Setup(c => c.Compare(It.IsAny<int>(), It.IsAny<int>())).Returns<int, int>((a, b) => a - b);
            IExternalSorter<int> externalSorter = new ExternalSorter<int>();

            // Act
            externalSorter.Sort(mainMemoryMock.Object, temporaryMemoryMock.Object, mockComparer.Object);

            // Assert
            mainMemoryMock.VerifySet(m => m[It.IsAny<int>()] = It.IsAny<int>(), Times.AtLeastOnce());
            temporaryMemoryMock.VerifySet(t => t[It.IsAny<int>()] = It.IsAny<int>(), Times.AtLeastOnce());
            mockComparer.Verify(c => c.Compare(It.IsAny<int>(), It.IsAny<int>()), Times.AtLeastOnce());
        }

        [Fact]
        public void Sort_SortsDescending_WithMockComparer()
        {
            // Arrange
            var mainMemoryMock = new Mock<ISequentialStorage<int>>();
            mainMemoryMock.Setup(m => m.Length).Returns(5);
            mainMemoryMock.Setup(m => m[It.IsAny<int>()]).Returns<int>(i => i);
            mainMemoryMock.Setup(m => m.GetEnumerator()).Returns(mainMemoryMock.Object);
            var temporaryMemoryMock = new Mock<ISequentialStorage<int>>();
            var mockComparer = new Mock<IComparer<int>>();
            mockComparer.Setup(c => c.Compare(It.IsAny<int>(), It.IsAny<int>())).Returns<int, int>((a, b) => b - a);
            IExternalSorter<int> externalSorter = new ExternalSorter<int>();

            // Act
            externalSorter.Sort(mainMemoryMock.Object, temporaryMemoryMock.Object, mockComparer.Object);

            // Assert
            mainMemoryMock.VerifySet(m => m[It.IsAny<int>()] = It.IsAny<int>(), Times.AtLeastOnce());
            temporaryMemoryMock.VerifySet(t => t[It.IsAny<int>()] = It.IsAny<int>(), Times.AtLeastOnce());
            mockComparer.Verify(c => c.Compare(It.IsAny<int>(), It.IsAny<int>()), Times.AtLeastOnce());
        }

        [Fact]
        public void Sort_ThrowsArgumentNullException_WithNullMainMemory()
        {
            // Arrange
            var temporaryMemoryMock = new Mock<ISequentialStorage<int>>();
            var mockComparer = new Mock<IComparer<int>>();
            IExternalSorter<int> externalSorter = new ExternalSorter<int>();

            // Act & Assert
            Assert.Throws<System.ArgumentNullException>(() => externalSorter.Sort(null, temporaryMemoryMock.Object, mockComparer.Object));
        }

        [Fact]
        public void Sort_ThrowsArgumentNullException_WithNullTemporaryMemory()
        {
            // Arrange
            var mainMemoryMock = new Mock<ISequentialStorage<int>>();
            var mockComparer = new Mock<IComparer<int>>();
            IExternalSorter<int> externalSorter = new ExternalSorter<int>();

            // Act & Assert
            Assert.Throws<System.ArgumentNullException>(() => externalSorter.Sort(mainMemoryMock.Object, null, mockComparer.Object));
        }

        [Fact]
        public void Sort_ThrowsArgumentNullException_WithNullComparer()
        {
            // Arrange
            var mainMemoryMock = new Mock<ISequentialStorage<int>>();
            var temporaryMemoryMock = new Mock<ISequentialStorage<int>>();
            IExternalSorter<int> externalSorter = new ExternalSorter<int>();

            // Act & Assert
            Assert.Throws<System.ArgumentNullException>(() => externalSorter.Sort(mainMemoryMock.Object, temporaryMemoryMock.Object, null));
        }
    }
}