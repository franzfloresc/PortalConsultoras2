using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Moq.Protected;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Extensions;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseViewControllerUnitTests
    {
        [TestClass]
        public class Ficha : Base
        {
            protected BaseViewController Controller;
            protected Mock<OfertaPersonalizadaProvider> OfertaPersonalizadaProvider;
            protected const int CampaniaIdActual = 201801;

            [TestInitialize]
            public override void Test_Initialize()
            {
                
                base.Test_Initialize();
                OfertaPersonalizadaProvider = GetOfertaPersonalizadaProvider();
                Controller = CreateController();
                ConfigureUserDataWithCampaniaActual(CampaniaIdActual);
            }

            protected virtual Mock<OfertaPersonalizadaProvider> GetOfertaPersonalizadaProvider()
            {
                OfertaPersonalizadaProvider = new Mock<OfertaPersonalizadaProvider>
                {
                    CallBase = true
                };
                OfertaPersonalizadaProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);
                return OfertaPersonalizadaProvider;
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                Controller = null;
                OfertaPersonalizadaProvider = null;
            }

            [TestMethod]
            public virtual void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas()
            {
                // Arrange
                string palanca = null;

                // Act
                var actualResult = Controller.Ficha(palanca, 0, null, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
                VerifyDoNotCallLogManager();
            }

            protected virtual BaseViewController CreateController()
            {
                return new BaseViewController(SessionManager.Object, LogManager.Object, OfertaPersonalizadaProvider.Object);
            }

            protected virtual string ControllerNaneExpected()
            {
                return "Ofertas";
            }

            protected virtual string ActionNameExpected()
            {
                return "Index";
            }

            protected virtual string AreaNameExpected()
            {
                return "";
            }

            [TestMethod]
            public virtual void Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas()
            {
                // Arrange
                var palanca = "PalancaNoNula";
                var campania = 201001;

                // Act
                var actualResult = Controller.Ficha(palanca, campania, null, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
                VerifyDoNotCallLogManager();
            }

            [TestMethod]
            public virtual void Ficha_parameterCuvIsNotValid_RedirectsToOfertas()
            {
                // Arrange
                var palanca = "PalancaNoNula";
                string cuv = null;

                // Act
                var actualResult = Controller.Ficha(palanca, CampaniaIdActual, cuv, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
                VerifyDoNotCallLogManager();
            }
        }
    }
}
