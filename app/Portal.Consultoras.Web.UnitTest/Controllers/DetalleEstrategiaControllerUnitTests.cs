using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.UnitTest.Extensions;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class DetalleEstrategiaControllerUnitTests 
    {
        [TestClass]
        public class Ficha : BaseViewControllerUnitTests.Ficha
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

            protected override BaseViewController CreateController()
            {
                return new DetalleEstrategiaController(SessionManager.Object, LogManager.Object, OfertaPersonalizadaProvider.Object);
            }

            [TestMethod]
            public override void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas()
            {
                base.Ficha_parameterPalancaIsNotValid_RedirectsToOfertas();
            }

            [TestMethod]
            public override void Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas()
            {
                base.Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas();
            }

            [TestMethod]
            public override void Ficha_parameterCuvIsNotValid_RedirectsToOfertas()
            {
                base.Ficha_parameterCuvIsNotValid_RedirectsToOfertas();
            }
        }
    }
}
