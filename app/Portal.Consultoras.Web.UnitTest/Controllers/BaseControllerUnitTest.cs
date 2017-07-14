using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Portal.Consultoras.Web.Controllers;
using System.Web;
using MvcContrib.TestHelper;
using System.Threading.Tasks;
using System.Threading;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Common;
using System.Web.Mvc;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseControllerUnitTest
    {
        [TestMethod]
        public void BaseController_OnActionExecuting()
        {
            // Arrange
            // int Iteration = 10;
            // BaseController[] oBB = new BaseController[Iteration];
            // TestControllerBuilder[] oTT = new TestControllerBuilder[Iteration];

            // Single
            //BaseController oB = new BaseController();
            //TestControllerBuilder oT = new TestControllerBuilder();
            //oT.InitializeController(oB);
            //Assert.AreEqual(oB.OnActionExecutingTest(), 7);
            /*
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
            */

        }

        [TestMethod]
        public void Base_BuildMenuMobile_ConsultoraOnline_ViewBagExists() {
            BaseController controller = new BaseController();
            var testController = new TestControllerBuilder();
            testController.InitializeController(controller);

            var userData = new UsuarioModel {
                RolID = Constantes.Rol.Consultora,
                MenuMobile = new List<MenuMobileModel>()
            };
            try { controller.BuildMenuMobile(userData); }
            catch { }

            bool existeTipoMenuConsultoraOnline = controller.ViewBag.TipoMenuConsultoraOnline != null;
            bool existeCantPedidosPendientes = controller.ViewBag.CantPedidosPendientes != null;
            bool existeTeQuedanConsultoraOnline = controller.ViewBag.TeQuedanConsultoraOnline != null;
            bool existeMenuHijoIDConsultoraOnline = controller.ViewBag.MenuHijoIDConsultoraOnline != null;
            bool existeMenuPadreIDConsultoraOnline = controller.ViewBag.MenuPadreIDConsultoraOnline != null;

            Assert.AreEqual(true, existeTipoMenuConsultoraOnline);
            Assert.AreEqual(true, existeCantPedidosPendientes);
            Assert.AreEqual(true, existeTeQuedanConsultoraOnline);
            Assert.AreEqual(true, existeMenuHijoIDConsultoraOnline);
            Assert.AreEqual(true, existeMenuPadreIDConsultoraOnline);
        }

        [TestClass]
        public class ObtenerPedidoWeb
        {
            [TestMethod]
            public void ObtenerPedidoWeb_WhenIsInvoke_ReturnsANotNullEntity()
            {
                var controller = new BaseController();

                var pedido = controller.ObtenerPedidoWeb();

                Assert.IsNotNull(pedido);
            }
        }

        [TestClass]
        public class ObtenerPedidoWebDetalle
        {
            [TestMethod]
            public void ObtenerPedidoWebDetalle_WhenIsInvoke_AlwaysReturnANotNullList()
            {
                var controller = new BaseController();

                var detallesPedidoWeb = controller.ObtenerPedidoWebDetalle();

                Assert.IsNotNull(detallesPedidoWeb);
            }
        }

    }
}
