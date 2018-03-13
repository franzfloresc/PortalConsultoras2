using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using MvcContrib.TestHelper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using Portal.Consultoras.Web.ServiceSeguridad;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.LogManager;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseControllerUnitTest
    {
        [TestClass]
        public class Base
        {
            protected Mock<ISessionManager> sessionManager;
            protected Mock<ILogManager> logManager;

            [TestInitialize]
            public void Test_Initialize()
            {
                sessionManager = new Mock<ISessionManager>();
                logManager = new Mock<ILogManager>();
            }

            [TestCleanup]
            public void Test_Cleanup()
            {
                sessionManager = null;
                logManager = null;
            }
        }

        [TestClass]
        public class BuildMenuMobile : Base
        {
            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "Value cannot be null.\r\nParameter name: userData")]
            public void BuildMenuMobile_UserDataEsNulo_LanzaExcepcion()
            {
                var controller = new BaseController();
                var userData = (UsuarioModel)null;
                var revistaDigital = (RevistaDigitalModel)null;

                controller.BuildMenuMobile(userData, revistaDigital);
            }

            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "Value cannot be null.\r\nParameter name: revistaDigital")]
            public void BuildMenuMobile_RevistaDigitalEsNulo_LanzaExcepcion()
            {
                var controller = new BaseController();
                var userData = new UsuarioModel { };
                var revistaDigital =  (RevistaDigitalModel)null;

                controller.BuildMenuMobile(userData, revistaDigital);
            }


            class BaseControllerStub01: BaseController
            {
                public BaseControllerStub01(ISessionManager sessionManager) : base(sessionManager)
                {

                }

                protected override List<MenuMobileModel> GetMenuMobileModel(int paisID)
                {
                    return new List<MenuMobileModel> {
                        new MenuMobileModel{
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            UrlImagen=String.Empty,
                            Descripcion=string.Empty,
                            Posicion="Menu",
                            OnClickFunt=string.Empty
                        }
                    };
                }

                public override string GetUrlImagenMenuOfertas(UsuarioModel userData, RevistaDigitalModel revistaDigital)
                {
                    return "UrlImagenMenuOfertasMobile";
                }
            }
            [TestMethod]
            public void BuildMenuMobile_UserIsConsultoraMenuOfertaGetsItsImageUrl_UrlImagenIsNotNull()
            {
                sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                var controller = new BaseControllerStub01(sessionManager.Object);
                var userData = new UsuarioModel { RolID = Constantes.Rol.Consultora };
                var revistaDigital = new RevistaDigitalModel {  };

                var result = controller.BuildMenuMobile(userData, revistaDigital).First();

                Assert.IsNotNull(result);
                Assert.IsNotNull(result.UrlImagen);
                Assert.AreEqual("UrlImagenMenuOfertasMobile", result.UrlImagen);
            }
        }

        [TestClass]
        public class BuildMenu : Base
        {
            class BaseControllerStub00 : BaseController
            {
                protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                {
                    return new List<PermisoModel> {
                    };
                }
            }
            [TestMethod]
            public void BuildMenu_PropiedadClaseLogoSBInUserDataNoEsNula_ActualizaViewBag()
            {
                var controller = new BaseControllerStub00(/*sessionManager.Object*/);
                var userData = new UsuarioModel { ClaseLogoSB = "ClaseLogoSB" };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = false, TieneRDR = false };

                var menuOferta = controller.BuildMenu(userData, revistaDigital);

                Assert.IsNotNull(menuOferta);
                Assert.AreEqual(controller.ViewBag.ClaseLogoSB, "ClaseLogoSB");
            }

            class BaseControllerStub03 : BaseController
            {
                public BaseControllerStub03(ISessionManager sessionManager) : base(sessionManager)
                {

                }

                protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                {
                    return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                }

                public override string GetUrlImagenMenuOfertas(UsuarioModel userData, RevistaDigitalModel revistaDigital)
                {
                    return "url-imagen-menu-oferta.gif";
                }
            }
            [TestMethod]
            public void BuildMenu_TienePermisoContenedorOfertasYUrlImagenMenuOfertasNoEsNula_MenuOfertasEsSoloImagenTrueYDevuelreUrl()
            {
                sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                var controller = new BaseControllerStub03(sessionManager.Object);
                var userData = new UsuarioModel { };
                var revistaDigital = new RevistaDigitalModel{};

                var result = controller.BuildMenu(userData, revistaDigital).First();

                Assert.AreEqual(true, result.EsSoloImagen);
                Assert.IsNotNull(result.UrlImagen);
            }
        }

        [TestClass]
        public class GetUrlImagenMenuOfertas 
        {
            [TestClass]
            public class SinEventoFestivo : Base
            {
                class BaseControllerStub01 : BaseController
                {
                    public BaseControllerStub01(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }
                    protected override string GetDefaultGifMenuOfertas()
                    {
                        return "cualquier-image.gif";
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraNoEsikaParaMiSinEventoFestivo_TieneGifPorDefecto()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub01(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel { TieneRDC = false, TieneRDR = false };

                    var url = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(url);
                    Assert.IsTrue(url.Contains("cualquier-image.gif"));
                }




                class BaseControllerStub02 : BaseController
                {
                    public BaseControllerStub02(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaInactivaSinEventoFestivo_TieneGifGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub02(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDR = false,
                        EsSuscrita = false,
                        EsActiva = false,
                        LogoMenuOfertasNoActiva = "gana-mas.gif"
                    };

                    var menuOferta = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(menuOferta);
                    Assert.IsTrue(menuOferta.Contains("gana-mas.gif"));
                }

                class BaseControllerStub03 : BaseController
                {
                    public BaseControllerStub03(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaInactivaSinEventoFestivo_TieneGifClubGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub03(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDR = false,
                        //
                        EsSuscrita = true,
                        EsActiva = false,
                        //
                        LogoMenuOfertasActiva = "club-gana-mas.gif"
                    };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("club-gana-mas.gif"));
                }

                class BaseControllerStub04 : BaseController
                {
                    public BaseControllerStub04(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaActivaSinEventoFestivo_TieneGifClubGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub04(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDR = false,
                        //
                        EsSuscrita = true,
                        EsActiva = true,
                        //
                        LogoMenuOfertasActiva = "club-gana-mas.gif"
                    };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("club-gana-mas.gif"));
                }

                class BaseControllerStub05 : BaseController
                {
                    public BaseControllerStub05(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaActivaSinEventoFestivo_TieneGifClubGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub05(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDR = false,
                        //
                        EsSuscrita = false,
                        EsActiva = true,
                        //
                        LogoMenuOfertasActiva = "club-gana-mas.gif"
                    };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("club-gana-mas.gif"));
                }



                class BaseControllerStub06 : BaseController
                {
                    public BaseControllerStub06(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiIntrigaSinEventoFestivo_TieneGifGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub06(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = false,
                        TieneRDR = false,
                        TieneRDI = true,
                        LogoMenuOfertasNoActiva = "gana-mas.gif"
                    };

                    var menuOferta = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(menuOferta);
                    Assert.IsTrue(menuOferta.Contains("gana-mas.gif"));
                }
            }

            [TestClass]
            public class ConEventoFestivo : Base
            {
                class BaseControllerStub06 : BaseController
                {
                    public BaseControllerStub06(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraNoEsikaParaMiConEventoFestivo_DevuelveGifEventoFestivo()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS,
                            Personalizacion = "evento-festivo-ofertas-no-epm.gif"
                        }
                    }
                    });
                    var controller = new BaseControllerStub06(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel { TieneRDC = false, TieneRDR = false };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("evento-festivo-ofertas-no-epm.gif"));
                }




                class BaseControllerStub07 : BaseController
                {
                    public BaseControllerStub07(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaInactivaConEventoFestivo_DevuelveGifEventoFestivoGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseControllerStub07(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel { TieneRDC = true, TieneRDR = false };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("evento-festivo-ofertas-gana-mas.gif"));
                }

                class BaseControllerStub08 : BaseController
                {
                    public BaseControllerStub08(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaInactivaConEventoFestivo_TieneGifEventoFestivoClubGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-club-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseControllerStub08(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDR = false,
                        //
                        EsSuscrita = true,
                        EsActiva = false,
                    };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("evento-festivo-ofertas-club-gana-mas.gif"));
                }

                class BaseControllerStub09 : BaseController
                {
                    public BaseControllerStub09(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaActivaConEventoFestivo_TieneGifClubGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-club-gana-mas-.gif"
                        }
                    }
                    });
                    var controller = new BaseControllerStub09(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDR = false,
                        //
                        EsSuscrita = true,
                        EsActiva = true,
                    };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("evento-festivo-ofertas-club-gana-mas-.gif"));
                }

                class BaseControllerStub10 : BaseController
                {
                    public BaseControllerStub10(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaActivaConEventoFestivo_TieneGifClubGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-club-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseControllerStub10(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDR = false,
                        //
                        EsSuscrita = false,
                        EsActiva = true,
                    };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("evento-festivo-ofertas-club-gana-mas.gif"));
                }



                class BaseControllerStub11 : BaseController
                {
                    public BaseControllerStub11(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    {
                        return new List<PermisoModel> {
                        new PermisoModel
                        {
                            PermisoID=1,
                            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                            UrlItem = string.Empty,
                            DescripcionFormateada=string.Empty,
                            Posicion=string.Empty
                        }
                    };
                    }
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiIntrigaConEventoFestivo_DevuelveGifEventoFestivoGanaMas()
                {
                    sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseControllerStub11(sessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel {
                        TieneRDC = false,
                        TieneRDR = false,
                        TieneRDI = true
                    };

                    var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    Assert.IsNotNull(result);
                    Assert.IsTrue(result.Contains("evento-festivo-ofertas-gana-mas.gif"));
                }
            }
        }

        [TestClass]
        public class ObtenerConfiguracionSeccion : Base
        {
            [TestMethod]
            public void ObtenerConfiguracionSeccion_RevistaDigitalEsNulo_EscribeEnLogYDevuelveListaVacia()
            {
                sessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                var controller = new BaseController(sessionManager.Object,logManager.Object);
                RevistaDigitalModel revistaDigital = null;

                var result = controller.ObtenerConfiguracionSeccion(revistaDigital);

                Assert.IsNotNull(result);
                Assert.AreEqual(0, result.Count);
                logManager.Verify(x => x.LogErrorWebServicesBusWrap(
                   It.Is<Exception>(e => e.Message.Contains("revistaDigital") && e.Message.Contains("no puede ser nulo")),
                   It.IsAny<string>(),
                   It.IsAny<string>(),
                   It.Is<string>(s => s.Contains("BaseController.ObtenerConfiguracionSeccion"))),
                   Times.AtLeastOnce);
            }

            class BaseControllerStub01 : BaseController
            {
                public BaseControllerStub01(ISessionManager sessionManager,ILogManager logManager) : base(sessionManager,logManager)
                {
                    //
                }

                public override bool IsMobile()
                {
                    return false;
                }

                public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                {
                    return new List<BEConfiguracionOfertasHome>
                    {
                        new BEConfiguracionOfertasHome
                        {
                            ConfiguracionPaisID=0,
                            ConfiguracionPais = new BEConfiguracionPais
                            {
                                ConfiguracionPaisID =0,
                                Codigo = "",
                                Excluyente = false
                            },                            
                        }
                    };
                }
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeccionNoPerteneceANingunaConfiguracionPais_NoSeDevuelve()
            {
                sessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                var controller = new BaseControllerStub01(sessionManager.Object, logManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                var result = controller.ObtenerConfiguracionSeccion(revistaDigital);

                Assert.IsNotNull(result);
                Assert.AreEqual(0, result.Count);
            }

            class BaseControllerStub02 : BaseController
            {
                public BaseControllerStub02(ISessionManager sessionManager, ILogManager logManager) : base(sessionManager, logManager)
                {
                    //
                }

                public override bool IsMobile()
                {
                    return false;
                }

                public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                {
                    return new List<BEConfiguracionOfertasHome>
                    {
                        new BEConfiguracionOfertasHome
                        {
                            ConfiguracionPaisID=18,
                            ConfiguracionPais = new BEConfiguracionPais
                            {
                                ConfiguracionPaisID =18,
                                Codigo = "HV",
                                Excluyente = false
                            },
                            CampaniaID = 201801,
                            UrlSeccion = "HerramientasVenta/Index",
                            //
                            DesktopOrden = 9,
                            DesktopImagenFondo = "PE_20171045539_xfwrimsvol_Desktop.png",
                            DesktopTitulo = "Titulo Herramienta Venta - Desktop",
                            DesktopSubTitulo = "SubTitulo Herramienta Venta - Desktop",
                            DesktopTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado,
                            DesktopTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                            DesktopCantidadProductos = 3
                        }
                    };
                }
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasDesktopYNoTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                sessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                sessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { });
                var controller = new BaseControllerStub02(sessionManager.Object, logManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                Assert.IsNull(result);
            }

            class BaseControllerStub03 : BaseController
            {
                public BaseControllerStub03(ISessionManager sessionManager, ILogManager logManager) : base(sessionManager, logManager)
                {
                    //
                }

                public override bool IsMobile()
                {
                    return false;
                }

                public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                {
                    return new List<BEConfiguracionOfertasHome>
                    {
                        new BEConfiguracionOfertasHome
                        {
                            ConfiguracionPaisID=18,
                            ConfiguracionPais = new BEConfiguracionPais
                            {
                                ConfiguracionPaisID =18,
                                Codigo = "HV",
                                Excluyente = false
                            },
                            CampaniaID = 201801,
                            UrlSeccion = "HerramientasVenta/Index",
                            //
                            DesktopOrden = 9,
                            DesktopImagenFondo = "PE_20171045539_xfwrimsvol_Desktop.png",
                            DesktopTitulo = "Titulo Herramienta Venta - Desktop",
                            DesktopSubTitulo = "SubTitulo Herramienta Venta - Desktop",
                            DesktopTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado,
                            DesktopTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                            DesktopCantidadProductos = 3                            
                        }
                    };
                }
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasDesktopYTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                sessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                sessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { new ConfiguracionPaisModel { ConfiguracionPaisID =18, Codigo = "HV" } });
                var controller = new BaseControllerStub03(sessionManager.Object, logManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                Assert.IsNotNull(result);
                Assert.AreEqual("HV", result.Codigo);
                Assert.AreEqual(9, result.Orden);
                Assert.AreEqual("PE_20171045539_xfwrimsvol_Desktop.png", result.ImagenFondo);
                Assert.AreEqual("Titulo Herramienta Venta - Desktop", result.Titulo);
                Assert.AreEqual("SubTitulo Herramienta Venta - Desktop", result.SubTitulo);
                Assert.AreEqual(Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado, result.TipoPresentacion);
                Assert.AreEqual(Constantes.TipoEstrategiaCodigo.HerramientasVenta, result.TipoEstrategia);
                Assert.AreEqual(3, result.CantidadMostrar);
                Assert.AreEqual("/HerramientasVenta/Comprar", result.UrlLandig);
                Assert.AreEqual(true, result.VerMas);
                //
                Assert.AreEqual("HerramientasVenta/ObtenerProductos", result.UrlObtenerProductos);
                Assert.AreEqual(Constantes.OrigenPedidoWeb.HVDesktopContenedor, result.OrigenPedido);
                //
                Assert.AreEqual("seccion-simple-centrado", result.TemplatePresentacion);
                Assert.AreEqual("#producto-landing-template", result.TemplateProducto);
            }

            class BaseControllerStub04 : BaseController
            {
                public BaseControllerStub04(ISessionManager sessionManager, ILogManager logManager) : base(sessionManager, logManager)
                {
                    //
                }

                public override bool IsMobile()
                {
                    return true;
                }

                public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                {
                    return new List<BEConfiguracionOfertasHome>
                    {
                        new BEConfiguracionOfertasHome
                        {
                            ConfiguracionPaisID=18,
                            ConfiguracionPais = new BEConfiguracionPais
                            {
                                ConfiguracionPaisID =18,
                                Codigo = "HV",
                                Excluyente = false
                            },
                            CampaniaID = 201801,
                            UrlSeccion = "HerramientaVentas/Index",                            
                            //
                            MobileOrden = 99,
                            MobileImagenFondo = "PE_20171045539_xfwrimsvol_Mobile.png",
                            MobileTitulo = "Titulo Herramienta Venta - Mobile",
                            MobileSubTitulo = "SubTitulo Herramienta Venta - Mobile",
                            MobileTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.Banners,
                            MobileTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                        }
                    };
                }
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasMobileYTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                sessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                sessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { new ConfiguracionPaisModel { ConfiguracionPaisID = 18, Codigo = "HV" } });
                var controller = new BaseControllerStub04(sessionManager.Object, logManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                Assert.IsNotNull(result);
                Assert.AreEqual("HV", result.Codigo);
                Assert.AreEqual(99, result.Orden);
                Assert.AreEqual("PE_20171045539_xfwrimsvol_Mobile.png", result.ImagenFondo);
                Assert.AreEqual("Titulo Herramienta Venta - Mobile", result.Titulo);
                Assert.AreEqual("SubTitulo Herramienta Venta - Mobile", result.SubTitulo);
                Assert.AreEqual(Constantes.ConfiguracionSeccion.TipoPresentacion.Banners, result.TipoPresentacion);
                Assert.AreEqual(Constantes.TipoEstrategiaCodigo.HerramientasVenta, result.TipoEstrategia);
                Assert.AreEqual(0, result.CantidadMostrar);
                Assert.AreEqual("/Mobile/HerramientasVenta/Comprar", result.UrlLandig);
                Assert.AreEqual(true, result.VerMas);
                //
                //Assert.AreEqual(true, string.IsNullOrEmpty(result.UrlObtenerProductos));
                Assert.AreEqual(0, result.OrigenPedido);
                //
                Assert.AreEqual("seccion-banner", result.TemplatePresentacion);
                Assert.AreEqual("", result.TemplateProducto);
            }

            class BaseControllerStub05 : BaseController
            {
                public BaseControllerStub05(ISessionManager sessionManager, ILogManager logManager) : base(sessionManager, logManager)
                {
                    //
                }

                public override bool IsMobile()
                {
                    return true;
                }

                public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                {
                    return new List<BEConfiguracionOfertasHome>
                    {
                        new BEConfiguracionOfertasHome
                        {
                            ConfiguracionPaisID=18,
                            ConfiguracionPais = new BEConfiguracionPais
                            {
                                ConfiguracionPaisID =18,
                                Codigo = "HV",
                                Excluyente = false
                            },
                            CampaniaID = 201801,
                            UrlSeccion = "HerramientaVentas/Index",                            
                            //
                            MobileOrden = 99,
                            MobileImagenFondo = "PE_20171045539_xfwrimsvol_Mobile.png",
                            MobileTitulo = "Titulo Herramienta Venta - Mobile",
                            MobileSubTitulo = "SubTitulo Herramienta Venta - Mobile",
                            MobileTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.Banners,
                            MobileTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                        }
                    };
                }
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasMobileYNoTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                sessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                sessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { });
                var controller = new BaseControllerStub05(sessionManager.Object, logManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                Assert.IsNull(result);
            }
        }
    }
}
