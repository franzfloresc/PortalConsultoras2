//using System;
//using Microsoft.VisualStudio.TestTools.UnitTesting;
//using Portal.Consultoras.Web.Areas.Mobile.Controllers;
//using System.Web.Mvc;
//using Moq;
//using Portal.Consultoras.Web.SessionManager;
//using Portal.Consultoras.Web.LogManager;
//using Portal.Consultoras.Web.Controllers;
//using Portal.Consultoras.Common;
//using Portal.Consultoras.Web.Models;
//using Portal.Consultoras.Web.Providers;

//namespace Portal.Consultoras.Web.UnitTest.AreasMobile.Mobile
//{
//    [TestClass]
//    public class BaseGuiaNegocioControllerUnitTests
//    {
//        [TestClass]
//        public class ViewLanding : Base
//        {
//            public class BaseGuiaNegocioControllerStub01 : BaseGuiaNegocioController
//            {
//                public BaseGuiaNegocioControllerStub01()
//                {
//                    revistaDigital = new RevistaDigitalModel();
//                }
//                public override bool IsMobile()
//                {
//                    return true;
//                }
//            }

//            [TestMethod]
//            public void ViewLanding_WhenIsMobile_ReturnPartialNamedIndexAndNotNullModel()
//            {
//                var controller = new BaseGuiaNegocioControllerStub01();

//                var result = controller.ViewLanding() as PartialViewResult;

//                Assert.AreEqual("Index", result.ViewName);
//                Assert.IsNotNull(result.Model);
//            }
//        }

//        [TestClass]
//        public class GetFiltersBySorting : Base
//        {
//            public class BaseGuiaNegocioControllerStub01 : BaseGuiaNegocioController
//            {
//                public override bool IsMobile()
//                {
//                    return true;
//                }
//            }

//            [TestMethod]
//            public void GetFiltersBySorting_WhenIsMobile_ReturnsAlistWith03Elements()
//            {
//                var controller = new OfertaViewProvider();

//                var filters = controller.GetFiltersBySorting(false);

//                Assert.AreEqual(3, filters.Count);
//                //
//                Assert.AreEqual(Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.Predefinido, filters[0].Codigo);
//                Assert.AreEqual(Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MenorAMayor, filters[1].Codigo);
//                Assert.AreEqual(Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MayorAMenor, filters[2].Codigo);
//            }
//        }


//        [TestClass]
//        public class GetFiltersByBrand : Base
//        {
//            public class BaseGuiaNegocioControllerStub01 : BaseGuiaNegocioController
//            {
//                public override bool IsMobile()
//                {
//                    return true;
//                }
//            }

//            [TestMethod]
//            public void GetFiltersByBrand_WhenIsMobile_ReturnsAlistWith04Elements()
//            {
//                var controller = new OfertaViewProvider();

//                var filters = controller.GetFiltersByBrand();

//                Assert.AreEqual(4, filters.Count);
//                //
//                Assert.AreEqual(Constantes.GuiaNegocioMarca.ValorPrecio.Predefinido, filters[0].Codigo);
//                Assert.AreEqual(Constantes.GuiaNegocioMarca.ValorPrecio.Cyzone, filters[1].Codigo);
//                Assert.AreEqual(Constantes.GuiaNegocioMarca.ValorPrecio.Esika, filters[2].Codigo);
//                Assert.AreEqual(Constantes.GuiaNegocioMarca.ValorPrecio.LBel, filters[3].Codigo);
//            }
//        }
//    }
//}
