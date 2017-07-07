using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using System.Web;
using MvcContrib.TestHelper;
using System.Threading.Tasks;
using System.Threading;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseControllerUnitTest
    {
        [TestMethod]
        public void BaseController_OnActionExecuting_UnitTest()
        {
            // Arrange
            int Iteration = 10;
            // BaseController[] oBB = new BaseController[Iteration];
            // TestControllerBuilder[] oTT = new TestControllerBuilder[Iteration];

            // Single
            /*
            BaseController oB = new BaseController();
            TestControllerBuilder oT = new TestControllerBuilder();
            oT.InitializeController(oB);
            Assert.AreEqual(oB.OnActionExecutingTest(), 7);
            Assert.AreEqual(oB.OnActionExecutingTest(), 0);
            */
            int totalSize = 0;

            Parallel.For(0, Iteration - 1,
                   index => {
                       // Arrange
                       try
                       {
                           BaseController oBB;
                           TestControllerBuilder oTT;
                           oBB = new BaseController();
                           oTT = new TestControllerBuilder();
                           oTT.InitializeController(oBB);

                           // Act // Assert
                           Interlocked.Add(ref totalSize, oBB.OnActionExecutingTest());
                           Interlocked.Add(ref totalSize, oBB.OnActionExecutingTest());
                       }
                       catch(Exception)
                       {
                       }
                       // Interlocked.Add(ref totalSize, size);
                   });

            Assert.AreEqual(7 * Iteration, totalSize);
            // Assert.AreEqual(oBB.OnActionExecutingTest(), 0);
        }
    }
}
