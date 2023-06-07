using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Algorithms.DataCompression;

namespace Algorithms.Tests
{
    [TestClass]
    public class TranslatorTests
    {
        [TestMethod]
        // Test case 1: Regular input, verify correct output.
        public void Translate_WithNormalInput_ReturnsCorrectOutput()
        {
            var translator = new Translator();
            var translationKeys = new Dictionary<string, string>
            {
                { "a", "1" },
                { "b", "2" },
                { "c", "3" }
            };
            var text = "abc";
            var expectedResult = "123";
            var result = translator.Translate(text, translationKeys);
            Assert.AreEqual(expectedResult, result);
        }

        [TestMethod]
        // Test case 2: Large input, verify output for correctness.
        public void Translate_LargeInput_ReturnsCorrectOutput()
        {
            var translator = new Translator();
            var translationKeys = new Dictionary<string, string>
            {
                { "a", "1" },
                { "b", "2" },
                { "c", "3" },
                { "d", "4" },
                { "e", "5" },
                { "f", "6" },
            };
            var text = "abcdef";
            var expectedResult = "123456";
            var result = translator.Translate(text, translationKeys);
            Assert.AreEqual(expectedResult, result);
        }

        [TestMethod]
        // Test case 3: Empty input, verify empty output.
        public void Translate_EmptyInput_ReturnsEmptyOutput()
        {
            var translator = new Translator();
            var translationKeys = new Dictionary<string, string>
            {
                { "a", "1" },
                { "b", "2" },
                { "c", "3" }
            };
            var text = "";
            var expectedResult = "";
            var result = translator.Translate(text, translationKeys);
            Assert.AreEqual(expectedResult, result);
        }

        [TestMethod]
        // Test case 4: Input with no translation key matches, verify unchanged output.
        public void Translate_NoMatchingKeys_ReturnsUnchangedOutput()
        {
            var translator = new Translator();
            var translationKeys = new Dictionary<string, string>
            {
                { "x", "1" },
                { "y", "2" },
                { "z", "3" }
            };
            var text = "abc";
            var expectedResult = "abc";
            var result = translator.Translate(text, translationKeys);
            Assert.AreEqual(expectedResult, result);
        }

        [TestMethod]
        // Test case 5: Input with special characters, verify correct output.
        public void Translate_SpecialCharacterInput_ReturnsCorrectOutput()
        {
            var translator = new Translator();
            var translationKeys = new Dictionary<string, string>
            {
                { "!", ")"},
                { "@", "#"},
                { "~", "%"}
            };
            var text = "!@~";
            var expectedResult = ")#%";
            var result = translator.Translate(text, translationKeys);
            Assert.AreEqual(expectedResult, result);
        }
    }
}