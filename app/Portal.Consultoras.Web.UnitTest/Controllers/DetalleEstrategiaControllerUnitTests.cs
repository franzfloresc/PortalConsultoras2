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
            [DataRow((string)null, DisplayName = "palanca es nula")]
            [DataRow("", DisplayName = "palanca es vacía")]
            public override void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas(string palanca)
            {
                base.Ficha_parameterPalancaIsNotValid_RedirectsToOfertas(palanca);
            }

            [TestMethod]
            [DataRow(201001, DisplayName = "no es campania actual,campania = 201001")]
            [DataRow(201101, DisplayName = "no es campania actual,campania = 201001")]
            public override void Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas(int campaniaId)
            {
                base.Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas(campaniaId);
            }

            [TestMethod]
            [DataRow((string)null, DisplayName = "cuv es nulo")]
            [DataRow("", DisplayName = "cuv es vacía")]
            public override void Ficha_parameterCuvIsNotValid_RedirectsToOfertas(string cuv)
            {
                base.Ficha_parameterCuvIsNotValid_RedirectsToOfertas(cuv);
            }
        }
    }
}
