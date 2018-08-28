using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Areas.Mobile.Controllers;
using System.Web.Mvc;
using Moq;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.UnitTest.AreasMobile.Mobile
{
    [TestClass]
    public class GuiaNegocioControllerUnitTests
    {
        [TestClass]
        public class Index : Base
        {
            public class GuiaNegocioControllerStub01: GuiaNegocioController
            {
                //public override ActionResult ViewLanding()
                //{
                //    throw new Exception("Error Render Index");
                //}

                public GuiaNegocioControllerStub01(ILogManager logManager)  
                {
                    this.logManager = logManager;
                }

                //public override bool GNDValidarAcceso(bool esConsultoraLider, GuiaNegocioModel guiaNegocio, RevistaDigitalModel revistaDigital)
                //{
                //    return true;
                //}
            }

            [TestMethod]
            public void Index_WhenGNDValidarAccesoReturnTrueWhenRenderIndexThrowException_LogsErrorAndRedirectsToBienvenida()
            {
                //Arrange
                var controller = new GuiaNegocioControllerStub01(LogManager.Object);

                //Act
                var result = controller.Index() as RedirectToRouteResult;

                //Assert
                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message =="Error Render Index"),
                    It.IsAny<string>(), 
                    It.IsAny<string>(), 
                    It.IsAny<string>()),
                    Times.Once);
                //
                Assert.AreEqual("Mobile", result.RouteValues["area"]);
                Assert.AreEqual("Bienvenida", result.RouteValues["controller"]);
                Assert.AreEqual("Index", result.RouteValues["action"]);
            }
        }
    }
}
