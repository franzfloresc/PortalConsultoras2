using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.UnitTest.Extensions;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    public class BaseViewControllerUnitTests
    {
        public class Ficha : Base
        {
            protected BaseViewController Controller;
            protected Mock<OfertaPersonalizadaProvider> OfertaPersonalizadaProvider;
            protected Mock<OfertaViewProvider> OfertaViewProvider;
            protected const int CampaniaIdActual = 201801;

            public override void Test_Initialize()
            {
                
                base.Test_Initialize();
                OfertaPersonalizadaProvider = GetOfertaPersonalizadaProvider();
                OfertaViewProvider = GetOfertaViewProvider();
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

            protected virtual Mock<OfertaViewProvider> GetOfertaViewProvider()
            {
                OfertaViewProvider = new Mock<OfertaViewProvider>
                {
                    CallBase = true
                };
                OfertaViewProvider.Setup(x => x.SessionManager).Returns(SessionManager.Object);
                return OfertaViewProvider;
            }

            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                Controller = null;
                OfertaPersonalizadaProvider = null;
            }

            public virtual void Ficha_parameterPalancaIsNotValid_RedirectsToOfertas(string palanca)
            {
                // Arrange

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
                return new BaseViewController(SessionManager.Object, LogManager.Object, OfertaPersonalizadaProvider.Object, OfertaViewProvider.Object);
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

            public virtual void Ficha_parameterCampaniaIdIsNotValid_RedirectsToOfertas(int campaniaId)
            {
                // Arrange
                var palanca = "PalancaNoNula";

                // Act
                var actualResult = Controller.Ficha(palanca, campaniaId, null, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
                VerifyDoNotCallLogManager();
            }

            public virtual void Ficha_parameterCuvIsNotValid_RedirectsToOfertas(string cuv)
            {
                // Arrange
                var palanca = "PalancaNoNula";

                // Act
                var actualResult = Controller.Ficha(palanca, CampaniaIdActual, cuv, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
                VerifyDoNotCallLogManager();
            }

            public virtual void Ficha_ConsultoraDoNotHavePalanca_RedirectsToOfertas(string nombrePalanca)
            {
                // Arrange
                var cuv = "33395";

                // Act
                var actualResult = Controller.Ficha(nombrePalanca, CampaniaIdActual, cuv, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
                VerifyDoNotCallLogManager();
            }

            public virtual void Ficha_ConsultoraNoTieneProductoEnSession_RedirectsToOfertas(string nombrePalanca, string configuracionPaisCodigo)
            {
                // Arrange
                var cuv = "33395";
                SetupPalancaInSession(configuracionPaisCodigo);
                SetupProviderToReturnNull();

                // Act
                var actualResult = Controller.Ficha(nombrePalanca, CampaniaIdActual, cuv, null) as RedirectToRouteResult;

                // Assert
                Assert.AreEqual(ControllerNaneExpected(), actualResult.GetControllerName());
                Assert.AreEqual(ActionNameExpected(), actualResult.GetActionName());
                Assert.AreEqual(AreaNameExpected(), actualResult.GetAreaName());
                VerifyDoNotCallLogManager();
            }

            private void SetupProviderToReturnNull()
            {
                OfertaPersonalizadaProvider.Setup(x => x.ObtenerEstrategiaPersonalizada(
                                    It.IsAny<UsuarioModel>(),
                                    It.IsAny<string>(),
                                    It.IsAny<string>(),
                                    It.IsAny<int>())).Returns((EstrategiaPersonalizadaProductoModel)null);
            }

            public virtual void Ficha_PalancaOptYConsultoraNoTieneRevistaDigital_BreadCrumOfertasReturnsOfertasDigitales()
            {
                // Arrange
                var cuv = "31456";
                SetupPalancaInSession(Constantes.ConfiguracionPais.OfertasParaTi);
                SetupRevistaDigitalInSession(false, false);

                // Act
                var result = (ViewResult)Controller.Ficha(Constantes.NombrePalanca.OfertaParaTi, CampaniaIdActual, cuv, "");

                // Assert
                var breadCrumbOfertas = ((DetalleEstrategiaFichaModel)result.Model).BreadCrumbs.Ofertas.Texto;
                Assert.AreEqual("Ofertas Digitales", breadCrumbOfertas);
            }

            public virtual void Ficha_PalancaOpmYConsultoraNoTieneRevistaDigital_BreadCrumOfertasReturnsOfertasDigitales()
            {
                // Arrange
                var cuv = "31456";
                SetupPalancaInSession(Constantes.ConfiguracionPais.RevistaDigital);
                SetupRevistaDigitalInSession(false, false);

                // Act
                var result = (ViewResult)Controller.Ficha(Constantes.NombrePalanca.OfertasParaMi, CampaniaIdActual, cuv, "");

                // Assert
                var breadCrumbOfertas = ((DetalleEstrategiaFichaModel)result.Model).BreadCrumbs.Ofertas.Texto;
                Assert.AreEqual("Ofertas Digitales", breadCrumbOfertas);
            }

            public virtual void Ficha_PalancaOptYConsultoraTieneRevistaDigital_BreadCrumOfertasReturnsGanaMas()
            {
                // Arrange
                var cuv = "31456";
                SetupPalancaInSession(Constantes.ConfiguracionPais.RevistaDigital);
                SetupRevistaDigitalInSession(true, true);

                // Act
                var result = (ViewResult)Controller.Ficha(Constantes.NombrePalanca.OfertaParaTi, CampaniaIdActual, cuv, "");

                // Assert
                var breadCrumbOfertas = ((DetalleEstrategiaFichaModel)result.Model).BreadCrumbs.Ofertas.Texto;
                Assert.AreEqual("Gana +", breadCrumbOfertas);
            }

            public virtual void Ficha_PalancaOpmYConsultoraTieneRevistaDigital_BreadCrumOfertasReturnsGanaMas()
            {
                // Arrange
                var cuv = "31456";
                SetupPalancaInSession(Constantes.ConfiguracionPais.RevistaDigital);
                SetupRevistaDigitalInSession(true, true);

                // Act
                var result = (ViewResult)Controller.Ficha(Constantes.NombrePalanca.OfertasParaMi, CampaniaIdActual, cuv, "");

                // Assert
                var breadCrumbOfertas = ((DetalleEstrategiaFichaModel)result.Model).BreadCrumbs.Ofertas.Texto;
                Assert.AreEqual("Gana +", breadCrumbOfertas);
            }
        }
    }
}
