using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.UnitTest.Extensions;

namespace Portal.Consultoras.Web.UnitTest.Controllers
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

            protected override BaseViewController GetController()
            {
                return new DetalleEstrategiaController();
            }

            [TestMethod]
            public override void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas()
            {
                base.Ficha_parameterPalancaIsNotValid_RedirectsToOfertas();
            }
        }
    }
}
