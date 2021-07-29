using ClassLibrary1;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void ReverseString()
        {
            var inputString = "The quick brown fox jumps over the lazy dog";
            var expectedString = "Not the expected string.";
            var returnedString = StringUtils.ReverseString(inputString);
            Assert.IsTrue(expectedString == returnedString, "The input string was not reversed correctly.");
        }
    }
}