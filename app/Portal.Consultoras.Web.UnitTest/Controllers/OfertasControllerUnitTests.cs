using System;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Extensions;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class OfertasControllerUnitTests
    {
        [TestClass]
        public class Index :  Base
        {
            private Mock<ConfiguracionOfertasHomeProvider> _configuracionOfertasHomeProvider;
            private Mock<OfertaViewProvider> _ofertaViewProvider;
            private OfertasController _ofertasController;
            private readonly int campaniaId = 201801;

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                base.ConfigureUserDataWithCampaniaActual(campaniaId);
                _configuracionOfertasHomeProvider = GetMockedOfertasProvider();
                _ofertaViewProvider = GetOfertaViewProvider();
                _ofertasController = GetController();
            }

            private Mock<ConfiguracionOfertasHomeProvider> GetMockedOfertasProvider()
            {
                var configuracionOfertasHomeProvider = new Mock<ConfiguracionOfertasHomeProvider>()
                {
                    CallBase = true
                };
                configuracionOfertasHomeProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);
                configuracionOfertasHomeProvider.Setup(x => x.LogManager).Returns(LogManager.Object);
                //
                return configuracionOfertasHomeProvider;
            }

            private Mock<OfertaViewProvider> GetOfertaViewProvider()
            {
                var ofertaViewProvider = new Mock<OfertaViewProvider>()
                {
                    CallBase = true
                };
                ofertaViewProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);
                //
                return ofertaViewProvider;
            }

            class OfertasControllerStub : OfertasController
            {
                public bool EsDispositivoMovil_ { get; set; } = false;
                public OfertasControllerStub(ISessionManager sessionManager,
                    ILogManager logManager,
                    ConfiguracionOfertasHomeProvider configuracionOfertasHomeProvider,
                    OfertaViewProvider ofertaViewProvider)
                    : base(sessionManager, logManager, configuracionOfertasHomeProvider, ofertaViewProvider)
                {
                }
                public override bool EsDispositivoMovil()
                {
                    return EsDispositivoMovil_;
                }
            }

            private OfertasControllerStub GetMobileController()
            {
                return new OfertasControllerStub(
                    SessionManager.Object,
                    LogManager.Object,
                    _configuracionOfertasHomeProvider.Object,
                    _ofertaViewProvider.Object);
            }

            private OfertasControllerStub GetController()
            {
                return new OfertasControllerStub(
                    SessionManager.Object,
                    LogManager.Object,
                    _configuracionOfertasHomeProvider.Object,
                    _ofertaViewProvider.Object);
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                _configuracionOfertasHomeProvider = null;
                _ofertasController = null;
            }

            [TestMethod]
            public void Index_EsDispositivoMovil_RedirectToMobile()
            {
                // Arrenge
                ((OfertasControllerStub)_ofertasController).EsDispositivoMovil_ = true;

                // Act
                var result = _ofertasController.Index() as RedirectToRouteResult;

                // Assert
                Assert.AreEqual("Ofertas", result.GetControllerName());
                Assert.AreEqual("Index", result.GetActionName());
                Assert.AreEqual("Mobile", result.GetAreaName());

            }

            [TestMethod]
            public void Index_OfertasProvidersThrowsException_WritesInLogAnrRedirecToBienvenida()
            {
                // Arrenge
                _configuracionOfertasHomeProvider
                    .Setup(x => x.ObtenerConfiguracionSeccion(It.IsAny<RevistaDigitalModel>(),It.IsAny<bool>()))
                    .Throws( new Exception("ObtenerConfiguracionSeccion"));

                // Act
                var result = _ofertasController.Index() as RedirectToRouteResult;

                // Assert
                Assert.AreEqual("Bienvenida", result.GetControllerName());
                Assert.AreEqual("Index", result.GetActionName());
                Assert.AreEqual("", result.GetAreaName());
                VerifyCallLogManager("ObtenerConfiguracionSeccion", "OfertasController.Index");
            }

            [TestMethod]
            public void Index_OfertasViewProviderThrowsException_WritesInLogAnrRedirecToBienvenida()
            {
                // Arrenge
                _ofertaViewProvider
                    .Setup(x => x.MensajeProductoBloqueado(It.IsAny<bool>()))
                    .Throws(new Exception("MensajeProductoBloqueado"));

                // Act
                var result = _ofertasController.Index() as RedirectToRouteResult;

                // Assert
                Assert.AreEqual("Bienvenida", result.GetControllerName());
                Assert.AreEqual("Index", result.GetActionName());
                Assert.AreEqual("", result.GetAreaName());
                VerifyCallLogManager("MensajeProductoBloqueado", "OfertasController.Index");
            }

            //public void Index_GetSeccionRevistaDigital_ReturnSameTitleFromDB()
            //{
            //    // Arrenge

            //    // Act
            //    var result = _ofertasController.Index() as RedirectToRouteResult;

            //    // Assert
            //    Assert.AreEqual("Ofertas", result.GetControllerName());
            //    Assert.AreEqual("Index", result.GetActionName());
            //    Assert.AreEqual("Mobile", result.GetAreaName());

            //}

            //public void Index_GetSeccionRevistaDigitalReducida_ReturnSameTitleFromDB()
            //{
            //    // Arrenge

            //    // Act
            //    var result = _ofertasController.Index() as RedirectToRouteResult;

            //    // Assert
            //    Assert.AreEqual("Ofertas", result.GetControllerName());
            //    Assert.AreEqual("Index", result.GetActionName());
            //    Assert.AreEqual("Mobile", result.GetAreaName());

            //}

            //public void Index_GetSeccionOfertasParaTi_ReturnSameTitleFromDB()
            //{
            //    // Arrenge

            //    // Act
            //    var result = _ofertasController.Index() as RedirectToRouteResult;

            //    // Assert
            //    Assert.AreEqual("Ofertas", result.GetControllerName());
            //    Assert.AreEqual("Index", result.GetActionName());
            //    Assert.AreEqual("Mobile", result.GetAreaName());

            //}
        }
    }
}
