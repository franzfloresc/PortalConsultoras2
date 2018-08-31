using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MvcContrib.TestHelper;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
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
            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
            }

            private class DetalleEstrategiaMobileController : DetalleEstrategiaController
            {
                public DetalleEstrategiaMobileController() : base()
                {

                }

                public DetalleEstrategiaMobileController(ISessionManager sesionManager) : base(sesionManager)
                {

                }

                public DetalleEstrategiaMobileController(ISessionManager sesionManager, ILogManager logManager) : base(sesionManager, logManager)
                {

                }

                public DetalleEstrategiaMobileController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider)
                    : base(sesionManager, logManager, ofertaPersonalizadaProvider)
                {
                }

                public override bool IsMobile()
                {
                    return true;
                }
            }

            protected override BaseViewController CreateController()
            {
                return new DetalleEstrategiaMobileController(SessionManager.Object, LogManager.Object, OfertaPersonalizadaProvider.Object);
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
            }

            [TestMethod]
            public override void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas()
            {
                base.Ficha_parameterPalancaIsNotValid_RedirectsToOfertas();
            }

            protected override string AreaNameExpected()
            {
                return "Mobile";
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
