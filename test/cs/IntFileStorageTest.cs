using System.IO;
using Xunit;
using Algorithms.Sorters.External.Storages;

namespace Algorithms.Tests.Sorters.External.Storages
{
    public class IntFileStorageTests
    {
        private const string TestFile = "testfile.bin";

        [Fact]
        public void Storage_GetReader_ReadsCorrectValue()
        {
            // Prepare test file
            File.WriteAllBytes(TestFile, new byte[] { 1, 0, 0, 0 });

            // Test case
            var storage = new IntFileStorage(TestFile, 1);
            using (var reader = storage.GetReader())
            {
                Assert.Equal(1, reader.Read());
            }

            // Clean up
            File.Delete(TestFile);
        }

        [Fact]
        public void Storage_GetWriter_WritesCorrectValue()
        {
            // Test case
            var storage = new IntFileStorage(TestFile, 1);
            using (var writer = storage.GetWriter())
            {
                writer.Write(1);
            }

            // Validation
            var result = File.ReadAllBytes(TestFile);
            Assert.Equal(new byte[] { 1, 0, 0, 0 }, result);

            // Clean up
            File.Delete(TestFile);
        }

        [Fact]
        public void Storage_ReaderReadSequence_CorrectSequence()
        {
            // Prepare test file
            File.WriteAllBytes(TestFile, new byte[] { 1, 0, 0, 0, 2, 0, 0, 0 });

            // Test case
            var storage = new IntFileStorage(TestFile, 2);
            using (var reader = storage.GetReader())
            {
                Assert.Equal(1, reader.Read());
                Assert.Equal(2, reader.Read());
            }

            // Clean up
            File.Delete(TestFile);
        }

        [Fact]
        public void Storage_WriterWriteSequence_CorrectSequence()
        {
            // Test case
            var storage = new IntFileStorage(TestFile, 2);
            using (var writer = storage.GetWriter())
            {
                writer.Write(1);
                writer.Write(2);
            }

            // Validation
            var result = File.ReadAllBytes(TestFile);
            Assert.Equal(new byte[] { 1, 0, 0, 0, 2, 0, 0, 0 }, result);

            // Clean up
            File.Delete(TestFile);
        }

        [Fact]
        public void Storage_ReadWriteTest_CorrectValues()
        {
            // Prepare test file
            var storage = new IntFileStorage(TestFile, 2);
            using (var writer = storage.GetWriter())
            {
                writer.Write(3);
                writer.Write(4);
            }

            // Test case
            using (var reader = storage.GetReader())
            {
                Assert.Equal(3, reader.Read());
                Assert.Equal(4, reader.Read());
            }

            // Clean up
            File.Delete(TestFile);
        }
    }
}