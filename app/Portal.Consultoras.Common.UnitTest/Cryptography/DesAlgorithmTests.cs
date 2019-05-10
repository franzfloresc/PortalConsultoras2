using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Common.Cryptography;

namespace Portal.Consultoras.Common.UnitTest.Cryptography
{
    [TestClass]
    public class DesAlgorithmTests
    {
        [TestMethod]
        [DataRow("36882", "654321ba", DisplayName = "Esika")]
        [DataRow("36947", "765432dc", DisplayName = "Lbel")]
        public void EncryptAndDecryptTest(string raw, string key)
        {
            var encrypt = DesAlgorithm.Encrypt(raw, key);
            var text = DesAlgorithm.Decrypt(encrypt, key);

            Assert.AreEqual(text, raw);
        }
    }
}
