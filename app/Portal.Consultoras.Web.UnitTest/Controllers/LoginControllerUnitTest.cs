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
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class LoginControllerUnitTest
    {

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
                var controller = new LoginController(LogManager.Object,SessionManager.Object);

                // Act
                var result = controller.GetUserData(0, string.Empty, 0).Result;

                // Assert
            }

            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentException), "Parámetro codigoUsuario no puede ser vacío.")]
            public void GetUserData_WhenCodigoUsuarioIsEmpty_ThrowArgumentException()
            {
                // Arrange
                var controller = new LoginController(LogManager.Object, SessionManager.Object);

                // Act
                var result = controller.GetUserData(1, string.Empty, 0).Result;

                // Assert
            }

            class LoginControllerStub : LoginController
            {
                public LoginControllerStub(ILogManager logManager,ISessionManager sessionManager):base(logManager,sessionManager)
                {

                }

                protected override async Task<ServiceUsuario.BEUsuario> GetUsuarioAndLogsIngresoPortal(int paisId, string codigoUsuario, int refrescarDatos)
                {
                    return  await Task.Factory.StartNew(() =>
                    {
                        var usuario = new BEUsuario();
                        usuario.CodigoISO = "PE";
                        usuario.RolID = Constantes.Rol.Consultora;
                        usuario.CampaniaID = 201715;
                        usuario.NroCampanias = 18;
                        return usuario;
                    });                  
                }                

                protected override async Task<List<ConfiguracionPaisModel>> GetConfiguracionPais(UsuarioModel usuarioModel)
                {
                    return await Task.Factory.StartNew(() =>
                    {
                        var list = new List<ConfiguracionPaisModel>();
                        list.Add(new ConfiguracionPaisModel { Codigo = "GND" });
                        return list;
                    });                    
                }
            }

            [TestMethod]
            public void GetUserData_WhenConfiguracionPaisHasGnd_UserModelTieneGndReturnsTrue()
            {
                // Arrange
                var controller = new LoginControllerStub(LogManager.Object, SessionManager.Object);

                // Act
       
                var result = controller.GetUserData(1, "041395737", 0).Result;
                
                // Assert
                Assert.IsNotNull(result);
                Assert.AreEqual(true, result.TieneGND);
            }
        }

        [TestClass]
        public class ConfiguracionPaisUsuario : Base
        {
            [TestMethod]
            public void ConfiguracionPaisUsuario_UsuarioEsNulo_RetornaNulo()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                UsuarioModel usuario = null;

                var result = controller.ConfiguracionPaisUsuario(usuario).Result;

                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("No puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisUsuario"))),
                    Times.AtLeastOnce);
                Assert.IsNull(result);
            }

            [TestMethod]
            public void ConfiguracionPaisUsuario_UsuarioEsPostulante_RetornaUsuarioYSeEscribeEnLog()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var usuario = new UsuarioModel
                {
                    TipoUsuario = Constantes.TipoUsuario.Postulante
                };

                var result = controller.ConfiguracionPaisUsuario(usuario);

                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("No se asigna configuracion pais para los Postulantes")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisUsuario"))),
                    Times.AtLeastOnce);
                Assert.IsNotNull(result);
            }

            class LoginControllerStub : LoginController
            {
                public LoginControllerStub(ILogManager logManager, ISessionManager sessionManager) : base(logManager, sessionManager)
                {

                }

                protected override async Task<List<ConfiguracionPaisModel>> GetConfiguracionPais(UsuarioModel usuarioModel)
                {
                    return await Task.Factory.StartNew(() =>
                    {
                        var list = new List<ConfiguracionPaisModel>();
                        list.Add(new ConfiguracionPaisModel { Codigo = Constantes.ConfiguracionPais.RevistaDigital });
                        list.Add(new ConfiguracionPaisModel { Codigo = Constantes.ConfiguracionPais.RevistaDigitalIntriga });
                        return list;
                    });

                    
                }

                protected override async Task<List<BEConfiguracionPaisDatos>> GetConfiguracionPaisDatos(UsuarioModel usuarioModel)
                {
                    return await Task.Factory.StartNew(() =>
                    {
                        var list = new List<BEConfiguracionPaisDatos>();
                        //
                        return list;
                    });                    
                }

                protected override void ActualizarSubscripciones(RevistaDigitalModel revistaDigitalModel, UsuarioModel usuarioModel)
                {
                    //
                }
            }
            [TestMethod]
            public void ConfiguracionPaisUsuario_EstaActivoRevistaDigitalYRevistaDigitalIntriga_EscribeEnLog()
            {
                var controller = new LoginControllerStub(LogManager.Object,SessionManager.Object);
                var usuario = new UsuarioModel
                {
                    TipoUsuario = Constantes.TipoUsuario.Consultora,
                    NombreConsultora = "UnNombre",
                    Sobrenombre= "UnSobreNombre"
                };

                var result = controller.ConfiguracionPaisUsuario(usuario).Result;

                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("No puede estar activo configuracion pais RD y RDI a la vez.")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisUsuario"))),
                    Times.AtLeastOnce);
                Assert.IsNotNull(result);
            }

            class LoginControllerStub02 : LoginController
            {
                public LoginControllerStub02(ILogManager logManager, ISessionManager sessionManager) : base(logManager, sessionManager)
                {

                }

                protected override async Task<List<ConfiguracionPaisModel>> GetConfiguracionPais(UsuarioModel usuarioModel)
                {
                    return await Task.Factory.StartNew(() =>
                    {
                        var list = new List<ConfiguracionPaisModel>();
                        list.Add(new ConfiguracionPaisModel { Codigo = Constantes.ConfiguracionPais.RevistaDigitalIntriga });
                        return list;
                    });
                    
                }

                protected override async Task<List<BEConfiguracionPaisDatos>> GetConfiguracionPaisDatos(UsuarioModel usuarioModel)
                {
                    return await Task.Factory.StartNew(() =>
                    {
                        var list = new List<BEConfiguracionPaisDatos>();
                        //
                        return list;
                    });                    
                }

                protected override void ActualizarSubscripciones(RevistaDigitalModel revistaDigitalModel, UsuarioModel usuarioModel)
                {
                    //
                }
            }
            [TestMethod]
            public void ConfiguracionPaisUsuario_TieneRevistaDigitalIntriga_ActualizaRevistaDigitalModel()
            {
                var controller = new LoginControllerStub02(LogManager.Object, SessionManager.Object);
                var usuario = new UsuarioModel
                {
                    TipoUsuario = Constantes.TipoUsuario.Consultora,
                    NombreConsultora = "UnNombre",
                    Sobrenombre = "UnSobreNombre"
                };

                var result = controller.ConfiguracionPaisUsuario(usuario).Result;

                Assert.IsNotNull(result);
                SessionManager.Verify(x => x.SetRevistaDigital(It.Is<RevistaDigitalModel>(rd => rd.TieneRDI == true && rd.TieneRDC == false)));
            }
        }

        [TestClass]
        public class ConfiguracionPaisDatosRevistaDigital : Base
        {
            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_RevistaDigitalEsNulo_EscribeEnLog()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);

                var result = controller.ConfiguracionPaisDatosRevistaDigital(null, null, null);

                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>( s => s.Contains("LoginController.ConfiguracionPaisDatosRevistaDigital"))), 
                    Times.AtLeastOnce);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosEsNulo_RetornaRevistaDigital()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                RevistaDigitalModel revistaDigitalModel = new RevistaDigitalModel();

                var result = controller.ConfiguracionPaisDatosRevistaDigital(revistaDigitalModel, null, null);

                Assert.IsNotNull(result);
                Assert.AreSame(revistaDigitalModel, result);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_PaisIsoEsNulo_RetornaRevistaDigital()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>();

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, null);

                Assert.IsNotNull(result);
                Assert.AreSame(rdModel, result);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBloquearDiasAntesFacturar_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
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
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneCantidadCampaniaEfectiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.CantidadCampaniaEfectiva,
                        Valor1 = "10"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(10, result.CantidadCampaniaEfectiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneNombreComercialActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.NombreComercialActiva,
                        Valor1 = "NombreComercialActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("NombreComercialActiva", result.NombreComercialActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneNombreComercialNoActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.NombreComercialNoActiva,
                        Valor1 = "NombreComercialNoActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("NombreComercialNoActiva", result.NombreComercialNoActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoComercialActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoComercialActiva,
                        Valor1 = "DLogoComercialActiva",
                        Valor2 = "MLogoComercialActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("DLogoComercialActiva", result.DLogoComercialActiva);
                Assert.AreEqual("MLogoComercialActiva", result.MLogoComercialActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoComercialNoActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoComercialNoActiva,
                        Valor1 = "DLogoComercialNoActiva",
                        Valor2 = "MLogoComercialNoActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("DLogoComercialNoActiva", result.DLogoComercialNoActiva);
                Assert.AreEqual("MLogoComercialNoActiva", result.MLogoComercialNoActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoMenuInicioActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoMenuInicioActiva,
                        Valor1 = "DLogoMenuInicioActiva",
                        Valor2 = "MLogoMenuInicioActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("DLogoMenuInicioActiva", result.DLogoMenuInicioActiva);
                Assert.AreEqual("MLogoMenuInicioActiva", result.MLogoMenuInicioActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoMenuInicioNoActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoMenuInicioNoActiva,
                        Valor1 = "DLogoMenuInicioNoActiva",
                        Valor2 = "MLogoMenuInicioNoActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("DLogoMenuInicioNoActiva", result.DLogoMenuInicioNoActiva);
                Assert.AreEqual("MLogoMenuInicioNoActiva", result.MLogoMenuInicioNoActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoComercialFondoActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoActiva,
                        Valor1 = "DLogoComercialFondoActiva",
                        Valor2 = "MLogoComercialFondoActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("DLogoComercialFondoActiva", result.DLogoComercialFondoActiva);
                Assert.AreEqual("MLogoComercialFondoActiva", result.MLogoComercialFondoActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoComercialFondoNoActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoComercialFondoNoActiva,
                        Valor1 = "DLogoComercialFondoNoActiva",
                        Valor2 = "MLogoComercialFondoNoActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("DLogoComercialFondoNoActiva", result.DLogoComercialFondoNoActiva);
                Assert.AreEqual("MLogoComercialFondoNoActiva", result.MLogoComercialFondoNoActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoMenuOfertasActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasActiva,
                        Valor1 = "LogoMenuOfertasActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("LogoMenuOfertasActiva", result.LogoMenuOfertasActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneLogoMenuOfertasNoActiva_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.LogoMenuOfertasNoActiva,
                        Valor1 = "LogoMenuOfertasNoActiva"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("LogoMenuOfertasNoActiva", result.LogoMenuOfertasNoActiva);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBloquearPedidoRevistaImp_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.BloquearPedidoRevistaImp,
                        Valor1 = "1"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(1, result.BloquearRevistaImpresaGeneral);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBloquearSugerenciaProducto_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.BloquearSugerenciaProducto,
                        Valor1 = "1"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(1, result.BloquearProductosSugeridos);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneSubscripcionAutomaticaAVirtualCoach_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
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

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBloqueoProductoDigital_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital,
                        Valor1 = "1"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(true, result.BloqueoProductoDigital);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBannerOfertasNoActivaNoSuscrita_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.BannerOfertasNoActivaNoSuscrita,
                        Valor1 = "banner-ganamas.jpg",
                        Valor2 = null
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("banner-ganamas.jpg", result.BannerOfertasNoActivaNoSuscrita);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBannerOfertasNoActivaSuscrita_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.BannerOfertasNoActivaSuscrita,
                        Valor1 = "banner-ganamas.jpg",
                        Valor2 = null
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("banner-ganamas.jpg", result.BannerOfertasNoActivaSuscrita);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBannerOfertasActivaNoSuscrita_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.BannerOfertasActivaNoSuscrita,
                        Valor1 = "banner-ganamas.jpg",
                        Valor2 = null
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("banner-ganamas.jpg", result.BannerOfertasActivaNoSuscrita);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneBannerOfertasActivaSuscrita_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.BannerOfertasActivaSuscrita,
                        Valor1 = "banner-ganamas.jpg",
                        Valor2 = null
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual("banner-ganamas.jpg", result.BannerOfertasActivaSuscrita);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneSEExperienciaClub_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.SociaEEmpresariaExperienciaClub,
                        Valor1 = "1",
                        Valor2 = null
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(true, result.SociaEmpresariaExperienciaGanaMas);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneSESuscritaNoActivaCancelarSuscripcion_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion,
                        Valor1 = "1",
                        Valor2 = null
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(true, result.SociaEmpresariaSuscritaNoActivaCancelarSuscripcion);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigital_ListaDatosTieneSESuscritaActivaCancelarSuscripcion_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RD.SociaEmpresariaSuscritaActivaCancelarSuscripcion,
                        Valor1 = "1",
                        Valor2 = null
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigital(rdModel, listaDatos, "PE");

                Assert.AreEqual(true, result.SociaEmpresariaSuscritaActivaCancelarSuscripcion);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }
        }

        [TestClass]
        public class ConfiguracionPaisDatosRevistaDigitalIntriga : Base
        {
            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_RevistaDigitalEsNulo_EscribeEnLog()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(null, null, null);

                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisDatosRevistaDigitalIntriga"))),
                    Times.AtLeastOnce);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_ListaDatosEsNulo_EscribeEnLog()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(new RevistaDigitalModel(), null, null);

                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisDatosRevistaDigitalIntriga"))),
                    Times.AtLeastOnce);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_PaisIsoEsNulo_EscribeEnLog()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>();

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(rdModel, listaDatos, null);

                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
                    It.Is<Exception>(e => e.Message.Contains("no puede ser nulo")),
                    It.IsAny<string>(),
                    It.IsAny<string>(),
                    It.Is<string>(s => s.Contains("LoginController.ConfiguracionPaisDatosRevistaDigitalIntriga"))),
                    Times.AtLeastOnce);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_ListaDatosTieneLogoMenuOfertas_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RDI.LogoMenuOfertas,
                        Valor1 = "Valor1",
                        Valor2 = "Valor2"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(rdModel, listaDatos, "PE");

                Assert.AreEqual("Valor1", result.LogoMenuOfertasNoActiva);
                Assert.AreEqual(0, listaDatos.Count);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_ListaDatosTieneLogoComercial_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RDI.LogoComercial,
                        Valor1 = "Valor1",
                        Valor2 = "Valor2"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(rdModel, listaDatos, "PE");

                Assert.AreEqual("Valor1", result.DLogoComercialNoActiva);
                Assert.AreEqual("Valor2", result.MLogoComercialNoActiva);
                Assert.AreEqual(0, listaDatos.Count);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_ListaDatosTieneLogoComercialFondo_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RDI.LogoComercialFondo,
                        Valor1 = "Valor1",
                        Valor2 = "Valor2"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(rdModel, listaDatos, "PE");

                Assert.AreEqual("Valor1", result.DLogoComercialFondoNoActiva);
                Assert.AreEqual("Valor2", result.MLogoComercialFondoNoActiva);
                Assert.AreEqual(0, listaDatos.Count);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_ListaDatosTieneNombreComercial_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.RDI.NombreComercial,
                        Valor1 = "Valor1"
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(rdModel, listaDatos, "PE");

                Assert.AreEqual("Valor1", result.NombreComercialNoActiva);
                Assert.AreEqual(0, listaDatos.Count);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_ListaDatosTieneBloqueoProductoDigitalActivo_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                    new BEConfiguracionPaisDatos
                    {
                        Codigo = Constantes.ConfiguracionPaisDatos.BloqueoProductoDigital,
                        Valor1 = "1",
                    }
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(rdModel, listaDatos, "PE");

                Assert.AreEqual(true, result.BloqueoProductoDigital);
                Assert.AreEqual(0, listaDatos.Count);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }

            [TestMethod]
            public void ConfiguracionPaisDatosRevistaDigitalIntriga_ListaDatosNoTieneBloqueoProductoDigital_SeActualizaRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var rdModel = new RevistaDigitalModel();
                var listaDatos = new List<BEConfiguracionPaisDatos>
                {
                };

                var result = controller.ConfiguracionPaisDatosRevistaDigitalIntriga(rdModel, listaDatos, "PE");

                Assert.AreEqual(false, result.BloqueoProductoDigital);
                Assert.AreEqual(0, listaDatos.Count);
                Assert.AreEqual(0, result.ConfiguracionPaisDatos.Count);
            }
        }

        [TestClass]
        public class FormatTextConfiguracionPaisDatosModel : Base
        {
            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "No puede ser nulo.\r\nParameter name: revistaDigital")]
            public void FormatTextConfiguracionPaisDatosModel_RevistaDigitalEsNulo_LanzaException()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var revistaModel = (RevistaDigitalModel)null;

                controller.FormatTextConfiguracionPaisDatosModel(revistaModel,string.Empty);
            }

            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "No puede ser nulo o vacío.\r\nParameter name: nombreConsultora")]
            public void FormatTextConfiguracionPaisDatosModel_NombreConsultoraEsNulo_LanzaException()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var revistaModel = new RevistaDigitalModel();

                controller.FormatTextConfiguracionPaisDatosModel(revistaModel, string.Empty);
            }

            [TestMethod]
            public void FormatTextConfiguracionPaisDatosModel_RevistaDigitalModelNoTieneConfiguracionDatos_ReturnRevistaDigitalModel()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var revistaModel = new RevistaDigitalModel {
                    ConfiguracionPaisDatos=null
                };

                var result = controller.FormatTextConfiguracionPaisDatosModel(revistaModel, "NombreConsultora");

                Assert.IsNotNull(result);
            }

            [TestMethod]
            public void FormatTextConfiguracionPaisDatosModel_RevistaDigitalModelTieneConfiguracionDatos_ReturnRevistaDigitalModelTextosFormateados()
            {
                var controller = new LoginController(LogManager.Object, SessionManager.Object);
                var revistaModel = new RevistaDigitalModel
                {
                    NombreConsultora="Consultora de Prueba" ,                   
                    ConfiguracionPaisDatos = new List<ConfiguracionPaisDatosModel> {
                        new ConfiguracionPaisDatosModel{
                            Codigo = Constantes.ConfiguracionPaisDatos.RDI.DBienvenidaIntriga,
                            Valor1="#Nombre, ¡Bienvenida al tu nuevo espacio de ofertas exclusivas",
                            Valor2="#Nombre, ¡otro mensaje más"
                        }
                    }
                };

                var result = controller.FormatTextConfiguracionPaisDatosModel(revistaModel, revistaModel.NombreConsultora);

                Assert.IsNotNull(result);
                Assert.AreEqual("Consultora de Prueba, ¡Bienvenida al tu nuevo espacio de ofertas exclusivas", revistaModel.ConfiguracionPaisDatos[0].Valor1);
                Assert.AreEqual("Consultora de Prueba, ¡otro mensaje más", revistaModel.ConfiguracionPaisDatos[0].Valor2);
            }
        }
    }
}
