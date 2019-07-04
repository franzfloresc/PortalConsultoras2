using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Common.Cryptography;

namespace Portal.Consultoras.Common.UnitTest.Cryptography
{
    [TestClass]
    public class HmacShaAlgorithmTests
    {
        [TestMethod]
        [DataTestMethod]
        [DataRow("36882|name|last|email", "6334234", DisplayName = "Esika Hash")]
        [DataRow("36947|name|last|email", "7223423", DisplayName = "Lbel Hash")]
        public void GetHashTest(string textTohash, string key)
        {
            var hash = HmacShaAlgorithm.GetHash(textTohash, key);

            Assert.IsNotNull(hash);
            Assert.AreEqual(40, hash.Length);
        }
    }
}
