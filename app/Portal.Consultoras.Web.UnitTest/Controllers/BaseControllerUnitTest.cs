using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using System.Web;
using MvcContrib.TestHelper;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseControllerUnitTest
    {
        [TestMethod]
        public void BaseController_OnActionExecuting_UnitTest()
        {
            // Arrange
            BaseController oB = new BaseController();
            TestControllerBuilder oTB = new TestControllerBuilder();

            // Act
            oTB.InitializeController(oB);

            // Assert
            Assert.AreEqual(oB.OnActionExecutingTest(), 7);
            Assert.AreEqual(oB.OnActionExecutingTest(), 0);
        }
    }
}
