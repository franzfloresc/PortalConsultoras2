using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Extensions;

namespace Portal.Consultoras.Web.UnitTest.Providers
{
    [TestClass]
    public class ConfiguracionOfertasHomeProviderUnitTests
    {
        [TestClass]
        public class ObtenerConfiguracionSeccion : Base
        {
            private readonly int _CampaniaIdActual = 201801;
            public ConfiguracionOfertasHomeProvider Provider { get; private set; }
            public Mock<ConfiguracionPaisProvider> ConfiguracionPaisProvider { get; private set; }
            public Mock<GuiaNegocioProvider> GuiaNegocioProvider { get; private set; }
            public Mock<ShowRoomProvider> ShowRoomProvider { get; private set; }

            class ConfiguracionOfertasHomeProviderStub : ConfiguracionOfertasHomeProvider
            {
                public string FileName { get; set; }

                protected override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                {
                    return DataHandler.GetDataTesting<List<BEConfiguracionOfertasHome>>(FileName);
                }

                public ConfiguracionOfertasHomeProviderStub(ISessionManager sessionManager,
                        ILogManager logManager,
                        ConfiguracionPaisProvider configuracionPaisProvider,
                        GuiaNegocioProvider guiaNegocio,
                        ShowRoomProvider showRoom) 
                    : base(sessionManager,
                        logManager,
                        configuracionPaisProvider,
                        guiaNegocio,
                        showRoom)
                {

                }
            }

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                //
                ConfiguracionPaisProvider = new Mock<ConfiguracionPaisProvider>();
                GuiaNegocioProvider = new Mock<GuiaNegocioProvider>();
                ShowRoomProvider = new Mock<ShowRoomProvider>();
                //
                Provider = CreateProvider();
                //
                ConfigureUserDataWithCampaniaActual(_CampaniaIdActual);
                SetupRevistaDigitalInSession(true, true);
            }

            private ConfiguracionOfertasHomeProvider CreateProvider()
            {
                return new ConfiguracionOfertasHomeProviderStub(
                       SessionManager.Object,
                       LogManager.Object,
                       ConfiguracionPaisProvider.Object,
                       GuiaNegocioProvider.Object,
                       ShowRoomProvider.Object
                       );
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                //
                ConfiguracionPaisProvider = null;
                GuiaNegocioProvider = null;
                ShowRoomProvider = null;
                //
                Provider = null;
            }

            [TestMethod]
            public void ObtenerConfiguracionSeccion_GetConfiguracionOfertasHomeOptDesktop_ReturnSameTitleFromDB()
            {
                // Arrange
                var jsonDataFileName = "ConfiguracionOfertasHome\\ObtenerConfiguracionSeccion\\ConfiguracionOfertasHomeOPT";
                ((ConfiguracionOfertasHomeProviderStub)Provider).FileName = jsonDataFileName;
                SetupRevistaDigitalInSession(false, false);
                SetupPalancaInSession(Constantes.ConfiguracionPais.OfertasParaTi);
                var rd = SessionManager.Object.GetRevistaDigital();


                // Act
                var result = Provider.ObtenerConfiguracionSeccion(rd, false)[0];

                // Assert
                Assert.AreEqual(Constantes.ConfiguracionPais.OfertasParaTi, result.Codigo);
                Assert.AreEqual("OFERTAS PARA TI", result.Titulo);

            }

            [TestMethod]
            public void ObtenerConfiguracionSeccion_GetConfiguracionOfertasHomeRdDesktop_ReturnSameTitleFromDB()
            {
                // Arrange
                var jsonDataFileName = "ConfiguracionOfertasHome\\ObtenerConfiguracionSeccion\\ConfiguracionOfertasHomeRD";
                ((ConfiguracionOfertasHomeProviderStub)Provider).FileName = jsonDataFileName;
                SetupRevistaDigitalInSession(true, true);
                SetupPalancaInSession(Constantes.ConfiguracionPais.RevistaDigital);
                var rd = SessionManager.Object.GetRevistaDigital();


                // Act
                var result = Provider.ObtenerConfiguracionSeccion(rd, false)[0];

                // Assert
                Assert.AreEqual(Constantes.ConfiguracionPais.RevistaDigital, result.Codigo);
                Assert.AreEqual("MÁS OFERTAS PARA TI RD", result.Titulo);

            }

            [TestMethod]
            public void ObtenerConfiguracionSeccion_GetConfiguracionOfertasHomeRdrDesktop_ReturnSameTitleFromDB()
            {
                // Arrange
                var jsonDataFileName = "ConfiguracionOfertasHome\\ObtenerConfiguracionSeccion\\ConfiguracionOfertasHomeRDR";
                ((ConfiguracionOfertasHomeProviderStub)Provider).FileName = jsonDataFileName;
                SetupRevistaDigitalInSession(true, true);
                SetupPalancaInSession(Constantes.ConfiguracionPais.RevistaDigitalReducida);
                var rd = SessionManager.Object.GetRevistaDigital();


                // Act
                var result = Provider.ObtenerConfiguracionSeccion(rd, false)[0];

                // Assert
                Assert.AreEqual(Constantes.ConfiguracionPais.RevistaDigitalReducida, result.Codigo);
                Assert.AreEqual("MÁS OFERTAS PARA TI RDR", result.Titulo);

            }

            [TestMethod]
            public void ObtenerConfiguracionSeccion_GetConfiguracionOfertasHomeOptMobile_ReturnSameTitleFromDB()
            {
                // Arrange
                var jsonDataFileName = "ConfiguracionOfertasHome\\ObtenerConfiguracionSeccion\\ConfiguracionOfertasHomeOPT";
                ((ConfiguracionOfertasHomeProviderStub)Provider).FileName = jsonDataFileName;
                SetupRevistaDigitalInSession(false, false);
                SetupPalancaInSession(Constantes.ConfiguracionPais.OfertasParaTi);
                var rd = SessionManager.Object.GetRevistaDigital();


                // Act
                var result = Provider.ObtenerConfiguracionSeccion(rd, true)[0];

                // Assert
                Assert.AreEqual(Constantes.ConfiguracionPais.OfertasParaTi, result.Codigo);
                Assert.AreEqual("OFERTAS PARA TI MOBILE", result.Titulo);

            }

            [TestMethod]
            public void ObtenerConfiguracionSeccion_GetConfiguracionOfertasHomeRdMobile_ReturnSameTitleFromDB()
            {
                // Arrange
                var jsonDataFileName = "ConfiguracionOfertasHome\\ObtenerConfiguracionSeccion\\ConfiguracionOfertasHomeRD";
                ((ConfiguracionOfertasHomeProviderStub)Provider).FileName = jsonDataFileName;
                SetupRevistaDigitalInSession(true, true);
                SetupPalancaInSession(Constantes.ConfiguracionPais.RevistaDigital);
                var rd = SessionManager.Object.GetRevistaDigital();


                // Act
                var result = Provider.ObtenerConfiguracionSeccion(rd, true)[0];

                // Assert
                Assert.AreEqual(Constantes.ConfiguracionPais.RevistaDigital, result.Codigo);
                Assert.AreEqual("MÁS OFERTAS PARA TI RD MOBILE", result.Titulo);

            }

            [TestMethod]
            public void ObtenerConfiguracionSeccion_GetConfiguracionOfertasHomeRdrMobile_ReturnSameTitleFromDB()
            {
                // Arrange
                var jsonDataFileName = "ConfiguracionOfertasHome\\ObtenerConfiguracionSeccion\\ConfiguracionOfertasHomeRDR";
                ((ConfiguracionOfertasHomeProviderStub)Provider).FileName = jsonDataFileName;
                SetupRevistaDigitalInSession(true, true);
                SetupPalancaInSession(Constantes.ConfiguracionPais.RevistaDigitalReducida);
                var rd = SessionManager.Object.GetRevistaDigital();


                // Act
                var result = Provider.ObtenerConfiguracionSeccion(rd, true)[0];

                // Assert
                Assert.AreEqual(Constantes.ConfiguracionPais.RevistaDigitalReducida, result.Codigo);
                Assert.AreEqual("MÁS OFERTAS PARA TI RDR MOBILE", result.Titulo);

            }
        }

    }
}
