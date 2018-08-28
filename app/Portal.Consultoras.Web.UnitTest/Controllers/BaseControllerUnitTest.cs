using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.UnitTest.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseControllerUnitTest
    {
        [TestClass]
        public class BuildMenuMobile : Base
        {
            class BaseControllerStub01 : BaseController
            {
                public BaseControllerStub01(ISessionManager sessionManager) : base(sessionManager)
                {
                    //_configuracionManagerProvider = new Mock<ConfiguracionManagerProvider>().Object;
                }

                //protected override List<MenuMobileModel> GetMenuMobileModel(int paisID)
                //{
                //    return new List<MenuMobileModel> {
                //        new MenuMobileModel{
                //            Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                //            UrlItem = string.Empty,
                //            UrlImagen=String.Empty,
                //            Descripcion=string.Empty,
                //            Posicion="Menu",
                //            OnClickFunt=string.Empty
                //        }
                //    };
                //}

                //public override string GetUrlImagenMenuOfertas(UsuarioModel userData, RevistaDigitalModel revistaDigital)
                //{
                //    return "UrlImagenMenuOfertasMobile";
                //}
            }

            BaseController _controller;

            public virtual BaseController GetBaseController()
            {
                return new BaseControllerStub01(SessionManager.Object);
            }

            [TestInitialize]
            public override void Test_Initialize()
            {
                base.Test_Initialize();
                _controller = GetBaseController();
            }

            [TestCleanup]
            public override void Test_Cleanup()
            {
                base.Test_Cleanup();
                _controller.Dispose();
            }

            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "Value cannot be null.\r\nParameter name: userData")]
            public void BuildMenuMobile_UserDataEsNulo_LanzaExcepcion()
            {
                var controller = GetBaseController();
                var userData = (UsuarioModel)null;
                var revistaDigital = (RevistaDigitalModel)null;

                controller.BuildMenuMobile(userData, revistaDigital);
            }

            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "Value cannot be null.\r\nParameter name: revistaDigital")]
            public void BuildMenuMobile_RevistaDigitalEsNulo_LanzaExcepcion()
            {
                var controller = GetBaseController();
                var userData = new UsuarioModel { };
                var revistaDigital =  (RevistaDigitalModel)null;

                controller.BuildMenuMobile(userData, revistaDigital);
            }


            [TestMethod]
            public void BuildMenuMobile_UserIsConsultoraMenuOfertaGetsItsImageUrl_UrlImagenIsNotNull()
            {
                SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                var controller = GetBaseController();
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
            //class BaseControllerStub00 : BaseController
            //{
            //    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
            //    {
            //        return new List<PermisoModel> {
            //        };
            //    }
            //}
            //[TestMethod]
            //public void BuildMenu_PropiedadClaseLogoSBInUserDataNoEsNula_ActualizaViewBag()
            //{
            //    var controller = new BaseControllerStub00(/*sessionManager.Object*/);
            //    var userData = new UsuarioModel { ClaseLogoSB = "ClaseLogoSB" };
            //    var revistaDigital = new RevistaDigitalModel { TieneRDC = false };

            //    var menuOferta = controller.BuildMenu(userData, revistaDigital);

            //    Assert.IsNotNull(menuOferta);
            //    Assert.AreEqual(controller.ViewBag.ClaseLogoSB, "ClaseLogoSB");
            //}

            //class BaseControllerStub03 : BaseController
            //{
            //    public BaseControllerStub03(ISessionManager sessionManager) : base(sessionManager)
            //    {

            //    }

            //    protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
            //    {
            //        return new List<PermisoModel> {
            //            new PermisoModel
            //            {
            //                PermisoID=1,
            //                Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
            //                UrlItem = string.Empty,
            //                DescripcionFormateada=string.Empty,
            //                Posicion=string.Empty
            //            }
            //        };
            //    }

            //    public override string GetUrlImagenMenuOfertas(UsuarioModel userData, RevistaDigitalModel revistaDigital)
            //    {
            //        return "url-imagen-menu-oferta.gif";
            //    }
            //}
            [TestMethod]
            public void BuildMenu_TienePermisoContenedorOfertasYUrlImagenMenuOfertasNoEsNula_MenuOfertasEsSoloImagenTrueYDevuelreUrl()
            {
                //sessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                //var controller = new BaseControllerStub03(sessionManager.Object);
                //var userData = new UsuarioModel { };
                //var revistaDigital = new RevistaDigitalModel{};

                //var result = controller.BuildMenu(userData, revistaDigital).First();

                //Assert.AreEqual(true, result.EsSoloImagen);
                //Assert.IsNotNull(result.UrlImagen);
            }

            [TestMethod]
            public void BuildMenu_MenuContenedorExisteEnSesion_DevuelveMenuContenedorDesdeSesion()
            {
                SessionManager
                    .Setup(x => x.GetMenuContenedor())
                    .Returns(new List<ConfiguracionPaisModel>
                    {
                        new ConfiguracionPaisModel{ },
                        new ConfiguracionPaisModel{ },
                    });
                var userData = new UsuarioModel { };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = false };
                var guiaNegocio = new GuiaNegocioModel { };
                var controller = new BaseController(SessionManager.Object, LogManager.Object);

                //var result = controller.BuildMenuContenedor(userData, revistaDigital, guiaNegocio);

                //Assert.IsNotNull(result);
                //Assert.AreEqual(2, result.Count);
            }



            [TestMethod]
            public void BuildMenu_NoTieneRevistaDigitalTieneConfiguracionPaisInicioDesktop_DevuelveMenuInicioDesktop()
            {
                SessionManager.Setup(x => x.GetMenuContenedor()).Returns(new List<ConfiguracionPaisModel> { });
                SessionManager
                    .Setup(x => x.GetConfiguracionesPaisModel())
                    .Returns(new List<ConfiguracionPaisModel> {
                        new ConfiguracionPaisModel
                        {
                            Codigo = Constantes.ConfiguracionPais.Inicio,
                            Estado = true,
                            TienePerfil = true,
                            DesdeCampania= 201714,
                            DesktopFondoBanner = "fondo-inicio.png",
                            DesktopLogoBanner = "logo-inicio.png",
                            DesktopTituloBanner = "#Nombre, Todas tus ofertas en un solo lugar.",
                            DesktopSubTituloBanner = "Subtitulo banne inicio",
                            DesktopTituloMenu = "|Inicio",
                            UrlMenu = "Ofertas",
                            Orden = 0
                        }
                    });
                var userData = new UsuarioModel { CampaniaID = 201804, Sobrenombre= "vvilelaj" };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = false };
                var guiaNegocio = new GuiaNegocioModel { };
                var controller = new BaseController(SessionManager.Object,LogManager.Object);

                //var result = controller.BuildMenuContenedor(userData, revistaDigital, guiaNegocio).First();

                //Assert.IsNotNull(result);
                //Assert.AreEqual(Constantes.ConfiguracionPais.Inicio, result.Codigo);
                //Assert.AreEqual(201804, result.CampaniaId);
                //Assert.AreEqual("fondo-inicio.png", result.DesktopFondoBanner);
                //Assert.AreEqual("logo-inicio.png", result.DesktopLogoBanner);
                //Assert.AreEqual("vvilelaj, Todas tus ofertas en un solo lugar.", result.DesktopTituloBanner);
                //Assert.AreEqual("Subtitulo banne inicio", result.DesktopSubTituloBanner);
                //Assert.AreEqual("", result.DesktopTituloMenu);
                //Assert.AreEqual("Inicio", result.DesktopSubTituloMenu);
                //Assert.AreEqual("Ofertas", result.UrlMenu);
                //Assert.AreEqual(false, result.EsAncla);
            }

            [TestMethod]
            public void BuildMenu_NoTieneRevistaDigitalTieneConfiguracionPaisShowRoomDesktop_DevuelveMenuShowRoomDesktop()
            {
                SessionManager.Setup(x => x.GetMenuContenedor()).Returns(new List<ConfiguracionPaisModel> { });
                SessionManager
                    .Setup(x => x.GetConfiguracionesPaisModel())
                    .Returns(new List<ConfiguracionPaisModel> {
                        new ConfiguracionPaisModel
                        {
                            Codigo = Constantes.ConfiguracionPais.ShowRoom,
                            Estado = true,
                            TienePerfil = true,
                            DesdeCampania= 201714,
                            DesktopFondoBanner = "fondo-sr.png",
                            DesktopLogoBanner = "logo-sr.png",
                            DesktopTituloBanner = "#Nombre, APROVECHA ESTAS OFERTAS DISEÑADAS SOLO PARA TI.",
                            DesktopSubTituloBanner = "Suma al monto mínimo del pedido, suma la escala de comisión, otorga puntaje. No comisiona. Precio neto consultora.",
                            DesktopTituloMenu = "Especial|Día de la Mujer",
                            UrlMenu = "ShowRoom",
                            Orden = 1
                        }
                    });
                SessionManager.Setup(x => x.GetEsShowRoom()).Returns(true);
                var userData = new UsuarioModel { CampaniaID = 201804, Sobrenombre = "vvilelaj" };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = false };
                var guiaNegocio = new GuiaNegocioModel { };
                var controller = new BaseController(SessionManager.Object, LogManager.Object);

                //var result = controller.BuildMenuContenedor(userData, revistaDigital, guiaNegocio).First();

                //Assert.IsNotNull(result);
                //Assert.AreEqual(Constantes.ConfiguracionPais.ShowRoom, result.Codigo);
                //Assert.AreEqual(201804, result.CampaniaId);
                //Assert.AreEqual("fondo-sr.png", result.DesktopFondoBanner);
                //Assert.AreEqual("logo-sr.png", result.DesktopLogoBanner);
                //Assert.AreEqual("vvilelaj, APROVECHA ESTAS OFERTAS DISEÑADAS SOLO PARA TI.", result.DesktopTituloBanner);
                //Assert.AreEqual("Suma al monto mínimo del pedido, suma la escala de comisión, otorga puntaje. No comisiona. Precio neto consultora.", result.DesktopSubTituloBanner);
                //Assert.AreEqual("Especial", result.DesktopTituloMenu);
                //Assert.AreEqual("Día de la Mujer", result.DesktopSubTituloMenu);
                //Assert.AreEqual("ShowRoom/Intriga", result.UrlMenu);
                //Assert.AreEqual(false, result.EsAncla);
            }

            [TestMethod]
            public void BuildMenu_NoTieneRevistaDigitalTieneConfiguracionPaisGuiaNegocioDesktop_DevuelveMenuGuiaNegocioDesktop()
            {
                SessionManager.Setup(x => x.GetMenuContenedor()).Returns(new List<ConfiguracionPaisModel> { });
                SessionManager
                    .Setup(x => x.GetConfiguracionesPaisModel())
                    .Returns(new List<ConfiguracionPaisModel> {
                        new ConfiguracionPaisModel
                        {
                            Codigo = Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada,
                            Estado = true,
                            TienePerfil = true,
                            DesdeCampania= 201714,
                            DesktopFondoBanner = "fondo-gnd.png",
                            DesktopLogoBanner = "logo-gnd.png",
                            DesktopTituloBanner = "#Nombre, disfruta de tu guía de negocio online",
                            DesktopSubTituloBanner = "Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.",
                            DesktopTituloMenu = "EXPLORA|GUÍA DE NEGOCIO",
                            Orden = 1
                        }
                    });
                var userData = new UsuarioModel { CampaniaID = 201804, Sobrenombre = "vvilelaj" };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = false };
                var guiaNegocio = new GuiaNegocioModel { TieneGND=true };
                var controller = new BaseController(SessionManager.Object, LogManager.Object);

                //var result = controller.BuildMenuContenedor(userData, revistaDigital, guiaNegocio).First();

                //Assert.IsNotNull(result);
                //Assert.AreEqual(Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada, result.Codigo);
                //Assert.AreEqual(201804, result.CampaniaId);
                //Assert.AreEqual("fondo-gnd.png", result.DesktopFondoBanner);
                //Assert.AreEqual("logo-gnd.png", result.DesktopLogoBanner);
                //Assert.AreEqual("vvilelaj, disfruta de tu guía de negocio online", result.DesktopTituloBanner);
                //Assert.AreEqual("Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.", result.DesktopSubTituloBanner);
                //Assert.AreEqual("EXPLORA", result.DesktopTituloMenu);
                //Assert.AreEqual("GUÍA DE NEGOCIO", result.DesktopSubTituloMenu);
                //Assert.AreEqual("GuiaNegocio", result.UrlMenu);
                //Assert.AreEqual(false, result.EsAncla);
            }

            [TestMethod]
            public void BuildMenu_NoTieneRevistaDigitalTieneConfiguracionPaisHerramientasVentaDesktop_DevuelveMenuHerramientasVentaDesktop()
            {
                SessionManager.Setup(x => x.GetMenuContenedor()).Returns(new List<ConfiguracionPaisModel> { });
                SessionManager
                    .Setup(x => x.GetConfiguracionesPaisModel())
                    .Returns(new List<ConfiguracionPaisModel> {
                        new ConfiguracionPaisModel
                        {
                            Codigo = Constantes.ConfiguracionPais.HerramientasVenta,
                            Estado = true,
                            TienePerfil = true,
                            DesdeCampania= 201714,
                            DesktopFondoBanner = "fondo-hv.png",
                            DesktopLogoBanner = "logo-hv.png",
                            DesktopTituloBanner = "Utiliza demostradores y herramientas de venta",
                            DesktopSubTituloBanner = "",
                            DesktopTituloMenu = "Demostradores y|herramientas",
                            UrlMenu = "#",
                            Orden = 1
                        }
                    });
                var userData = new UsuarioModel { CampaniaID = 201804, Sobrenombre = "vvilelaj" };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = false };
                var guiaNegocio = new GuiaNegocioModel { };
                var controller = new BaseController(SessionManager.Object, LogManager.Object);

                //var result = controller.BuildMenuContenedor(userData, revistaDigital, guiaNegocio).First();

                //Assert.IsNotNull(result);
                //Assert.AreEqual(Constantes.ConfiguracionPais.HerramientasVenta, result.Codigo);
                //Assert.AreEqual(201804, result.CampaniaId);
                //Assert.AreEqual("fondo-hv.png", result.DesktopFondoBanner);
                //Assert.AreEqual("logo-hv.png", result.DesktopLogoBanner);
                //Assert.AreEqual("Utiliza demostradores y herramientas de venta", result.DesktopTituloBanner);
                //Assert.AreEqual("", result.DesktopSubTituloBanner);
                //Assert.AreEqual("Demostradores y", result.DesktopTituloMenu);
                //Assert.AreEqual("herramientas", result.DesktopSubTituloMenu);
                //Assert.AreEqual("HerramientasVenta/Comprar", result.UrlMenu);
                //Assert.AreEqual(false, result.EsAncla);
            }



            [TestMethod]
            public void BuildMenu_TieneInicioDesktopTieneRevistaDigitalDesktopTieneInicioRdDesktop_DevuelveInicioRdDesktopYRevistaDigitalDesktop()
            {
                SessionManager.Setup(x => x.GetMenuContenedor()).Returns(new List<ConfiguracionPaisModel> { });
                SessionManager
                    .Setup(x => x.GetConfiguracionesPaisModel())
                    .Returns(new List<ConfiguracionPaisModel> {
                        new ConfiguracionPaisModel
                        {
                            Codigo = Constantes.ConfiguracionPais.Inicio,
                            Estado = true,
                            TienePerfil = true,
                            DesdeCampania= 201714,
                            DesktopFondoBanner = "fondo-inicio.png",
                            DesktopLogoBanner = "logo-inicio.png",
                            DesktopTituloBanner = "#Nombre, título banner inicio",
                            DesktopSubTituloBanner = "Sub título banner inicio",
                            DesktopTituloMenu = "Título Menu Inicio|Sub Título Menu Inicio",
                            UrlMenu = "UrlInicio",
                            OrdenBpt = 0
                        },
                        new ConfiguracionPaisModel
                        {
                            Codigo = Constantes.ConfiguracionPais.RevistaDigital,
                            Estado = true,
                            TienePerfil = true,
                            DesdeCampania= 201714,
                            DesktopFondoBanner = "fondo-rd.png",
                            DesktopLogoBanner = "logo-rd.png",
                            DesktopTituloBanner = "#Nombre, título banner rd",
                            DesktopSubTituloBanner = "Sub título banner rd",
                            DesktopTituloMenu = "Título Menu RD|Sub Título Menu RD",
                            UrlMenu = "UrlRevistaDigital",
                            OrdenBpt = 1
                        },
                        new ConfiguracionPaisModel
                        {
                            Codigo = Constantes.ConfiguracionPais.InicioRD,
                            Estado = true,
                            TienePerfil = true,
                            DesdeCampania= 201714,
                            DesktopFondoBanner = "fondo-inicio-rd.png",
                            DesktopLogoBanner = "logo-inicio-rd.png",
                            DesktopTituloBanner = "#Nombre, título banner inicio rd",
                            DesktopSubTituloBanner = "Sub título banner inicio rd",
                            DesktopTituloMenu = "Título Menu Inicio RD|Sub Título Menu Inicio RD",
                            UrlMenu = "UrlInicioRevistaDigital",
                            OrdenBpt = 0
                        }
                    });
                var userData = new UsuarioModel { CampaniaID = 201804, Sobrenombre = "vvilelaj" };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = true };
                var guiaNegocio = new GuiaNegocioModel { };
                var controller = new BaseController(SessionManager.Object, LogManager.Object);

                //var result = controller
                //    .BuildMenuContenedor(userData, revistaDigital, guiaNegocio)
                //    .Where(x => x.CampaniaId == userData.CampaniaID)
                //    .ToList();

                //Assert.IsNotNull(result);
                //Assert.AreEqual(2,result.Count);
                //Assert.AreEqual(Constantes.ConfiguracionPais.InicioRD, result.First().Codigo);
                //Assert.AreEqual(Constantes.ConfiguracionPais.RevistaDigital, result.Last().Codigo);
            }

            [TestMethod]
            public void BuildMenu_TieneRevistaDigitalDesktopEsNoSuscritaEsNoActiva_DevuelveMenuInicioRdNoSuscrita()
            {
                Assert.Inconclusive();
            }

            [TestMethod]
            public void BuildMenu_TieneRevistaDigitalTieneConfiguracionPaisGuiaNegocioDesktop_DevuelveMenuGuiaNegocioDesktop()
            {
                Assert.Inconclusive();
            }

            [TestMethod]
            public void BuildMenu_TieneRevistaDigitalTieneConfiguracionPaisHerramientasVentaDesktop_DevuelveMenuHerramientasVentaDesktop()
            {
                Assert.Inconclusive();
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
                    //protected override string GetDefaultGifMenuOfertas()
                    //{
                    //    return "gif-por-defecto.gif";
                    //}
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraNoEsikaParaMiSinEventoFestivo_TieneGifPorDefecto()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub01(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel {
                        TieneRDC = false,
                        TieneRDI = false,
                    };

                    //var url = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(url);
                    //Assert.IsTrue(url.Contains("gif-por-defecto.gif"));
                }



                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaNoActivaSinEventoFestivo_TieneGifGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDI = false,
                        EsSuscrita = false,
                        EsActiva = false,
                        LogoMenuOfertasNoActiva = "gana-mas.gif"
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.AreEqual("gana-mas.gif", result);
                }

                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaActivaSinEventoFestivo_TieneGifGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDI = false,
                        EsSuscrita = false,
                        EsActiva = true,
                        LogoMenuOfertasNoActiva = "gana-mas.gif"
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.AreEqual("gana-mas.gif", result);
                }

                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaNoActivaSinEventoFestivo_TieneGifClubGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        EsSuscrita = true,
                        EsActiva = false,
                        LogoMenuOfertasActiva = "club-gana-mas.gif"
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("club-gana-mas.gif"));
                }

                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaActivaSinEventoFestivo_TieneGifClubGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        EsSuscrita = true,
                        EsActiva = true,
                        LogoMenuOfertasActiva = "club-gana-mas.gif"
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("club-gana-mas.gif"));
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
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns((EventoFestivoDataModel)null);
                    var controller = new BaseControllerStub06(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = false,
                        TieneRDI = true,
                        LogoMenuOfertasNoActiva = "gana-mas.gif"
                    };

                    //var menuOferta = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(menuOferta);
                    //Assert.IsTrue(menuOferta.Contains("gana-mas.gif"));
                }
            }

            [TestClass]
            public class ConEventoFestivo : Base
            {
                
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraNoEsikaParaMiConEventoFestivo_DevuelveGifEventoFestivo()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS,
                            Personalizacion = "evento-festivo-ofertas-no-epm.gif"
                        }
                    }
                    });
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel { TieneRDC = false, TieneRDI = false };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("evento-festivo-ofertas-no-epm.gif"));
                }



                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaNoActivaConEventoFestivo_TieneGifEventoFestivoGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDI = false,
                        EsSuscrita = false,
                        EsActiva = false
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("evento-festivo-ofertas-gana-mas.gif"));
                }

                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiNoSuscritaActivaConEventoFestivo_TieneGifEventoFestivoGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDI = false,
                        EsSuscrita = false,
                        EsActiva = true
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("evento-festivo-ofertas-gana-mas.gif"));
                }

                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaNoActivaConEventoFestivo_TieneGifEventoFestivoClubGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-club-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        TieneRDI = false,
                        EsSuscrita = true,
                        EsActiva = false
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("evento-festivo-ofertas-club-gana-mas.gif"));
                }

                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiSuscritaActivaConEventoFestivo_TieneGifEventoFestivoClubGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_CLUB_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-club-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseController(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel
                    {
                        TieneRDC = true,
                        EsSuscrita = true,
                        EsActiva = true,
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("evento-festivo-ofertas-club-gana-mas.gif"));
                }



                class BaseControllerStub11 : BaseController
                {
                    public BaseControllerStub11(ISessionManager sessionManager) : base(sessionManager)
                    {

                    }

                    //protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                    //{
                    //    return new List<PermisoModel> {
                    //    new PermisoModel
                    //    {
                    //        PermisoID=1,
                    //        Codigo =  Constantes.MenuCodigo.ContenedorOfertas.ToLower(),
                    //        UrlItem = string.Empty,
                    //        DescripcionFormateada=string.Empty,
                    //        Posicion=string.Empty
                    //    }
                    //};
                    //}
                }
                [TestMethod]
                public void GetUrlImagenMenuOfertas_ConsultoraEsikaParaMiIntrigaConEventoFestivo_DevuelveGifEventoFestivoGanaMas()
                {
                    SessionManager.Setup(x => x.GetEventoFestivoDataModel()).Returns(new EventoFestivoDataModel
                    {
                        ListaGifMenuContenedorOfertas = new List<EventoFestivoModel> {
                        new EventoFestivoModel{
                            Nombre=Constantes.EventoFestivoNombre.GIF_MENU_OFERTAS_BPT_GANA_MAS,
                            Personalizacion = "evento-festivo-ofertas-gana-mas.gif"
                        }
                    }
                    });
                    var controller = new BaseControllerStub11(SessionManager.Object);
                    var userData = new UsuarioModel { };
                    var revistaDigital = new RevistaDigitalModel {
                        TieneRDC = false,
                        TieneRDI = true
                    };

                    //var result = controller.GetUrlImagenMenuOfertas(userData, revistaDigital);

                    //Assert.IsNotNull(result);
                    //Assert.IsTrue(result.Contains("evento-festivo-ofertas-gana-mas.gif"));
                }
            }
        }

        [TestClass]
        public class ObtenerConfiguracionSeccion : Base
        {
            [TestMethod]
            public void ObtenerConfiguracionSeccion_RevistaDigitalEsNulo_EscribeEnLogYDevuelveListaVacia()
            {
                SessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                var controller = new BaseController(SessionManager.Object,LogManager.Object);
                RevistaDigitalModel revistaDigital = null;

                //var result = controller.ObtenerConfiguracionSeccion(revistaDigital);

                //Assert.IsNotNull(result);
                //Assert.AreEqual(0, result.Count);
                LogManager.Verify(x => x.LogErrorWebServicesBusWrap(
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

                //public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                //{
                //    return new List<BEConfiguracionOfertasHome>
                //    {
                //        new BEConfiguracionOfertasHome
                //        {
                //            ConfiguracionPaisID=0,
                //            ConfiguracionPais = new BEConfiguracionPais
                //            {
                //                ConfiguracionPaisID =0,
                //                Codigo = "",
                //                Excluyente = false
                //            },                            
                //        }
                //    };
                //}
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeccionNoPerteneceANingunaConfiguracionPais_NoSeDevuelve()
            {
                SessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                var controller = new BaseControllerStub01(SessionManager.Object, LogManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                //var result = controller.ObtenerConfiguracionSeccion(revistaDigital);

                //Assert.IsNotNull(result);
                //Assert.AreEqual(0, result.Count);
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

                //public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                //{
                //    return new List<BEConfiguracionOfertasHome>
                //    {
                //        new BEConfiguracionOfertasHome
                //        {
                //            ConfiguracionPaisID=18,
                //            ConfiguracionPais = new BEConfiguracionPais
                //            {
                //                ConfiguracionPaisID =18,
                //                Codigo = "HV",
                //                Excluyente = false
                //            },
                //            CampaniaID = 201801,
                //            UrlSeccion = "HerramientasVenta/Index",
                //            //
                //            DesktopOrden = 9,
                //            DesktopImagenFondo = "PE_20171045539_xfwrimsvol_Desktop.png",
                //            DesktopTitulo = "Titulo Herramienta Venta - Desktop",
                //            DesktopSubTitulo = "SubTitulo Herramienta Venta - Desktop",
                //            DesktopTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado,
                //            DesktopTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                //            DesktopCantidadProductos = 3
                //        }
                //    };
                //}
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasDesktopYNoTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                SessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                SessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { });
                var controller = new BaseControllerStub02(SessionManager.Object, LogManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                //var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                //Assert.IsNull(result);
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

                //public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                //{
                //    return new List<BEConfiguracionOfertasHome>
                //    {
                //        new BEConfiguracionOfertasHome
                //        {
                //            ConfiguracionPaisID=18,
                //            ConfiguracionPais = new BEConfiguracionPais
                //            {
                //                ConfiguracionPaisID =18,
                //                Codigo = "HV",
                //                Excluyente = false
                //            },
                //            CampaniaID = 201801,
                //            UrlSeccion = "HerramientasVenta/Index",
                //            //
                //            DesktopOrden = 9,
                //            DesktopImagenFondo = "PE_20171045539_xfwrimsvol_Desktop.png",
                //            DesktopTitulo = "Titulo Herramienta Venta - Desktop",
                //            DesktopSubTitulo = "SubTitulo Herramienta Venta - Desktop",
                //            DesktopTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado,
                //            DesktopTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                //            DesktopCantidadProductos = 3                            
                //        }
                //    };
                //}
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasDesktopYTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                SessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                SessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { new ConfiguracionPaisModel { ConfiguracionPaisID =18, Codigo = "HV" } });
                var controller = new BaseControllerStub03(SessionManager.Object, LogManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                //var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                //Assert.IsNotNull(result);
                //Assert.AreEqual("HV", result.Codigo);
                //Assert.AreEqual(9, result.Orden);
                //Assert.AreEqual("PE_20171045539_xfwrimsvol_Desktop.png", result.ImagenFondo);
                //Assert.AreEqual("Titulo Herramienta Venta - Desktop", result.Titulo);
                //Assert.AreEqual("SubTitulo Herramienta Venta - Desktop", result.SubTitulo);
                //Assert.AreEqual(Constantes.ConfiguracionSeccion.TipoPresentacion.SimpleCentrado, result.TipoPresentacion);
                //Assert.AreEqual(Constantes.TipoEstrategiaCodigo.HerramientasVenta, result.TipoEstrategia);
                //Assert.AreEqual(3, result.CantidadMostrar);
                //Assert.AreEqual("/HerramientasVenta/Comprar", result.UrlLandig);
                //Assert.AreEqual(true, result.VerMas);
                ////
                //Assert.AreEqual("Estrategia/HVObtenerProductos", result.UrlObtenerProductos);
                //Assert.AreEqual(Constantes.OrigenPedidoWeb.HVDesktopContenedor, result.OrigenPedido);
                ////
                //Assert.AreEqual("seccion-simple-centrado", result.TemplatePresentacion);
                //Assert.AreEqual("#producto-landing-template", result.TemplateProducto);
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

                //public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                //{
                //    return new List<BEConfiguracionOfertasHome>
                //    {
                //        new BEConfiguracionOfertasHome
                //        {
                //            ConfiguracionPaisID=18,
                //            ConfiguracionPais = new BEConfiguracionPais
                //            {
                //                ConfiguracionPaisID =18,
                //                Codigo = "HV",
                //                Excluyente = false
                //            },
                //            CampaniaID = 201801,
                //            UrlSeccion = "HerramientaVentas/Index",                            
                //            //
                //            MobileOrden = 99,
                //            MobileImagenFondo = "PE_20171045539_xfwrimsvol_Mobile.png",
                //            MobileTitulo = "Titulo Herramienta Venta - Mobile",
                //            MobileSubTitulo = "SubTitulo Herramienta Venta - Mobile",
                //            MobileTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.Banners,
                //            MobileTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                //        }
                //    };
                //}
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasMobileYTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                SessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                SessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { new ConfiguracionPaisModel { ConfiguracionPaisID = 18, Codigo = "HV" } });
                var controller = new BaseControllerStub04(SessionManager.Object, LogManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                //var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                //Assert.IsNotNull(result);
                //Assert.AreEqual("HV", result.Codigo);
                //Assert.AreEqual(99, result.Orden);
                //Assert.AreEqual("PE_20171045539_xfwrimsvol_Mobile.png", result.ImagenFondo);
                //Assert.AreEqual("Titulo Herramienta Venta - Mobile", result.Titulo);
                //Assert.AreEqual("SubTitulo Herramienta Venta - Mobile", result.SubTitulo);
                //Assert.AreEqual(Constantes.ConfiguracionSeccion.TipoPresentacion.Banners, result.TipoPresentacion);
                //Assert.AreEqual(Constantes.TipoEstrategiaCodigo.HerramientasVenta, result.TipoEstrategia);
                //Assert.AreEqual(0, result.CantidadMostrar);
                //Assert.AreEqual("/Mobile/HerramientasVenta/Comprar", result.UrlLandig);
                //Assert.AreEqual(true, result.VerMas);
                ////
                ////Assert.AreEqual(true, string.IsNullOrEmpty(result.UrlObtenerProductos));
                //Assert.AreEqual(0, result.OrigenPedido);
                ////
                //Assert.AreEqual("seccion-banner", result.TemplatePresentacion);
                //Assert.AreEqual("", result.TemplateProducto);
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

                //public override List<BEConfiguracionOfertasHome> GetConfiguracionOfertasHome(int paidId, int campaniaId)
                //{
                //    return new List<BEConfiguracionOfertasHome>
                //    {
                //        new BEConfiguracionOfertasHome
                //        {
                //            ConfiguracionPaisID=18,
                //            ConfiguracionPais = new BEConfiguracionPais
                //            {
                //                ConfiguracionPaisID =18,
                //                Codigo = "HV",
                //                Excluyente = false
                //            },
                //            CampaniaID = 201801,
                //            UrlSeccion = "HerramientaVentas/Index",                            
                //            //
                //            MobileOrden = 99,
                //            MobileImagenFondo = "PE_20171045539_xfwrimsvol_Mobile.png",
                //            MobileTitulo = "Titulo Herramienta Venta - Mobile",
                //            MobileSubTitulo = "SubTitulo Herramienta Venta - Mobile",
                //            MobileTipoPresentacion = Constantes.ConfiguracionSeccion.TipoPresentacion.Banners,
                //            MobileTipoEstrategia = Constantes.TipoEstrategiaCodigo.HerramientasVenta,
                //        }
                //    };
                //}
            }
            [TestMethod]
            public void ObtenerConfiguracionSeccion_SeObtieneSeccionHerramientaVentasMobileYNoTieneConfiguracionPaisHV_SeDevuelveSeccionConfigurada()
            {
                SessionManager.Setup(x => x.GetMenuContenedorActivo()).Returns(new MenuContenedorModel { });
                SessionManager.Setup(x => x.GetConfiguracionesPaisModel()).Returns(new List<ConfiguracionPaisModel> { });
                var controller = new BaseControllerStub05(SessionManager.Object, LogManager.Object);
                var revistaDigital = new RevistaDigitalModel { };

                //var result = controller.ObtenerConfiguracionSeccion(revistaDigital).FirstOrDefault();

                //Assert.IsNull(result);
            }
        }

        [TestClass]
        public class GNDValidarAcceso : Base
        {
            [TestMethod]
            public void EsConsultoraYNoTieneGuiaNegocioYNoTieneRevistaDigital_RetornaFalso()
            {
                var esSociaEmpresaria = false;
                var guiaNegocio = new GuiaNegocioModel { };
                var revistaDigital = new RevistaDigitalModel { };
                var controller = new GuiaNegocioProvider();


                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsConsultoraYTieneGuiaNegocioYNoTieneRevistaDigital_RetornaVerdadero()
            {
                var esSociaEmpresaria = false;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = false };
                var controller = new GuiaNegocioProvider();


                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(true, result);
            }

            [DataRow(true, DisplayName = "Suscrita, NoActiva")]
            [DataRow(false, DisplayName = "No Suscrita, NoActiva")]
            [DataTestMethod]
            public void EsConsultoraYTieneGuiaNegocioYEsNoActiva_RetornaVerdadero(bool esSuscrita)
            {
                var esSociaEmpresaria = false;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = true, EsSuscrita = esSuscrita, EsActiva = false };
                var controller = new GuiaNegocioProvider();

                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(true, result);
            }

            [DataRow(true, DisplayName = "Suscrita, Activa")]
            [DataRow(false, DisplayName = "No Suscrita, Activa")]
            [DataTestMethod]
            public void EsConsultoraYTieneGuiaNegocioYEsActiva_RetornaFalso(bool esSuscrita)
            {
                var esSociaEmpresaria = false;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel { TieneRDC = true, EsSuscrita = esSuscrita, EsActiva = true };
                var controller = new GuiaNegocioProvider();

                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(false, result);
            }



            [TestMethod]
            public void EsSociaEmpresariaYNoTieneGuiaNegocioYNoTieneRevistaDigital_RetornaFalso()
            {
                var esSociaEmpresaria = true;
                var guiaNegocio = new GuiaNegocioModel { };
                var revistaDigital = new RevistaDigitalModel { };
                var controller = new GuiaNegocioProvider();

                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSociaEmpresariaYTieneGuiaNegocioYNoTieneRevistaDigital_RetornaVerdadero()
            {
                var esSociaEmpresaria = true;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel { };
                var controller = new GuiaNegocioProvider();


                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(true, result);
            }

            [DataRow(true, DisplayName = "Suscrita, NoActiva")]
            [DataRow(false, DisplayName = "No Suscrita, NoActiva")]
            [DataTestMethod]
            public void EsSociaYTieneGuiaNegocioYEsNoActiva_RetornaVerdadero(bool esSuscrita)
            {
                var esSociaEmpresaria = true;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsSuscrita = esSuscrita,
                    EsActiva = false
                };
                var controller = new GuiaNegocioProvider();

                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(true, result);
            }

            [DataRow(true, DisplayName = "Suscrita, Activa")]
            [DataRow(false, DisplayName = "No Suscrita, Activa")]
            [DataTestMethod]
            public void EsSociaYTieneGuiaNegocioYEsActivaYNoTieneExpSocEmpresaria_RetornaFalso(bool esSuscrita)
            {
                var esSociaEmpresaria = true;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsSuscrita = esSuscrita,
                    EsActiva = true,
                    //
                    SociaEmpresariaExperienciaGanaMas = false
                };
                var controller = new GuiaNegocioProvider();

                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSociaYTieneGuiaNegocioYEsNoSuscritaYEsActivaYTieneExpSocEmpresaria_RetornaFalso()
            {
                var esSociaEmpresaria = true;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsSuscrita = false,
                    EsActiva = true,
                    //
                    SociaEmpresariaExperienciaGanaMas = true
                };
                var controller = new GuiaNegocioProvider();

                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(false, result);
            }

            [TestMethod]
            public void EsSociaYTieneGuiaNegocioYEsSuscritaYEsActivaYTieneExpSocEmpresaria_RetornaVerdadero()
            {
                var esSociaEmpresaria = true;
                var guiaNegocio = new GuiaNegocioModel { TieneGND = true };
                var revistaDigital = new RevistaDigitalModel
                {
                    TieneRDC = true,
                    EsSuscrita = true,
                    EsActiva = true,
                    //
                    SociaEmpresariaExperienciaGanaMas = true
                };
                var controller = new GuiaNegocioProvider();

                var result = controller.GNDValidarAcceso(esSociaEmpresaria, guiaNegocio, revistaDigital);

                Assert.AreEqual(true, result);
            }
        }
    }
}
