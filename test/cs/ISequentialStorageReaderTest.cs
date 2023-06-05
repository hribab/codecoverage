using System;
using System.IO;
using NUnit.Framework;
using Algorithms.Sorters.External;

namespace Tests.Algorithms.Sorters.External
{
    // A class implementing the ISequentialStorageReader interface for testing purposes
    public class TestSequentialStorageReader : ISequentialStorageReader<int>
    {
        private readonly StreamReader _streamReader;
        public TestSequentialStorageReader(string filePath)
        {
            _streamReader = new StreamReader(filePath);
        }

        public int Read()
        {
            if (_streamReader.EndOfStream)
            {
                throw new InvalidOperationException("End of stream reached");
            }

            return int.Parse(_streamReader.ReadLine());
        }

        public void Dispose()
        {
            _streamReader.Dispose();
        }
    }

    [TestFixture]
    public class ISequentialStorageReaderTests
    {
        private TestSequentialStorageReader _storageReader;

        [SetUp]
        public void SetUp()
        {
            string filePath = "path-to-test-file";
            _storageReader = new TestSequentialStorageReader(filePath);
        }

        [TearDown]
        public void TearDown()
        {
            _storageReader.Dispose();
        }

        [Test]
        public void Test_Read_Given_ValidDataStream_Returns_FirstValue()
        {
            // Read first value of the test data
            int actual = _storageReader.Read();

            int expected = 0; // Replace with the expected first value
            Assert.AreEqual(expected, actual);
        }

        [Test]
        public void Test_Read_Given_ValidDataStream_Returns_CorrectValuesInSequence()
        {
            int[] expected = {0, 1, 2, 3, 4}; // Replace with expected sequence

            for (int i = 0; i < expected.Length; i++)
            {
                Assert.AreEqual(expected[i], _storageReader.Read());
            }
        }

        [Test]
        public void Test_Read_Given_EndOfStreamReached_Throws_InvalidOperationException()
        {
            // Read all data from the test data
            while (true)
            {
                try
                {
                    _storageReader.Read();
                }
                catch (InvalidOperationException)
                {
                    break;
                }
            }

            // Try reading after reaching the end of the stream
            Assert.Throws<InvalidOperationException>(() => _storageReader.Read());
        }

        [Test]
        public void Test_Dispose_Given_ResourceInUse_ResourceIsReleased()
        {
            _storageReader.Dispose();
            Assert.Throws<ObjectDisposedException>(() => _storageReader.Read());
        }

        [Test]
        public void Test_Dispose_Given_ResourceNotInUse_NoExceptionThrown()
        {
            _storageReader.Dispose();
            Assert.DoesNotThrow(() => _storageReader.Dispose());
        }
    }
}