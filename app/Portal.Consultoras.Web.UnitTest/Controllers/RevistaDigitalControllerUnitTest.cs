using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using System;
using System.Reflection;
using System.Web.Mvc;


namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class RevistaDigitalControllerUnitTest
    {
        RevistaDigitalController controller;

        [TestClass]
        public class RDObtenerProductos : Base
        {
            RevistaDigitalController controller;

            private RevistaDigitalController GetRevistaController()
            {
                return new RevistaDigitalController(sessionManager.Object, logManager.Object);
            }

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
            }

            [TestMethod]
            public void RDObtenerProductos_BusquedaProductoModelEsNulo_EscribeEnLog()
            {
                //Act
                controller = GetRevistaController();

                //Arrange
                controller.RDObtenerProductos(null);

                //Assert
                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("model no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(str => str.Contains("RevistaDigitalController.RDObtenerProductos"))
                    ));
            }

            [TestMethod]
            public void RDObtenerProductos_NoTieneRevistaDigital_DevuelveListaEnBlanco()
            {
                //Act
                controller = GetRevistaController();
                controller.RevistaDigital = new RevistaDigitalModel { TieneRDC = false };

                //Arrange
                dynamic result = controller.RDObtenerProductos(new BusquedaProductoModel { }).Data;

                //Assert
                Assert.AreEqual(false, result.success, "success");
                Assert.AreEqual(string.Empty, result.message, "message");
                Assert.AreEqual(0, result.lista.Count, "lista");
                Assert.AreEqual(0, result.cantidadTotal, "cantidadTotal");
                Assert.AreEqual(0, result.cantidad, "cantidad");
            }
        }
    }
}
