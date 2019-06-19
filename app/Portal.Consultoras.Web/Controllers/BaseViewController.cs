using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.OrigenPedidoWeb;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.DetalleEstrategia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseViewController : BaseController
    {
        private readonly IssuuProvider _issuuProvider;
        private readonly CaminoBrillanteProvider _caminoBrillanteProvider;

        public BaseViewController() : base()
        {
            _issuuProvider = new IssuuProvider();
            _caminoBrillanteProvider = new CaminoBrillanteProvider();
        }

        public BaseViewController(ISessionManager sesionManager)
            : base(sesionManager)
        {

        }

        public BaseViewController(ISessionManager sesionManager, ILogManager logManager)
            : base(sesionManager, logManager)
        {

        }

        public BaseViewController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider, OfertaViewProvider ofertaViewProvider)
            : base(sesionManager, logManager, ofertaPersonalizadaProvider, ofertaViewProvider)
        {
        }

        public BaseViewController(ISessionManager sesionManager, ILogManager logManager, EstrategiaComponenteProvider estrategiaComponenteProvider)
            : base(sesionManager, logManager, estrategiaComponenteProvider)
        {
        }

        #region RevistaDigital

        public ActionResult RDIndexModel()
        {


            if (revistaDigital.TieneRDI)
                return View("template-informativa-rdi");

            var esMobile = IsMobile();
            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDS)
                return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });

            var modelo = _revistaDigitalProvider.InformativoModel(IsMobile());
            return View("template-informativa", modelo);
        }

        public ActionResult RDViewLanding(int tipo)
        {
            var model = GetLandingModel(tipo);

            return PartialView("template-landing", model);
        }

        protected RevistaDigitalLandingModel GetLandingModel(int tipo, string TipoPalanca = "")
        {
            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile()),
                CantidadFilas = 30
            };

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(model.CampaniaID, IsMobile());
            model.ProductosPerdio = dato.Estado;
            model.PerdioTitulo = dato.Valor1;
            model.PerdioSubTitulo = dato.Valor2;

            model.PerdioLogo = revistaDigital.DLogoComercialActiva;

            switch (TipoPalanca)
            {
                case Constantes.ConfiguracionPais.ProgramaNuevas:
                    model.MostrarFiltros = true;
                    break;
                default:
                    model.MostrarFiltros = !model.ProductosPerdio && !(revistaDigital.TieneRDC && !revistaDigital.EsActiva);
                    break;
            }

            return model;
        }

        public ActionResult RDDetalleModel(string cuv, int campaniaId)
        {
            var modelo = SessionManager.GetProductoTemporal();
            if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            if (!revistaDigital.TieneRevistaDigital())
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            if (_ofertaPersonalizadaProvider.EsCampaniaFalsa(modelo.CampaniaID))
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (modelo.EstrategiaID <= 0)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
            modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();

            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(modelo.CampaniaID, IsMobile());
            ViewBag.TieneProductosPerdio = dato.Estado;
            ViewBag.PerdioTitulo = dato.Valor1;
            ViewBag.PerdioSubTitulo = dato.Valor2;

            ViewBag.Campania = campaniaId;
            return View(modelo);

        }

        #endregion

        #region Guia Negocio

        public virtual ActionResult GNDViewLanding()
        {
            ViewBag.CodigoRevistaActual = _issuuProvider.GetRevistaCodigoIssuu(userData.CampaniaID.ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            ViewBag.CodigoRevistaAnterior = _issuuProvider.GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, -1, userData.NroCampanias).ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            ViewBag.CodigoRevistaSiguiente = _issuuProvider.GetRevistaCodigoIssuu(Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias).ToString(), revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = userData.CampaniaID,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = new MensajeProductoBloqueadoModel(),
                CantidadFilas = 10
            };

            return PartialView("Index", model);
        }

        #endregion

        #region Las mas Ganadoras

        public ActionResult MasGanadorasViewLanding()
        {
            var id = userData.CampaniaID;

            bool esMobile = IsMobile();

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = esMobile,
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.HVMensajeProductoBloqueado(herramientasVenta, esMobile),
                CantidadFilas = 10
            };

            return PartialView("template-landing", model);
        }

        #endregion

        #region Herramienta Venta

        public ActionResult HVViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

            bool esMobile = IsMobile();

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = esMobile,
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.HVMensajeProductoBloqueado(herramientasVenta, esMobile),
                CantidadFilas = 10
            };

            return PartialView("template-landing", model);
        }

        #endregion

        #region ShowRoom

        #endregion

        #region Detalle Estrategia  - Ficha

        public virtual ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            try
            {
                var modelo = new DetalleEstrategiaFichaModel
                {
                    Palanca = palanca,
                    Campania = campaniaId,
                    Cuv = cuv,
                    OrigenUrl = origen
                };
                return View(modelo);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseViewController.Ficha");
            }

            return Redireccionar();
        }

        protected ActionResult Redireccionar()
        {
            string sap = "";
            var url = (Request.Url.Query).Split('?');
            if (url.Length > 1 && url[1].Contains("sap"))
            {
                SessionManager.SetUrlVc(1);
                sap = "&" + url[1].Substring(3);
                if (EsDispositivoMovil())
                {
                    return RedirectToAction("Index", "Ofertas", new { area = "Mobile", sap });
                }
                else
                {
                    return RedirectToAction("Index", "Ofertas", sap);
                }
            }
            return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });

        }

        private DetalleEstrategiaBreadCrumbsModel GetDetalleEstrategiaBreadCrumbs(int campania, string palanca)
        {
            var breadCrumbs = new DetalleEstrategiaBreadCrumbsModel();

            try
            {
                bool tieneRevistaDigital = revistaDigital.TieneRevistaDigital();
                bool productoPerteneceACampaniaActual = userData.CampaniaID == campania;
                var area = IsMobile() ? "mobile" : string.Empty;

                breadCrumbs.Inicio.Texto = MobileAppConfiguracion.EsAppMobile ? null : "Inicio";
                breadCrumbs.Ofertas.Texto = tieneRevistaDigital && revistaDigital.EsSuscrita ? "Gana +" : "Ofertas Digitales";
                breadCrumbs.Palanca.Texto = GetNombresPalancas(palanca);

                breadCrumbs.Inicio.Url = Url.Action("Index", new { controller = "Bienvenida", area });

                var actionOfertas = productoPerteneceACampaniaActual ? "Index" : "Revisar";
                breadCrumbs.Ofertas.Url = Url.Action(actionOfertas, new { controller = "Ofertas", area });

                if (palanca == "CaminoBrillanteKits" || palanca == "CaminoBrillanteDemostradores")
                {
                    breadCrumbs.Ofertas.Texto = "Camino Brillante";
                    breadCrumbs.Palanca.Texto = GetNombresPalancas(palanca);
                    breadCrumbs.Ofertas.Url = Url.Action("Index", new { controller = "CaminoBrillante", area });
                }

                breadCrumbs.Palanca.Url = "#";
                if (!string.IsNullOrWhiteSpace(breadCrumbs.Palanca.Texto))
                {
                    breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area });
                    switch (palanca)
                    {
                        case Constantes.NombrePalanca.ShowRoom:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "ShowRoom", area });
                            break;
                        case Constantes.NombrePalanca.Lanzamiento:
                            {
                                var actionPalanca = productoPerteneceACampaniaActual ? "Index" : "Revisar";
                                breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.Lanzamiento;
                                break;
                            }
                        case Constantes.NombrePalanca.OfertaParaTi:
                        case Constantes.NombrePalanca.OfertasParaMi:
                        case Constantes.NombrePalanca.RevistaDigital:
                            {
                                if (tieneRevistaDigital)
                                {
                                    var actionPalanca = productoPerteneceACampaniaActual ? "Comprar" : "Revisar";
                                    breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "RevistaDigital", area });
                                }
                                else
                                {
                                    breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.OfertasParaTi;
                                }

                                break;
                            }
                        case Constantes.NombrePalanca.PackNuevas:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "ProgramaNuevas", area });
                            break;
                        case Constantes.NombrePalanca.OfertaDelDia:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.OfertaDelDia;
                            break;
                        case Constantes.NombrePalanca.GuiaDeNegocioDigitalizada:
                            breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "GuiaNegocio", area });
                            break;
                        case Constantes.NombrePalanca.CaminoBrillanteDemostradores:
                            {
                                breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "CaminoBrillante/Ofertas", area ,t=1});
                                break;
                            }
                        case Constantes.NombrePalanca.CaminoBrillanteKits:
                            {
                                breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "CaminoBrillante/Ofertas", area });
                                break;
                            }
                        case Constantes.NombrePalanca.HerramientasVenta:
                            {
                                var actionPalanca = productoPerteneceACampaniaActual ? "Comprar" : "Revisar";
                                breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "HerramientasVenta", area });
                                break;
                            }

                        case Constantes.NombrePalanca.MasGanadoras:
                            breadCrumbs.Palanca.Url =
                                SessionManager.MasGanadoras.GetModel().TieneLanding
                                ? Url.Action("Index", new { controller = "MasGanadoras", area })
                                : (Url.Action("Index", new { controller = "Ofertas", area }) + "#" + Constantes.ConfiguracionPais.MasGanadoras);

                            break;
                    }
                }

                breadCrumbs.Producto.Url = "#";
            }
            catch
            {
                // Excepcion
            }

            return breadCrumbs;
        }

        private string GetNombresPalancas(string palanca)
        {
            var nombresPalancas = new Dictionary<string, string>
            {
                { Constantes.NombrePalanca.ShowRoom, "Especiales" },
                { Constantes.NombrePalanca.Lanzamiento, "Lo nuevo ¡Nuevo!" },
                { Constantes.NombrePalanca.OfertaParaTi, "Ofertas para ti" },
                { Constantes.NombrePalanca.OfertasParaMi, "Ofertas Para ti" },
                { Constantes.NombrePalanca.RevistaDigital, "Revista Digital" },
                { Constantes.NombrePalanca.OfertaDelDia, "¡Solo Hoy!" },
                { Constantes.NombrePalanca.GuiaDeNegocioDigitalizada, "Guía De Negocio" },
                { Constantes.NombrePalanca.HerramientasVenta, "Demostradores" },
                { Constantes.NombrePalanca.MasGanadoras, "Las más ganadoras" },
                { Constantes.NombrePalanca.CaminoBrillanteDemostradores, "Demostradores" },
                { Constantes.NombrePalanca.CaminoBrillanteKits, "Kits" },
                { Constantes.NombrePalanca.PackNuevas, _programaNuevasProvider.TieneDuoPerfecto() ? "Dúo Perfecto" : "Programa Nuevas" }
            };

            return nombresPalancas.ContainsKey(palanca) ? nombresPalancas[palanca] : string.Empty;
        }

        public int GetFichaOrigenPedidoWeb(string origen, string tipo = "", bool tieneCarrusel = false)
        {
            origen = Util.Trim(origen);
            if (origen == "" || origen.Length < 7)
            {
                return 0;
            }

            int intOrigen = Convert.ToInt32(origen);

            if (intOrigen <= 0)
            {
                return 0;
            }

            var modeloOrigen = UtilOrigenPedidoWeb.GetModelo(origen);
            var codigoSeccion = ConsOrigenPedidoWeb.Seccion.Ficha;

            tipo = Util.Trim(tipo);
            if (tieneCarrusel)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.CarruselVerMas;

                if (modeloOrigen.Palanca != ConsOrigenPedidoWeb.Palanca.Lanzamientos)
                {
                    modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
                    if (tipo == ConsOrigenPedidoWeb.Seccion.CarruselUpselling) // agregar los 'or' para crosSelling
                    {
                        codigoSeccion = tipo;
                    }
                }
            }
            else if (modeloOrigen.Seccion == ConsOrigenPedidoWeb.Seccion.Recomendado)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.RecomendadoFicha;
            }
            else if (modeloOrigen.Seccion == ConsOrigenPedidoWeb.Seccion.CarruselUpselling)
            {
                codigoSeccion = ConsOrigenPedidoWeb.Seccion.FichaUpselling;
                modeloOrigen.Pagina = ConsOrigenPedidoWeb.Pagina.Ficha;
            }
            modeloOrigen.Seccion = codigoSeccion;
            int result = UtilOrigenPedidoWeb.ToInt(modeloOrigen);
            return result;
        }
        #endregion

        public DetalleEstrategiaFichaModel FichaModelo(string palanca, int campaniaId, string cuv, string origen, bool esEditar = false)
        {
            if (_ofertaPersonalizadaProvider == null)
                throw new NullReferenceException("_ofertaPersonalizadaProvider can not be null");

            if (!_ofertaPersonalizadaProvider.EnviaronParametrosValidos(palanca, campaniaId, cuv))
            {
                return null;
            }

            palanca = IdentificarPalancaRevistaDigital(palanca, campaniaId);

            if (!_ofertaPersonalizadaProvider.TienePermisoPalanca(palanca))
                return null;

            var esMobile = IsMobile();
            DetalleEstrategiaFichaModel modelo = GetEstrategiaInicial(palanca, campaniaId, cuv);

            if (modelo == null)
            {
                modelo = new DetalleEstrategiaFichaModel
                {
                    Error = true
                };
            }

            #region Modelo

            modelo.OrigenUrl = origen;
            modelo.OrigenAgregar = GetFichaOrigenPedidoWeb(origen);
            modelo.CodigoUbigeoPortal = esEditar ? CodigoUbigeoPortal.GuionPedidoGuionFichaResumida : "";
            modelo.TipoAccionNavegar = GetTipoAccionNavegar(modelo.OrigenAgregar, esMobile, esEditar);

            if (modelo.Error)
            {
                return modelo;
            }

            modelo.BreadCrumbs = modelo.TipoAccionNavegar == Constantes.TipoAccionNavegar.BreadCrumbs
                ? GetDetalleEstrategiaBreadCrumbs(campaniaId, palanca)
               : new DetalleEstrategiaBreadCrumbsModel();
            modelo.BreadCrumbs.TipoAccionNavegar = modelo.TipoAccionNavegar;
            modelo.Palanca = palanca;
            modelo.TieneSession = _ofertaPersonalizadaProvider.PalancasConSesion(palanca);
            modelo.Campania = campaniaId;
            modelo.Cuv = cuv;
            modelo.TieneCarrusel = GetValidationHasCarrusel(modelo.OrigenAgregar, esEditar);
            modelo.OrigenAgregarCarrusel = modelo.TieneCarrusel ? GetFichaOrigenPedidoWeb(origen, ConsOrigenPedidoWeb.Seccion.CarruselUpselling, modelo.TieneCarrusel) : 0;
            modelo.TieneCompartir = _caminoBrillanteProvider.IsOrigenPedidoCaminoBrillante(modelo.OrigenAgregar) ? false : GetTieneCompartir(palanca, esEditar, modelo.OrigenAgregar);
            modelo.Cantidad = 1;
            #endregion

            #region ODD
            if (modelo.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaDelDia)
            {
                modelo = GetDatosOdd(modelo);
            }

            #endregion

            modelo.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(esMobile);
            modelo.NoEsCampaniaActual = campaniaId != userData.CampaniaID;

            modelo.MostrarCliente = GetMostrarCliente(esEditar);
            modelo.MostrarAdicional = GetInformacionAdicional(esEditar);
            modelo.MostrarFichaEnriquecida = !esEditar && _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            userData.PaisID,
                            ConsTablaLogica.FlagFuncional.TablaLogicaId,
                            ConsTablaLogica.FlagFuncional.FichaEnriquecida,
                            true
                            );
            modelo.MostrarFichaResponsive = !esEditar && _tablaLogicaProvider.GetTablaLogicaDatoValorBool(
                            userData.PaisID,
                            ConsTablaLogica.FlagFuncional.TablaLogicaId,
                            ConsTablaLogica.FlagFuncional.FichaResponsive,
                            true
                            );
            return modelo;
        }

        private string IdentificarPalancaRevistaDigital(string palanca, int campaniaId)
        {
            var palancaX = palanca;
            switch (palanca)
            {
                case Constantes.NombrePalanca.OfertaParaTi:
                    if (revistaDigital == null)
                        break;

                    if (revistaDigital.ActivoMdo)
                    {
                        palancaX = Constantes.NombrePalanca.OfertasParaMi;
                        break;
                    }

                    if (revistaDigital.TieneRDC || revistaDigital.TieneRDCR)
                    {
                        if (revistaDigital.EsActiva)
                        {
                            palancaX = Constantes.NombrePalanca.OfertasParaMi;
                            break;
                        }

                        palancaX = campaniaId == userData.CampaniaID
                            ? Constantes.NombrePalanca.OfertaParaTi
                            : Constantes.NombrePalanca.OfertasParaMi;

                        break;
                    }

                    palancaX = Constantes.NombrePalanca.OfertaParaTi;

                    break;
                default:
                    break;
            }
            return palancaX;
        }

        private DetalleEstrategiaFichaModel GetEstrategiaInicial(string palanca, int campaniaId, string cuv)
        {
            string codigoPalanca;
            bool esFichaApi = false;
            bool tieneCodigoPalanca = Constantes.NombrePalanca.PalancasbyCodigo.TryGetValue(palanca, out codigoPalanca);
            if (tieneCodigoPalanca) esFichaApi = new OfertaBaseProvider().UsaFichaMsPersonalizacion(codigoPalanca);

            var modelo = new DetalleEstrategiaFichaModel();
            if (!esFichaApi)
            {
                if (_ofertaPersonalizadaProvider.PalancasConSesion(palanca))
                {
                    var estrategiaPresonalizada = _ofertaPersonalizadaProvider.ObtenerEstrategiaPersonalizada(userData, palanca, cuv, campaniaId);
                    if (estrategiaPresonalizada == null) return null;

                    if (userData.CampaniaID != campaniaId) estrategiaPresonalizada.ClaseBloqueada = "btn_desactivado_general";
                    modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(estrategiaPresonalizada);

                    if (palanca == Constantes.NombrePalanca.PackNuevas)
                    {
                        modelo.TipoEstrategiaDetalle.Slogan = "Contenido del Set:";
                        modelo.ListaDescripcionDetalle = modelo.ArrayContenidoSet;
                    }
                }                
                else if (palanca == "CaminoBrillanteDemostradores" || palanca == "CaminoBrillanteKits") {                    
                    modelo = _caminoBrillanteProvider.GetDetalleEstrategiaFichaModel(cuv);
                }                
             }
            else
            {
                string mensaje;
                modelo = _ofertaPersonalizadaProvider.GetEstrategiaFicha(cuv, campaniaId.ToString(), codigoPalanca, out mensaje);

                if (userData.CampaniaID != campaniaId) modelo.ClaseBloqueada = "btn_desactivado_general";
                if (palanca == Constantes.NombrePalanca.PackNuevas)
                {
                    modelo.TipoEstrategiaDetalle.Slogan = "Contenido del Set:";
                    modelo.ListaDescripcionDetalle = modelo.ArrayContenidoSet;
                }
                modelo.Hermanos = _estrategiaComponenteProvider.FormatterEstrategiaComponentes(modelo.Hermanos, modelo.CUV2, modelo.CampaniaID, esFichaApi);
                modelo = _ofertaPersonalizadaProvider.FormatterEstrategiaFicha(modelo, userData.CampaniaID);
            }
            return modelo;
        }

        private int GetTipoAccionNavegar(int origen, bool esMobile, bool esEditar)
        {
            var tipo = Constantes.TipoAccionNavegar.SinBoton;

            if (esMobile && origen.ToString().StartsWith(Constantes.IngresoExternoOrigen.App))
            {
                return tipo;
            }

            tipo = esEditar ? Constantes.TipoAccionNavegar.Volver : GetAccionNavegarSegunOrigen(origen);

            return tipo;
        }

        private int GetAccionNavegarSegunOrigen(int origen)
        {
            return EsProductoRecomendado(origen) ? Constantes.TipoAccionNavegar.Volver : Constantes.TipoAccionNavegar.BreadCrumbs;
        }

        private bool EsProductoRecomendado(int origen)
        {
            var modelo = UtilOrigenPedidoWeb.GetModelo(origen.ToString());
            if (origen == 0 /*|| origenString.IsNullOrEmptyTrim()*/) return false; //CB-CORREGIR

            return modelo.Seccion.Equals(ConsOrigenPedidoWeb.Seccion.Recomendado) ||
                   modelo.Seccion.Equals(ConsOrigenPedidoWeb.Seccion.RecomendadoFicha);
        }
        
        private bool GetValidationHasCarrusel(int origen, bool esEditar)
        {
            if (EsProductoRecomendado(origen))
            {
                return false;
            }

            return !esEditar;
        }

        private bool GetTieneCompartir(string palanca, bool esEditar, int origen)
        {
            if (EsProductoRecomendado(origen)) return false;
            return !esEditar && !MobileAppConfiguracion.EsAppMobile &&
                !(Constantes.NombrePalanca.HerramientasVenta == palanca
                || Constantes.NombrePalanca.PackNuevas == palanca);
        }

        private DetalleEstrategiaFichaModel GetDatosOdd(DetalleEstrategiaFichaModel modelo)
        {
            modelo.TeQuedan = _ofertaDelDiaProvider.CountdownOdd(userData).TotalSeconds;
            modelo.TieneReloj = true;

            var sessionODD = (DataModel)SessionManager.OfertaDelDia.Estrategia.Clone();
            modelo.ColorFondo1 = sessionODD.ColorFondo1;
            modelo.ConfiguracionContenedor = (ConfiguracionSeccionHomeModel)sessionODD.ConfiguracionContenedor.Clone();
            modelo.ConfiguracionContenedor = modelo.ConfiguracionContenedor ?? new ConfiguracionSeccionHomeModel();
            modelo.ConfiguracionContenedor.ColorFondo = "#fff";
            modelo.ConfiguracionContenedor.ColorTexto = "#000";
            modelo.ColorFondo1 = "";

            return modelo;
        }

        private bool GetMostrarCliente(bool esEditar)
        {
            var mostrar = esEditar && (new ClienteProvider()).ValidarFlagFuncional(userData.PaisID);
            return mostrar;

        }

        /// <summary>
        /// metodo para obtener toda la informacion adiciona en un modelo
        /// por el momento solo es bool para saber si va o no
        /// </summary>
        /// <param name="esEditar"></param>
        /// <returns></returns>
        private bool GetInformacionAdicional(bool esEditar)
        {
            return !esEditar;

        }
    }
}