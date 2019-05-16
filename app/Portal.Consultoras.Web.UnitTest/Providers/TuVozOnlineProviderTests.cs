using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.UnitTest.Providers
{
    [TestClass]
    public class TuVozOnlineProviderTests
    {
        private readonly TuVozOnlineProvider _provider = new TuVozOnlineProvider
        {
            BasePath = "https://www.questionpro.com/a/panelsso"
        };

        [TestMethod]
        public void GetUrlTest()
        {
            var user = new UsuarioModel
            {
                PrimerNombre = "Ivan",
                PrimerApellido = "Ake",
                EMail = "ivan.ake@questionpro.com",
                CodigoISO = "PE"
            };

            var url = _provider.GetUrl(user, "36882", "A12bZ091");

            var uri = new Uri(url);

            Assert.AreEqual(uri.Host, "www.questionpro.com");
            StringAssert.Contains(uri.Query, "ID_STRING");
            StringAssert.Contains(uri.Query, "SIGNATURE");
            StringAssert.Contains(uri.Query, "id");
        }
    }
}
