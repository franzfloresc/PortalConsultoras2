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

        //[TestMethod]
        //public void DeleteCuvNoExistente()
        //{
        //    var mensaje = string.Empty;
        //    try
        //    {
        //        var controller = new PedidoController();
        //        TestControllerBuilder oTB = new TestControllerBuilder();
        //        oTB.InitializeController(controller);

        //        var response = controller.Delete(201711, 5097367, 2, 0, "NoExiste", 1, null, "", false);
        //        mensaje = GetJsonMessage(response);
        //    }
        //    catch (Exception ex) { mensaje = ex.Message; }
        //    Assert.AreEqual(Constantes.MensajesError.DeletePedido_CuvNoExiste, mensaje);
        //}

        //[TestMethod]
        //public void PedidoController_ValidarStockEstrategia()
        //{
        //    // Arrange
        //    String mensaje = "";
        //    PedidoController oB = new PedidoController();
        //    TestControllerBuilder oT = new TestControllerBuilder();
        //    oT.InitializeController(oB);
        //    String MarcaID = "1";
        //    String CUV = "96215";
        //    String PrecioUnidad = "16900";
        //    String Descripcion = "L'Bel Essential Desmaquillador Bifásico de rostro y ojos 125ml";
        //    String Cantidad = "1";
        //    String IndicadorMontoMinimo = "1";
        //    String TipoOferta = "1003";

        //    // Act
        //    var response = oB.ValidarStockEstrategia(MarcaID, CUV, PrecioUnidad, Descripcion, Cantidad, IndicadorMontoMinimo, TipoOferta);
        //    mensaje = GetJsonMessage(response);

        //    // Assert
        //    Assert.AreEqual("", mensaje);
        //}
    }
}
