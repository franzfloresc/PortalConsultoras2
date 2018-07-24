//using System;
//using Microsoft.VisualStudio.TestTools.UnitTesting;
//using Portal.Consultoras.Web.Areas.Mobile.Controllers;
//using System.Web.Mvc;
//using Moq;
//using Portal.Consultoras.Web.SessionManager;
//using Portal.Consultoras.Web.LogManager;
//using Portal.Consultoras.Web.Models;
//using Portal.Consultoras.Common;

//namespace Portal.Consultoras.Web.UnitTest.AreasMobile.Mobile
//{
//    [TestClass]
//    public class OfertasParaTiUnitTests
//    {
//        [TestClass]
//        public class Detalle : Base
//        {
//            public class OfertasParaTiControllerStub01 : OfertasParaTiController
//            {
//                //public override ActionResult RenderDetalle(int id, int origen)
//                //{
//                //    throw new Exception("Error Render Detalle");
//                //}

//                public OfertasParaTiControllerStub01(ILogManager logManager)
//                {
//                    this.logManager = logManager;
//                }
//            }

//            [TestMethod]
//            public void Detalle_WhenRenderDetalleThrowException_LogsErrorAndRedirectsToBienvenida()
//            {
//                //Arrange
//                var controller = new OfertasParaTiControllerStub01(logManager.Object);

//                //Act
//                //var result = controller.Detalle(0,0) as RedirectToRouteResult;

//                //Assert
//                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
//                    It.Is<Exception>(e => e.Message == "Error Render Detalle"),
//                    It.IsAny<string>(),
//                    It.IsAny<string>(),
//                    It.IsAny<string>()),
//                    Times.Once);
//                //
//                //Assert.AreEqual("Mobile", result.RouteValues["area"]);
//                //Assert.AreEqual("Bienvenida", result.RouteValues["controller"]);
//                //Assert.AreEqual("Index", result.RouteValues["action"]);
//            }

//        }

//        [TestClass]
//        public class GetRedirectTo : Base
//        {
//            //[TestMethod]
//            //public void GetRedirectTo_WhenPantallaOrigenPedidoWebIsDefault_RedirectsToOfertas()
//            //{
//            //    //Arrange
//            //    var controller = new OfertasParaTiController();

//            //    //Act
//            //    var result = controller.GetRedirectTo(Common.Enumeradores.PantallaOrigenPedidoWeb.Default) as RedirectToRouteResult;

//            //    //Assert
//            //    Assert.AreEqual("Mobile", result.RouteValues["area"]);
//            //    Assert.AreEqual("Ofertas", result.RouteValues["controller"]);
//            //    Assert.AreEqual("Index", result.RouteValues["action"]);
//            //}

//            //[TestMethod]
//            //public void GetRedirectTo_WhenPantallaOrigenPedidoWebIsHome_RedirectsToBienvenida()
//            //{
//            //    //Arrange
//            //    var controller = new OfertasParaTiController();

//            //    //Act
//            //    var result = controller.GetRedirectTo(Common.Enumeradores.PantallaOrigenPedidoWeb.Home) as RedirectToRouteResult;

//            //    //Assert
//            //    Assert.AreEqual("Mobile", result.RouteValues["area"]);
//            //    Assert.AreEqual("Bienvenida", result.RouteValues["controller"]);
//            //    Assert.AreEqual("Index", result.RouteValues["action"]);
//            //}

//            //[TestMethod]
//            //public void GetRedirectTo_WhenPantallaOrigenPedidoWebIsPedido_RedirectsToPedido()
//            //{
//            //    //Arrange
//            //    var controller = new OfertasParaTiController();

//            //    //Act
//            //    var result = controller.GetRedirectTo(Common.Enumeradores.PantallaOrigenPedidoWeb.Pedido) as RedirectToRouteResult;

//            //    //Assert
//            //    Assert.AreEqual("Mobile", result.RouteValues["area"]);
//            //    Assert.AreEqual("Pedido", result.RouteValues["controller"]);
//            //    Assert.AreEqual("Index", result.RouteValues["action"]);
//            //}

//            //[TestMethod]
//            //public void GetRedirectTo_WhenPantallaOrigenPedidoWebIsRevistaDigital_RedirectsToRevistaDigitalComprar()
//            //{
//            //    //Arrange
//            //    var controller = new OfertasParaTiController();

//            //    //Act
//            //    var result = controller.GetRedirectTo(Common.Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital) as RedirectToRouteResult;

//            //    //Assert
//            //    Assert.AreEqual("Mobile", result.RouteValues["area"]);
//            //    Assert.AreEqual("RevistaDigital", result.RouteValues["controller"]);
//            //    Assert.AreEqual("Comprar", result.RouteValues["action"]);
//            //}

//            //[TestMethod]
//            //public void GetRedirectTo_WhenPantallaOrigenPedidoWebIsGuiaNegocio_RedirectsToGuiaNegocio()
//            //{
//            //    //Arrange
//            //    var controller = new OfertasParaTiController();

//            //    //Act
//            //    var result = controller.GetRedirectTo(Common.Enumeradores.PantallaOrigenPedidoWeb.GuiaNegocioDigital) as RedirectToRouteResult;

//            //    //Assert
//            //    Assert.AreEqual("Mobile", result.RouteValues["area"]);
//            //    Assert.AreEqual("GuiaNegocio", result.RouteValues["controller"]);
//            //    Assert.AreEqual("Index", result.RouteValues["action"]);
//            //}

//        }

//    }
//}
