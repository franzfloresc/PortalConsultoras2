using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using System;
using System.Reflection;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class PedidoControllerUnitTest
    {
        private string GetJsonMessage(JsonResult response)
        {
            var data = response.Data;
            Type type = data.GetType();
            PropertyInfo property = type.GetProperty("message");
            return (string)property.GetValue(data, null);
        }

        [TestMethod]
        public void DeleteCuvNoExistente()
        {
            var mensaje = string.Empty;
            try
            {
                var controller = new PedidoController();
                TestControllerBuilder oTB = new TestControllerBuilder();
                oTB.InitializeController(controller);

                var response = controller.Delete(201711, 5097367, 2, 0, "NoExiste", 1, null, "", false);
                mensaje = GetJsonMessage(response);
            }
            catch (Exception ex) { mensaje = ex.Message; }
            Assert.AreEqual(Constantes.MensajesError.DeletePedido_CuvNoExiste, mensaje);
        }
    }
}
