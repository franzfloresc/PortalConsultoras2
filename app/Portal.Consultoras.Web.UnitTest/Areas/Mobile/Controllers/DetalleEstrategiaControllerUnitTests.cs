using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.UnitTest.Controllers;
using Portal.Consultoras.Web.UnitTest.Extensions;
using DetalleEstrategiaController = Portal.Consultoras.Web.Areas.Mobile.Controllers.DetalleEstrategiaController;

namespace Portal.Consultoras.Web.UnitTest.Areas.Mobile.Controllers
{
    [TestClass]
    public class DetalleEstrategiaControllerUnitTests 
    {
        [TestClass]
        public class Ficha : BaseViewControllerUnitTests.Ficha
        {
            //[TestInitialize]
            //public override void Test_Initialize()
            //{
            //    base.Test_Initialize();
            //}

            //[TestCleanup]
            //public override void Test_Cleanup()
            //{
            //    base.Test_Cleanup();
            //}

            private class DetalleEstrategiaMobileController : DetalleEstrategiaController
            {
                public override bool IsMobile()
                {
                    return true;
                }
            }

            protected override BaseViewController GetController()
            {
                return new DetalleEstrategiaMobileController();
            }

            protected override string AreaNameExpected()
            {
                return "Mobile";
            }

            [TestMethod]
            public override void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas()
            {
                base.Ficha_parameterPalancaIsNotValid_RedirectsToOfertas();
            }
        }
    }
}
