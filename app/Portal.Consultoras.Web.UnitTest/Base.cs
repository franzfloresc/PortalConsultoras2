using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Common;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.UnitTest
{
    [TestClass]
    public class Base
    {
        private Mock<ISessionManager> _sessionManager;
        private Mock<ILogManager> _logManager;

        protected Mock<ISessionManager> SessionManager
        {
            get { return _sessionManager; }
        }

        protected Mock<ILogManager> LogManager
        {
            get { return _logManager; }
        }

        [TestInitialize]
        public virtual void Test_Initialize()
        {
            _sessionManager = new Mock<ISessionManager>();
            _logManager = new Mock<ILogManager>();
        }

        [TestCleanup]
        public virtual void Test_Cleanup()
        {
            _sessionManager = null;
            _logManager = null;
        }

        #region SessionManager

        protected void ConfigureUserDataWithCampaniaActual(int campaniaId)
        {
            SessionManager.Setup(x => x.GetUserData()).Returns(new UsuarioModel() { CampaniaID = campaniaId, NroCampanias = 18, PaisID = Constantes.PaisID.Peru, CodigoISO = Constantes.CodigosISOPais.Peru });
        }

        protected void SetupRevistaDigitalInSession(bool esSuscrita, bool esActiva)
        {
            SessionManager
                .Setup(x => x.GetRevistaDigital())
                .Returns(
                    new RevistaDigitalModel
                    {
                        TieneRDC = esSuscrita || esActiva,
                        EsSuscrita = esSuscrita,
                        EsActiva = esActiva
                    });
        }

        protected void SetupPalancaInSession(string configuracionPaisCodigo)
        {
            if (!string.IsNullOrEmpty(configuracionPaisCodigo))
            {
                SessionManager
                    .Setup(x => x.GetConfiguracionesPaisModel())
                    .Returns(
                        new List<ConfiguracionPaisModel>
                        {
                                new ConfiguracionPaisModel
                                {
                                    Codigo = configuracionPaisCodigo
                                }
                        });
            }
        }

        #endregion

        #region LogManager

        protected void VerifyDoNotCallLogManager()
        {
            LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                It.IsAny<Exception>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>()
            ), Times.Never);
        }

        protected void VerifyCallLogManager(string method)
        {
            LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                     It.IsAny<Exception>(),
                     It.IsAny<string>(),
                     It.IsAny<string>(),
                     It.Is<string>(str => str.Equals(method))
                     ), Times.Once);
        }

        protected void VerifyCallLogManager(string exceptionMessage,string method)
        {
            LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                     It.Is<Exception>(ex => ex.Message.Contains(exceptionMessage)),
                     It.IsAny<string>(),
                     It.IsAny<string>(),
                     It.Is<string>(str => str.Equals(method))
                     ), Times.Once);
        }

        #endregion
    }
}
