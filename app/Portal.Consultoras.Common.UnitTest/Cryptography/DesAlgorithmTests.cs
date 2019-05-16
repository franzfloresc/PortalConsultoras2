using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Common.Cryptography;

namespace Portal.Consultoras.Common.UnitTest.Cryptography
{
    [TestClass]
    public class DesAlgorithmTests
    {
        [TestMethod]
        [DataRow("36882|Mark|Rank|admin@domain.com|20-05-1992", "A12bZ198", DisplayName = "Esika")]
        [DataRow("36947|Mark|Rank|admin@domain.com|20-05-1993", "A12bZ198", DisplayName = "Lbel")]
        public void EncryptAndDecryptTest(string raw, string key)
        {
            var encrypt = DesAlgorithm.Encrypt(raw, key);
            var text = DesAlgorithm.Decrypt(encrypt, key);

            Assert.AreEqual(text, raw);
        }
    }
}
