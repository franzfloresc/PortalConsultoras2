﻿using Microsoft.VisualStudio.TestTools.UnitTesting;
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

namespace Portal.Consultoras.Web.UnitTest.Controllers
{
    [TestClass]
    public class BaseControllerUnitTest
    {
        [TestClass]
        public class Base
        {
            protected Mock<ISessionManager> sessionManager;

            [TestInitialize]
            public void Test_Initialize()
            {
                sessionManager = new Mock<ISessionManager>();

            }

            [TestCleanup]
            public void Test_Cleanup()
            {
                sessionManager = null;
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
            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "Value cannot be null.\r\nParameter name: userData")]
            public void BuildMenu_UserDataEsNulo_LanzaExcepcion()
            {
                var controller = new BaseController();

                controller.BuildMenu(null,null);
            }

            [TestMethod]
            [ExpectedExceptionWithMessage(typeof(ArgumentNullException), "Value cannot be null.\r\nParameter name: revistaDigital")]
            public void BuildMenu_RevistaDigitalEsNulo_LanzaExcepcion()
            {
                var controller = new BaseController();

                controller.BuildMenu(new UsuarioModel(), null);
            }

            class BaseControllerStub00 : BaseController
            {
                protected override IList<PermisoModel> GetPermisosByRol(int paisID, int rolID)
                {
                    return new List<PermisoModel> {
                    };
                }
            }
            [TestMethod]
            public void BuildMenu_PropertyClaseLogoSBInUserDataIsNotNull_SetValueInViewBag()
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
            public void BuildMenu_TienePermisoContenedorOfertasGetUrl_MenuOfertasEsSoloImagenTrueYDevuelreUrl()
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
        public class GetUrlImagenMenuOfertas : Base
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
        }

        //[TestClass]
        //public class ObtenerPedidoWeb : Base
        //{
        //    [TestMethod]
        //    public void ObtenerPedidoWeb_WhenIsInvoke_ReturnsANotNullEntity()
        //    {
        //        var controller = new BaseController(sessionManager.Object);

        //        var pedido = controller.ObtenerPedidoWeb();

        //        Assert.IsNotNull(pedido);
        //    }
        //}

        //[TestClass]
        //public class ObtenerPedidoWebDetalle : Base
        //{
        //    [TestMethod]
        //    public void ObtenerPedidoWebDetalle_WhenIsInvoke_AlwaysReturnANotNullList()
        //    {
        //        var controller = new BaseController(sessionManager.Object);

        //        var detallesPedidoWeb = controller.ObtenerPedidoWebDetalle();

        //        Assert.IsNotNull(detallesPedidoWeb);
        //    }
        //}

    }
}
