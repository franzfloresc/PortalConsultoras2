using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Web.Areas.Mobile.Controllers;
using Portal.Consultoras.Web.UnitTest.Extensions;

namespace Portal.Consultoras.Web.UnitTest.Areas.Mobile.Controllers
{
    [TestClass]
    public class DetalleEstrategiaControllerUnitTests 
    {
        [TestClass]
        public class Ficha : Base
        {
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
            public void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas()
            {
                // Arrange
                var controller = new DetalleEstrategiaController();

                // Act
                var actualResult = controller.Ficha(null, 0, null, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual("Ofertas", actualResult.GetControllerName());
                Assert.AreEqual("Index", actualResult.GetActionName());
                //Assert.AreEqual("Mobile", actualResult.GetAreaName());
            }
        }
    }
}
