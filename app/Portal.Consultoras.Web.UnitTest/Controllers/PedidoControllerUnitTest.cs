using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class PedidoControllerUnitTest
    {
        [TestMethod]
        public void DeleteCuvNoExistente()
        {
            var mensaje = string.Empty;
            try
            {
                var controller = new PedidoController();
                var response = controller.Delete(201711, 5097367, 2, 0, "NoExiste", 1, null, "", false);
            }
            catch (Exception) { }
            Assert.AreEqual(Constantes.MensajesError.DeletePedido_CuvNoExiste, mensaje);
        }
    }
}
