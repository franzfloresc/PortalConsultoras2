using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Attributes;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class LoginControllerUnitTest
    {

        [TestClass]
        public class Base
        {
            public Mock<ILogManager> logManager;
            public Mock<ISessionManager> sessionManager;

            [TestInitialize]
            public void Test_Initialize()
            {
                logManager = new Mock<ILogManager>();
                sessionManager = new Mock<ISessionManager>();
            }

            [TestCleanup]
            public void Test_Cleanup()
            {
                logManager = null;
                sessionManager = null;
            }
        }


        [TestClass]
        public class Index
        {
            //class LoginController_GetClientIpReturnsMultipleIps : LoginController
            //{
            //    protected override bool EsUsuarioAutenticado()
            //    {
            //        return false;
            //    }

            //    protected override IEnumerable<PaisModel> ObtenerPaises()
            //    {
            //        return new List<PaisModel>();
            //    }

            //    protected override string GetIpCliente()
            //    {
            //        return "190.57.170.225, 66.249.83.8";
            //    }

            //    protected override bool EstaActivoBuscarIsoPorIp()
            //    {
            //        return true;
            //    }
            //}

            //[TestMethod]
            //public void Index_GetClientIpReturnsMultipleIps_LogsError()
            //{

            //    var controler = new LoginController_GetClientIpReturnsMultipleIps();

            //    controler.Index();

            //    LogManager.Verify(x => x.LogErrorWebServicesBus2(It.Is<Exception>(e => e.Message.Contains("The specified IP address was incorrectly formatted")),
            //        It.IsAny<string>(),
            //        It.IsAny<string>(),
            //        It.IsAny<string>()), Times.AtLeastOnce);
            //}

            //class LoginController_GetClientIpReturnsOneIp : LoginController
            //{
            //    protected override bool EsUsuarioAutenticado()
            //    {
            //        return false;
            //    }

            //    protected override IEnumerable<PaisModel> ObtenerPaises()
            //    {
            //        return new List<PaisModel>();
            //    }

            //    protected override string GetIpCliente()
            //    {
            //        return "190.57.170.225";
            //    }

            //    protected override bool EstaActivoBuscarIsoPorIp()
            //    {
            //        return true;
            //    }
            //}

            //[TestMethod]
            //public void Index_GetClientIpReturnsOneIp_LogsZeError()
            //{
            //    var controler = new LoginController_GetClientIpReturnsOneIp();

            //    controler.Index();

            //    LogManager.Verify(x => x.LogErrorWebServicesBus2(It.Is<Exception>(e => e.Message.Contains("The specified IP address was incorrectly formatted")),
            //        It.IsAny<string>(),
            //        It.IsAny<string>(),
            //        It.IsAny<string>()), Times.Never);
            //}
        }

        [TestClass]
        public class GetUserData : Base
        {
            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentException), "Parámetro paisId no puede ser cero.")]
            public void GetUserData_WhenPaidIdIsZero_ThrowArgumentException()
            {
                // Arrange
                var controller = new LoginController(logManager.Object,sessionManager.Object);

                // Act
                var result = controller.GetUserData(0, string.Empty, 0);

                // Assert
            }

            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentException), "Parámetro codigoUsuario no puede ser vacío.")]
            public void GetUserData_WhenCodigoUsuarioIsEmpty_ThrowArgumentException()
            {
                // Arrange
                var controller = new LoginController(logManager.Object, sessionManager.Object);

                // Act
                var result = controller.GetUserData(1, string.Empty, 0);

                // Assert
            }

            class LoginControllerStub : LoginController
            {
                public LoginControllerStub(ILogManager logManager,ISessionManager sessionManager):base(logManager,sessionManager)
                {

                }

                protected override BEUsuario GetUsuarioAndLogsIngresoPortal(int paisId, string codigoUsuario, int refrescarDatos)
                {
                    var usuario = new BEUsuario();
                    usuario.CodigoISO = "PE";
                    usuario.RolID = Constantes.Rol.Consultora;
                    usuario.CampaniaID = 201715;
                    usuario.NroCampanias = 18;
                    return usuario;
                }

                protected override List<ConfiguracionPaisModel> GetConfiguracionPais(UsuarioModel usuarioModel)
                {
                    var list = new List<ConfiguracionPaisModel>();
                    list.Add(new ConfiguracionPaisModel { Codigo = "GND" });
                    return list;
                }
            }

            [TestMethod]
            public void GetUserData_WhenConfiguracionPaisHasGnd_UserModelTieneGndReturnsTrue()
            {
                // Arrange
                var controller = new LoginControllerStub(logManager.Object, sessionManager.Object);

                // Act
                var result = controller.GetUserData(1, "041395737", 0);

                // Assert
                Assert.IsNotNull(result);
                Assert.AreEqual(true, result.TieneGND);
            }
        }

        [TestClass]
        public class ConfiguracionPaisDatosRevistaDigital : Base
        {
            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_RevistaDigitalEsNulo_EscribeEnLog()
            {
                var controller = new LoginController(logManager.Object, sessionManager.Object);

                var result = controller.ConfiguracionPaisDatosRevistaDigital(null, null, null);

                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>( s => s.Contains("LoginController.ConfiguracionPaisDatosRevistaDigital"))), 
                    Times.AtLeastOnce);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosEsNulo_EscribeEnLog()
            {
                var controller = new LoginController(logManager.Object, sessionManager.Object);

                var result = controller.ConfiguracionPaisDatosRevistaDigital(new RevistaDigitalModel(), null, null);

                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisDatosRevistaDigital"))),
                    Times.AtLeastOnce);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_PaisIsoEsNulo_EscribeEnLog()
            {
                var controller = new LoginController(logManager.Object, sessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>();

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, null);

                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisDatosRevistaDigital"))),
                    Times.AtLeastOnce);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBloquearDiasAntesFacturar_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(logManager.Object, sessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.BloquearDiasAntesFacturar,
                        Valor1 = "100"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(100, result.BloquearDiasAntesFacturar);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneSubscripcionAutomaticaAVirtualCoach_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(logManager.Object, sessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.SubscripcionAutomaticaAVirtualCoach,
                        Valor1 = "1"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(true, result.SubscripcionAutomaticaAVirtualCoach);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }
        }
    }
}
