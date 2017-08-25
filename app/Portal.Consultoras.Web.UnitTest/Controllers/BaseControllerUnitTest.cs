using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseControllerUnitTest
    {
        [TestClass]
        public class Base
        {
            public Mock<ISessionManager> sessionManager;

            [TestInitialize]
            public void Test_Initialize()
            {
                sessionManager = new Mock<ISessionManager>();

            }

            [TestCleanup]
            public void Test_Cleanup()
            {
                sessionManager = null;
            }
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

        //[TestClass]
        //public class ObtenerPedidoWeb : Base
        //{
        //    [TestMethod]
        //    public void ObtenerPedidoWeb_WhenIsInvoke_ReturnsANotNullEntity()
        //    {
        //        var controller = new BaseController(sessionManager.Object);

        //        var pedido = controller.ObtenerPedidoWeb();

        //        Assert.IsNotNull(pedido);
        //    }
        //}

        //[TestClass]
        //public class ObtenerPedidoWebDetalle : Base
        //{
        //    [TestMethod]
        //    public void ObtenerPedidoWebDetalle_WhenIsInvoke_AlwaysReturnANotNullList()
        //    {
        //        var controller = new BaseController(sessionManager.Object);

        //        var detallesPedidoWeb = controller.ObtenerPedidoWebDetalle();

        //        Assert.IsNotNull(detallesPedidoWeb);
        //    }
        //}

    }
}
