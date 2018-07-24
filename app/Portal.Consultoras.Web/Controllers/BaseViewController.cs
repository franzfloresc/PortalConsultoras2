using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.DetalleEstrategia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseViewController : BaseController //BaseEstrategiaController
    {
        private readonly IssuuProvider _issuuProvider;

        public BaseViewController() : base()
        {
            _issuuProvider = new IssuuProvider();
        }

        public BaseViewController(ISessionManager sesionManager) : base(sesionManager)
        {

        }

        public BaseViewController(ISessionManager sesionManager, ILogManager logManager) : base(sesionManager, logManager)
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
            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile()),
                CantidadFilas = 15
            };

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(model.CampaniaID, IsMobile());
            model.ProductosPerdio = dato.Estado;
            model.PerdioTitulo = dato.Valor1;
            model.PerdioSubTitulo = dato.Valor2;

            model.MostrarFiltros = !model.ProductosPerdio && !(revistaDigital.TieneRDC && !revistaDigital.EsActiva);

            return PartialView("template-landing", model);
        }

        public ActionResult RDDetalleModel(string cuv, int campaniaId)
        {
            var modelo = sessionManager.GetProductoTemporal();
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

        #region Lanzamiento

        //public virtual ActionResult LANDetalle(string cuv, int campaniaId)
        //{
        //    try
        //    {
        //        var esMobile = IsMobile();

        //        if (!revistaDigital.TieneRevistaDigital() || !revistaDigital.EsActiva)
        //        {
        //            return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });
        //        }

        //        var modelo = sessionManager.GetProductoTemporal();
        //        if (modelo == null || modelo.EstrategiaID == 0 || _ofertaPersonalizadaProvider.EsCampaniaFalsa(modelo.CampaniaID) ||
        //            modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
        //        {
        //            return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });
        //        }

        //        modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
        //        modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();

        //        var EstrategiaDetalle = EstrategiaGetDetalle(modelo.EstrategiaID);
        //        if (EstrategiaDetalle.Hermanos != null)
        //        {
        //            modelo.Hermanos = EstrategiaDetalle.Hermanos;
        //        }

        //        if (modelo.CodigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos)
        //        {
        //            if ((modelo.Hermanos.Any()))
        //            {
        //                modelo.ClaseBloqueada = "btn_desactivado_general";
        //            }
        //        }
        //        else if (modelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || modelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
        //        {
        //            if (modelo.Hermanos != null && modelo.Hermanos.Any())
        //            {
        //                if (modelo.Hermanos[0].Digitable == 1 && modelo.Hermanos[0].Hermanos.Any())
        //                {
        //                    modelo.ClaseBloqueada = "btn_desactivado_general";
        //                }
        //            }
        //        }

        //        modelo.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(esMobile);

        //        ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
        //        ViewBag.Campania = campaniaId;

        //        return View(modelo);
        //    }
        //    catch (Exception ex)
        //    {
        //        logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseLanzamientosController.Detalle");
        //        throw;
        //    }
        //}

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

        #region Herramienta Venta

        public ActionResult HVViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = IsMobile(),
                FiltersBySorting = _ofertasViewProvider.GetFiltersBySorting(IsMobile()),
                FiltersByBrand = _ofertasViewProvider.GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = HVMensajeProductoBloqueado(),
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
                if (!_ofertaPersonalizadaProvider.EnviaronParametrosValidos(palanca, campaniaId, cuv))
                    return RedirectToAction("Index", "Ofertas");

                palanca = IdentificarPalanca(palanca, campaniaId);

                if (!_ofertaPersonalizadaProvider.TienePermisoPalanca(palanca))
                    return RedirectToAction("Index", "Ofertas");

                DetalleEstrategiaFichaModel modelo;
                if (_ofertaPersonalizadaProvider.PalancasConSesion(palanca))
                {
                    var estrategiaPresonalizada = _ofertaPersonalizadaProvider.ObtenerEstrategiaPersonalizada(userData, palanca, cuv, campaniaId);
                    if (estrategiaPresonalizada == null)
                        return RedirectToAction("Index", "Ofertas");

                    if (userData.CampaniaID != campaniaId) estrategiaPresonalizada.ClaseBloqueada = "btn_desactivado_general";
                    modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(estrategiaPresonalizada);
                    if (palanca == Constantes.NombrePalanca.PackNuevas)
                    {
                        modelo.TipoEstrategiaDetalle.Slogan = "Contenido del Set:";
                        modelo.ListaDescripcionDetalle = modelo.ArrayContenidoSet;
                    }
                }
                else
                {
                    modelo = new DetalleEstrategiaFichaModel();
                }

                modelo.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile());
                modelo.OrigenUrl = origen;
                modelo.OrigenAgregar = GetOrigenPedidoWebDetalle(origen);
                modelo.BreadCrumbs = GetDetalleEstrategiaBreadCrumbs(revistaDigital.TieneRevistaDigital(),
                   userData.CampaniaID == campaniaId,
                   palanca);
                modelo.Palanca = palanca;
                modelo.TieneSession = _ofertaPersonalizadaProvider.PalancasConSesion(palanca);
                modelo.Campania = campaniaId;
                modelo.Cuv = cuv;
                //modelo.TieneRevistaDigital = ;
                //modelo.CodigoIsoConsultora = userData.CodigoISO;

                modelo.TieneCarrusel = (Constantes.NombrePalanca.Lanzamiento == palanca
                        || Constantes.NombrePalanca.ShowRoom == palanca
                        || Constantes.NombrePalanca.OfertaDelDia == palanca);

                modelo.TieneCompartir = !(Constantes.NombrePalanca.HerramientasVenta == palanca
                    || Constantes.NombrePalanca.PackNuevas == palanca);

                if (modelo.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaDelDia)
                {
                    modelo.TeQuedan = _ofertaDelDiaProvider.CountdownOdd(userData).TotalSeconds;
                    modelo.TieneReloj = true;

                    var sessionODD = (DataModel)sessionManager.OfertaDelDia.Estrategia.Clone();
                    modelo.ColorFondo1 = sessionODD.ColorFondo1;
                    modelo.ConfiguracionContenedor = (ConfiguracionSeccionHomeModel)sessionODD.ConfiguracionContenedor.Clone();
                    modelo.ConfiguracionContenedor = modelo.ConfiguracionContenedor ?? new ConfiguracionSeccionHomeModel();
                    modelo.ConfiguracionContenedor.ColorFondo = "#fff";
                    modelo.ConfiguracionContenedor.ColorTexto = "#000";
                    modelo.ColorFondo1 = "";
                }

                return View(modelo);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
        }

        private DetalleEstrategiaBreadCrumbsModel GetDetalleEstrategiaBreadCrumbs(bool tieneRevistaDigital,
            bool productoPerteneceACampaniaActual, string palanca)
        {
            var breadCrumbs = new DetalleEstrategiaBreadCrumbsModel();
            var area = IsMobile() ? "mobile" : string.Empty;
            //
            breadCrumbs.Inicio.Texto = "Inicio";
            breadCrumbs.Inicio.Url = Url.Action("Index", new { controller = "Bienvenida", area });
            //
            breadCrumbs.Ofertas.Texto = tieneRevistaDigital && revistaDigital.EsSuscrita ? "Club Gana +" : "Ofertas";
            var actionOfertas = productoPerteneceACampaniaActual ? "Index" : "Revisar";
            breadCrumbs.Ofertas.Url = Url.Action(actionOfertas, new { controller = "Ofertas", area });
            //
            breadCrumbs.Palanca.Texto = GetNombresPalancas().ContainsKey(palanca) ? GetNombresPalancas()[palanca] : string.Empty;
            breadCrumbs.Palanca.Url = "#";
            if (!string.IsNullOrWhiteSpace(breadCrumbs.Palanca.Texto))
            {
                breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area });
                if (palanca == Constantes.NombrePalanca.ShowRoom)
                    breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "ShowRoom", area });
                if (palanca == Constantes.NombrePalanca.Lanzamiento)
                {
                    var actionPalanca = productoPerteneceACampaniaActual ? "Index" : "Revisar";
                    breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "Ofertas", area }) + "#LAN";
                }
                if (palanca == Constantes.NombrePalanca.OfertaParaTi ||
                    palanca == Constantes.NombrePalanca.OfertasParaMi ||
                    palanca == Constantes.NombrePalanca.RevistaDigital ||
                    palanca == Constantes.NombrePalanca.PackNuevas)
                {
                    if (tieneRevistaDigital)
                    {
                        var actionPalanca = productoPerteneceACampaniaActual ? "Comprar" : "Revisar";
                        breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "RevistaDigital", area });
                    }
                    else
                    {
                        var actionPalanca = productoPerteneceACampaniaActual ? "" : "";
                        breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "Ofertas", area }) + "#OPT";
                    }
                }
                if (palanca == Constantes.NombrePalanca.OfertaDelDia)
                    breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "Ofertas", area }) + "#ODD";
                if (palanca == Constantes.NombrePalanca.GuiaDeNegocioDigitalizada)
                    breadCrumbs.Palanca.Url = Url.Action("Index", new { controller = "GuiaNegocio", area });
                if (palanca == Constantes.NombrePalanca.HerramientasVenta)
                {
                    var actionPalanca = productoPerteneceACampaniaActual ? "Comprar" : "Revisar";
                    breadCrumbs.Palanca.Url = Url.Action(actionPalanca, new { controller = "HerramientasVenta", area });
                }
            }
            //
            breadCrumbs.Producto.Url = "#";
            //
            return breadCrumbs;
        }

        private Dictionary<string, string> GetNombresPalancas()
        {
            var NombrePalancas = new Dictionary<string, string>();

            NombrePalancas.Add(Constantes.NombrePalanca.ShowRoom, "Especiales");
            NombrePalancas.Add(Constantes.NombrePalanca.Lanzamiento, "Lo nuevo Nuevo");
            NombrePalancas.Add(Constantes.NombrePalanca.OfertaParaTi, "Ofertas para ti");
            NombrePalancas.Add(Constantes.NombrePalanca.OfertasParaMi, "Ofertas Para ti");
            NombrePalancas.Add(Constantes.NombrePalanca.RevistaDigital, "Revista Digital");
            NombrePalancas.Add(Constantes.NombrePalanca.OfertaDelDia, "Sólo Hoy");
            NombrePalancas.Add(Constantes.NombrePalanca.GuiaDeNegocioDigitalizada, "Guía De Negocio");
            NombrePalancas.Add(Constantes.NombrePalanca.HerramientasVenta, "Demostradores");

            NombrePalancas.Add(Constantes.NombrePalanca.PackNuevas, "Ofertas Para ti");
            //NombrePalancas.Add(Constantes.NombrePalanca.OfertaWeb, "Oferta Web");
            //NombrePalancas.Add(Constantes.NombrePalanca.OfertasParaMi, "Ofertas Para Mi");
            //NombrePalancas.Add(Constantes.NombrePalanca.PackAltoDesembolso, "Pack de Alto Desembolso");

            //NombrePalancas.Add(Constantes.NombrePalanca.LosMasVendidos, "Los Más Vendidos");
            //NombrePalancas.Add(Constantes.NombrePalanca.IncentivosProgramaNuevas, "Incentivos Programa de Nuevas");
            //NombrePalancas.Add(Constantes.NombrePalanca.Incentivos, "Incentivos");
            //NombrePalancas.Add(Constantes.NombrePalanca.ProgramaNuevasRegalo, "Oferta Del Día");
            return NombrePalancas;
        }

        public int GetOrigenPedidoWebDetalle(string origen)
        {
            origen = Util.Trim(origen);
            if (origen == "")
            {
                return 0;
            }

            int intOrigen = Convert.ToInt32(origen);
            var result = 0;

            switch (intOrigen)
            {
                //OPT
                case Constantes.OrigenPedidoWeb.OfertasParaTiDesktopHome:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiDesktopHomePopUp;
                    break;
                case Constantes.OrigenPedidoWeb.OfertasParaTiDesktopPedido:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiDesktopPedidoPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedor:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiDesktopContenedorPopup;
                    break;
                //Mobile
                case Constantes.OrigenPedidoWeb.OfertasParaTiMobileHome:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiMobileHomePopUp;
                    break;
                case Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedidoPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedorPopup;
                    break;
                // RD
                case Constantes.OrigenPedidoWeb.RevistaDigitalDesktopHomeSeccion:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalDesktopHomePopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalDesktopPedidoSeccion:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalDesktopPedidoPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalDesktopLanding:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalDesktopLandingPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalDesktopHomeLanzamiento:
                    result = Constantes.OrigenPedidoWeb.LanzamientoDesktopProductPage;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedor:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalDesktopContenedorPopup;
                    break;
                //Mobile
                case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomePopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalMobileLanding:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalMobileLandingPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeLanzamiento:
                    result = Constantes.OrigenPedidoWeb.LanzamientoMobileHomePopup;
                    break;
                //LAN
                case Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedor:
                    result = Constantes.OrigenPedidoWeb.LanzamientoDesktopContenedorPopup;
                    break;
                case Constantes.OrigenPedidoWeb.LanzamientoDesktopProductPage:
                    result = Constantes.OrigenPedidoWeb.LanzamientoDesktopProductPage;
                    break;
                //Mobile
                case Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor:
                    result = Constantes.OrigenPedidoWeb.LanzamientoMobileContenedorPopup;
                    break;
                case Constantes.OrigenPedidoWeb.LanzamientoMobileProductPage:
                    result = Constantes.OrigenPedidoWeb.LanzamientoMobileProductPage;
                    break;
                //GND
                case Constantes.OrigenPedidoWeb.GNDMobileLanding:
                    result = Constantes.OrigenPedidoWeb.GNDMobileLandingPopup;
                    break;
                case Constantes.OrigenPedidoWeb.GNDDesktopLanding:
                    result = Constantes.OrigenPedidoWeb.GNDDesktopLandingPopUp;
                    break;
                //HV
                case Constantes.OrigenPedidoWeb.HVMobileLanding:
                    result = Constantes.OrigenPedidoWeb.HVMobileLandingPopup;
                    break;
                case Constantes.OrigenPedidoWeb.HVDesktopLanding:
                    result = Constantes.OrigenPedidoWeb.HVDesktopLandingPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.HVDesktopContenedor:
                    result = Constantes.OrigenPedidoWeb.HVDesktopContenedorPopup;
                    break;
                //SR
                case Constantes.OrigenPedidoWeb.ShowRoomDesktopHome:
                case Constantes.OrigenPedidoWeb.ShowRoomDesktopContenedor:
                case Constantes.OrigenPedidoWeb.ShowRoomDesktopLandingCompra:
                case Constantes.OrigenPedidoWeb.ShowRoomDesktopLandingIntriga:
                case Constantes.OrigenPedidoWeb.ShowRoomDesktopSubCampania:
                    result = Constantes.OrigenPedidoWeb.ShowRoomDesktopProductPage;
                    break;
                //Mobile
                case Constantes.OrigenPedidoWeb.ShowRoomMobileContenedor:
                case Constantes.OrigenPedidoWeb.ShowRoomMobileLandingCompra:
                case Constantes.OrigenPedidoWeb.ShowRoomMobileLandingIntriga:
                case Constantes.OrigenPedidoWeb.ShowRoomMobileSubCampania:
                    result = Constantes.OrigenPedidoWeb.ShowRoomMobileProductPage;
                    break;
                //ODD
                case Constantes.OrigenPedidoWeb.OfertaDelDiaDesktopHomeBanner:
                case Constantes.OrigenPedidoWeb.OfertaDelDiaDesktopPedidoBanner:
                case Constantes.OrigenPedidoWeb.OfertaDelDiaDesktopGeneralBanner:
                case Constantes.OrigenPedidoWeb.OfertaDelDiaDesktopContenedor:
                    result = Constantes.OrigenPedidoWeb.OfertaDelDiaDesktopFicha;
                    break;
                //Mobile
                case Constantes.OrigenPedidoWeb.OfertaDelDiaMobileHomeBanner:
                case Constantes.OrigenPedidoWeb.OfertaDelDiaMobileContenedor:
                    result = Constantes.OrigenPedidoWeb.OfertaDelDiaMobileFicha;
                    break;
            }

            //result = result == 0 ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileDetalle : result;

            return result;
        }
        #endregion

        public string IdentificarPalanca(string palanca, int campaniaId)
        {
            var RevistaDigital = sessionManager.GetRevistaDigital();
            switch (palanca)
            {
                case Constantes.NombrePalanca.OfertaParaTi:
                    if (RevistaDigital.ActivoMdo)
                    {
                        palanca = Constantes.NombrePalanca.OfertasParaMi;
                    }
                    else
                    {
                        if (revistaDigital.TieneRDC || revistaDigital.TieneRDCR)
                        {
                            if (revistaDigital.EsActiva)
                            {
                                palanca = Constantes.NombrePalanca.OfertasParaMi;
                            }
                            else
                            {
                                palanca = campaniaId == userData.CampaniaID ? Constantes.NombrePalanca.OfertaParaTi : Constantes.NombrePalanca.OfertasParaMi;
                            }
                        }
                        else
                        {
                            palanca = Constantes.NombrePalanca.OfertaParaTi;
                        }
                    }
                    break;
                default:
                    break;
            }
            return palanca;
        }
    }
}