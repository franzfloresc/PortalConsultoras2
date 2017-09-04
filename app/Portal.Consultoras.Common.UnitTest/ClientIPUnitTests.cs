using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Portal.Consultoras.Common.UnitTest
{
    [TestClass]
    public class ClientIPUnitTests
    {
        [TestClass]
        public class ValidIP
        {
            [TestMethod]
            public void ValidIP_WhenIpIsNull_ReturnFalse()
            {
                var ip = (string)null;

                var isValidIp = ClientIP.ValidIP(ip, true);

                Assert.AreEqual(false, isValidIp);
            }

            [TestMethod]
            public void ValidIP_WhenIpIsWhiteSpace_ReturnFalse()
            {
                var ip = string.Empty;

                var isValidIp = ClientIP.ValidIP(ip, true);

                Assert.AreEqual(false, isValidIp);
            }

            [TestMethod]
            public void ValidIP_WhenIpIsInvalid_ReturnFalse()
            {
                var ip = "200_200";

                var isValidIp = ClientIP.ValidIP(ip, true);

                Assert.AreEqual(false, isValidIp);
            }

            [TestMethod]
            public void ValidIP_WhenIpIsPublicAndSkipPrivates_ReturnTrue()
            {
                var ip = "200.48.225.130";

                var isValidIp = ClientIP.ValidIP(ip, true);

                Assert.AreEqual(true, isValidIp);
            }

            [TestMethod]
            public void ValidIP_WhenIpIsPrivatecAndSkipPrivates_ReturnFalse()
            {
                var ip = "192.168.1.1";

                var isValidIp = ClientIP.ValidIP(ip, true);

                Assert.AreEqual(false, isValidIp);
            }

            [TestMethod]
            public void ValidIP_WhenIpIsPrivatecAndDontSkipPrivate_ReturnTrue()
            {
                var ip = "192.168.1.1";

                var isValidIp = ClientIP.ValidIP(ip, false);

                Assert.AreEqual(true, isValidIp);
            }

            [TestMethod]
            public void ValidIP_WhenIpIsInvalidAndDontSkipPrivate_ReturnFalse()
            {
                var ip = "200_200";

                var isValidIp = ClientIP.ValidIP(ip, false);

                Assert.AreEqual(false, isValidIp);
            }
        }

        [TestClass]
        public class GetFirstValidIpFromString
        {
            [TestMethod]
            public void GetFirstValidIpFromString_IpsAreNull_ReturnEmpty()
            {
                var ips = (string)null;

                var ip = ClientIP.GetFirstValidIpFromString(ips, false);

                Assert.AreEqual(string.Empty, ip);
            }

            [TestMethod]
            public void GetFirstValidIpFromString_IpsAreEmpty_ReturnEmpty()
            {
                var ips = string.Empty;

                var ip = ClientIP.GetFirstValidIpFromString(ips, false);

                Assert.AreEqual(string.Empty, ip);
            }

            [TestMethod]
            public void GetFirstValidIpFromString_IpsAreInvalid_ReturnEmpty()
            {
                var ips = "200_200, 300_300";

                var ip = ClientIP.GetFirstValidIpFromString(ips, false);

                Assert.AreEqual(string.Empty, ip);
            }

            [TestMethod]
            public void GetFirstValidIpFromString_SecondIpIsValid_ReturnSecondIp()
            {
                var ips = "200_200, 192.168.1.1";

                var ip = ClientIP.GetFirstValidIpFromString(ips, false);

                Assert.AreEqual("192.168.1.1", ip);
            }

            [TestMethod]
            public void GetFirstValidIpFromString_SecondIpIsValidAndPrivateAndSkipsPrivatesIp_ReturnSecondIp()
            {
                var ips = "200_200, 192.168.1.1";

                var ip = ClientIP.GetFirstValidIpFromString(ips, true);

                Assert.AreEqual(string.Empty, ip);
            }


            [TestMethod]
            public void GetFirstValidIpFromString_SecondIpIsValidAndPublicAndSkipsPrivatesIp_ReturnSecondIp()
            {
                var ips = "200_200, 200.48.225.130";

                var ip = ClientIP.GetFirstValidIpFromString(ips, true);

                Assert.AreEqual("200.48.225.130", ip);
            }

            [TestMethod]
            public void GetFirstValidIpFromString_FirstIpIsPrivateSecondIpIsPublicAndSkipsPrivatesIp_ReturnSecondIp()
            {
                var ips = "192.168.1.1, 200.48.225.130";

                var ip = ClientIP.GetFirstValidIpFromString(ips, true);

                Assert.AreEqual("200.48.225.130", ip);
            }
        }
    }
}
