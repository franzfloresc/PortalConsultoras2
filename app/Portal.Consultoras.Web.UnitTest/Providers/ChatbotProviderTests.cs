using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;

namespace Portal.Consultoras.Web.UnitTest.Providers
{
    [TestClass]
    public class ChatbotProviderTests
    {
        private readonly ChatbotProvider _provider = new ChatbotProvider();

        [TestMethod]
        public void GetTokenTest()
        {
            var token = _provider.GetToken(new UsuarioModel
            {
                CodigoISO = "PE",
                DocumentoIdentidad = "000001765201"
            }, "ItK8MY4BgI9G3ifzRgKb0ERbVEk+L2qYkpfOIVHwHrE=", "kjsfg!)=)4diof25sfdg302dfg57438)!#$#70dfgf234asdnan");

            Assert.IsNotNull(token);
        }
    }
}
