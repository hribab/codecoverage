using Algorithms.Sorters.External.Storages;
using Xunit;

namespace Algorithms.Sorters.External.Storages.Tests
{
    public class IntInMemoryStorageTests
    {
        // Test case 1: Verify the Length of the passed array
        [Fact]
        public void LengthTest()
        {
            int[] testArray = new[] {1, 2, 3, 4, 5};
            var inMemoryStorage = new IntInMemoryStorage(testArray);
            Assert.Equal(5, inMemoryStorage.Length);
        }

        // Test case 2: Verify the Read operation
        [Fact]
        public void ReadTest()
        {
            int[] testArray = new[] {1, 2, 3, 4, 5};
            var inMemoryStorage = new IntInMemoryStorage(testArray);
            var reader = inMemoryStorage.GetReader();

            Assert.Equal(1, reader.Read());
            Assert.Equal(2, reader.Read());
            Assert.Equal(3, reader.Read());
            Assert.Equal(4, reader.Read());
            Assert.Equal(5, reader.Read());
        }

        // Test case 3: Verify the Write operation
        [Fact]
        public void WriteTest()
        {
            int[] testArray = new int[5];
            var inMemoryStorage = new IntInMemoryStorage(testArray);
            var writer = inMemoryStorage.GetWriter();

            writer.Write(1);
            writer.Write(2);
            writer.Write(3);
            writer.Write(4);
            writer.Write(5);

            Assert.Equal(new[] {1, 2, 3, 4, 5}, testArray);
        }

        // Test case 4: Verify the Read operation after writing
        [Fact]
        public void ReadAfterWriteTest()
        {
            int[] testArray = new int[5];
            var inMemoryStorage = new IntInMemoryStorage(testArray);
            var writer = inMemoryStorage.GetWriter();

            writer.Write(5);
            writer.Write(4);
            writer.Write(3);
            writer.Write(2);
            writer.Write(1);

            var reader = inMemoryStorage.GetReader();
            Assert.Equal(5, reader.Read());
            Assert.Equal(4, reader.Read());
            Assert.Equal(3, reader.Read());
            Assert.Equal(2, reader.Read());
            Assert.Equal(1, reader.Read());
        }

        // Test case 5: Verify the Read and Write operations with edge values
        [Fact]
        public void ReadWriteEdgeValuesTest()
        {
            int[] testArray = new int[3];
            var inMemoryStorage = new IntInMemoryStorage(testArray);
            var writer = inMemoryStorage.GetWriter();

            writer.Write(int.MaxValue);
            writer.Write(0);
            writer.Write(int.MinValue);

            var reader = inMemoryStorage.GetReader();
            Assert.Equal(int.MaxValue, reader.Read());
            Assert.Equal(0, reader.Read());
            Assert.Equal(int.MinValue, reader.Read());
        }
    }
}