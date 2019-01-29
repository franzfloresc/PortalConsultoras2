﻿using AutoMapper;
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
    public class BaseViewController : BaseController
    {
        private readonly IssuuProvider _issuuProvider;

        public BaseViewController() : base()
        {
            _issuuProvider = new IssuuProvider();
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

        protected RevistaDigitalLandingModel GetLandingModel(int tipo)
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
                CantidadFilas = 20
            };

            var dato = _ofertasViewProvider.ObtenerPerdioTitulo(model.CampaniaID, IsMobile());
            model.ProductosPerdio = dato.Estado;
            model.PerdioTitulo = dato.Valor1;
            model.PerdioSubTitulo = dato.Valor2;

            model.PerdioLogo = revistaDigital.DLogoComercialActiva;

            model.MostrarFiltros = !model.ProductosPerdio && !(revistaDigital.TieneRDC && !revistaDigital.EsActiva);
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
                var modelo = FichaModelo(palanca, campaniaId, cuv, origen);

                if (modelo != null)
                {
                    return View(modelo);
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseViewController.Ficha");
            }

            return Redireccionar();
        }

        private ActionResult Redireccionar()
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

        private DetalleEstrategiaBreadCrumbsModel GetDetalleEstrategiaBreadCrumbs(bool tieneRevistaDigital,
            bool productoPerteneceACampaniaActual, string palanca)
        {
            var breadCrumbs = new DetalleEstrategiaBreadCrumbsModel();

            try
            {
                var area = IsMobile() ? "mobile" : string.Empty;

                breadCrumbs.Inicio.Texto = MobileAppConfiguracion.EsAppMobile ? null : "Inicio";
                breadCrumbs.Ofertas.Texto = tieneRevistaDigital && revistaDigital.EsSuscrita ? "Gana +" : "Ofertas Digitales";
                breadCrumbs.Palanca.Texto = GetNombresPalancas(palanca);

                breadCrumbs.Inicio.Url = Url.Action("Index", new { controller = "Bienvenida", area });

                var actionOfertas = productoPerteneceACampaniaActual ? "Index" : "Revisar";
                breadCrumbs.Ofertas.Url = Url.Action(actionOfertas, new { controller = "Ofertas", area });

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
                { Constantes.NombrePalanca.PackNuevas, _programaNuevasProvider.GetLimElectivos() > 1 ? "Dúo Perfecto" : "Programa Nuevas" }
            };

            return nombresPalancas.ContainsKey(palanca) ? nombresPalancas[palanca] : string.Empty;
        }

        public int GetOrigenPedidoWebDetalle(string origen, bool tieneCarrusel = false)
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
                #region Desktop
                case Constantes.OrigenPedidoWeb.DesktopHomeOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopHomeOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopContenedorOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopContenedorOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingOfertasParaTiOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingOfertasParaTiOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopPedidoOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopPedidoOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopContenedorLanzamientosCarrusel:
                    result = tieneCarrusel ? Constantes.OrigenPedidoWeb.DesktopContenedorLanzamientosCarruselVerMas : Constantes.OrigenPedidoWeb.DesktopContenedorLanzamientosFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopContenedorOfertaDelDiaCarrusel:
                    result = tieneCarrusel ? Constantes.OrigenPedidoWeb.DesktopContenedorOfertaDelDiaCarruselVerMas : Constantes.OrigenPedidoWeb.DesktopContenedorOfertaDelDiaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopHomeShowroomCarrusel:
                    result = tieneCarrusel ? Constantes.OrigenPedidoWeb.DesktopHomeShowroomCarruselVerMas : Constantes.OrigenPedidoWeb.DesktopHomeShowroomFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopContenedorShowroomCarrusel:
                    result = tieneCarrusel ? Constantes.OrigenPedidoWeb.DesktopContenedorShowroomCarruselVerMas : Constantes.OrigenPedidoWeb.DesktopContenedorShowroomFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingShowroomShowroomCarrusel:
                    result = tieneCarrusel ? Constantes.OrigenPedidoWeb.DesktopLandingShowroomShowroomCarruselVerMas : Constantes.OrigenPedidoWeb.DesktopLandingShowroomShowroomFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingGNDGNDCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingGNDGNDFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinalCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopPedidoOfertaFinalFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopContenedorHerramientasdeVentaCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopContenedorHerramientasdeVentaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingHerramientasdeVentaHerramientasdeVentaCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingHerramientasdeVentaHerramientasdeVentasFicha;
                    break;
                #endregion Desktop
                #region Mobile
                case Constantes.OrigenPedidoWeb.MobileHomeOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileHomeOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileContenedorOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileContenedorOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobilePedidoOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobilePedidoOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinalCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobilePedidoOfertaFinalFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingOfertasParaTiOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingOfertasParaTiOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingHerramientasdeVentaHerramientasdeVentaCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingHerramientasdeVentaHerramientasdeVentaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileContenedorLanzamientosCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileContenedorLanzamientosFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileHomeOfertaDelDiaCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileHomeOfertaDelDiaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileContenedorOfertaDelDiaCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileContenedorOfertaDelDiaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingShowroomShowroomCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingShowroomShowroomFicha;
                    break;

                #endregion Mobile

                #region Buscador Desktop

                case Constantes.OrigenPedidoWeb.DesktopBuscadorOfertasParaTiDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.DesktopBuscadorOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopBuscadorShowroomDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.DesktopBuscadorShowroomFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopBuscadorLanzamientosDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.DesktopBuscadorLanzamientosFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopBuscadorOfertaDelDiaDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.DesktopBuscadorOfertaDelDiaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopBuscadorGNDDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.DesktopBuscadorGNDFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopBuscadorHerramientasdeVentaDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.DesktopBuscadorHerramientasdeVentaFicha;
                    break;

                case Constantes.OrigenPedidoWeb.DesktopLandingBuscadorOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingBuscadorOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingBuscadorShowroomCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingBuscadorShowroomFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingBuscadorLanzamientosCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingBuscadorLanzamientosFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingBuscadorOfertaDelDiaCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingBuscadorOfertaDelDiaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingBuscadorGNDCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingBuscadorGNDFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingBuscadorHerramientasDeVentaCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingBuscadorHerramientasDeVentaFicha;
                    break;
                #endregion Buscador Desktop

                #region Buscador Mobile
                case Constantes.OrigenPedidoWeb.MobileBuscadorOfertasParaTiDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.MobileBuscadorOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileBuscadorShowroomDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.MobileBuscadorShowroomFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileBuscadorLanzamientosDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.MobileBuscadorLanzamientosFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileBuscadorOfertaDelDiaDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.MobileBuscadorOfertaDelDiaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileBuscadorGNDDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.MobileBuscadorGNDFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileBuscadorHerramientasdeVentaDesplegableBuscador:
                    result = Constantes.OrigenPedidoWeb.MobileBuscadorHerramientasdeVentaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingBuscadorOfertasParaTiCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingBuscadorOfertasParaTiFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingBuscadorShowroomCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingBuscadorShowroomFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingBuscadorLanzamientosCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingBuscadorLanzamientosFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingBuscadorOfertaDelDiaCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingBuscadorOfertaDelDiaFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingBuscadorGNDCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingBuscadorGNDFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingBuscadorHerramientasDeVentaCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingBuscadorHerramientasDeVentaFicha;
                    break;
                #endregion Buscador Mobile

                #region Mas Ganadoras
                case Constantes.OrigenPedidoWeb.DesktopContenedorGanadorasCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopContenedorGanadorasFicha;
                    break;
                case Constantes.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasCarrusel:
                    result = Constantes.OrigenPedidoWeb.DesktopLandingGanadorasGanadorasFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileContenedorGanadorasCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileContenedorGanadorasFicha;
                    break;
                case Constantes.OrigenPedidoWeb.MobileLandingGanadorasGanadorasCarrusel:
                    result = Constantes.OrigenPedidoWeb.MobileLandingGanadorasGanadorasFicha;
                    break;
                #endregion
                #region ODD
                case Constantes.OrigenPedidoWeb.DesktopHomeOfertaDelDiaBannerSuperior:
                    result = Constantes.OrigenPedidoWeb.DesktopHomeOfertaDelDiaFicha;
                    break;
                    #endregion
            }

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

            DetalleEstrategiaFichaModel modelo = null;
            if (_ofertaPersonalizadaProvider.PalancasConSesion(palanca))
            {
                var estrategiaPresonalizada = _ofertaPersonalizadaProvider.ObtenerEstrategiaPersonalizada(userData, palanca, cuv, campaniaId);

                if (estrategiaPresonalizada == null)
                {
                    return null;
                }

                if (userData.CampaniaID != campaniaId) estrategiaPresonalizada.ClaseBloqueada = "btn_desactivado_general";
                modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(estrategiaPresonalizada);
                if (palanca == Constantes.NombrePalanca.PackNuevas)
                {
                    modelo.TipoEstrategiaDetalle.Slogan = "Contenido del Set:";
                    modelo.ListaDescripcionDetalle = modelo.ArrayContenidoSet;
                }
            }

            #region Modelo

            var esMobile = IsMobile();
            modelo = modelo ?? new DetalleEstrategiaFichaModel();
            modelo.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(esMobile);
            modelo.OrigenUrl = origen;
            modelo.OrigenAgregar = GetOrigenPedidoWebDetalle(origen);

            modelo.TipoAccionNavegar = GetTipoAccionNavegar(modelo.OrigenAgregar, esMobile, esEditar);
            modelo.BreadCrumbs = GetDetalleEstrategiaBreadCrumbs(revistaDigital.TieneRevistaDigital(),
               userData.CampaniaID == campaniaId,
               palanca);
            modelo.Palanca = palanca;
            modelo.TieneSession = _ofertaPersonalizadaProvider.PalancasConSesion(palanca);
            modelo.Campania = campaniaId;
            modelo.Cuv = cuv;

            modelo.TieneCarrusel = Constantes.NombrePalanca.Lanzamiento == palanca
                    || Constantes.NombrePalanca.ShowRoom == palanca
                    || Constantes.NombrePalanca.OfertaDelDia == palanca;
            modelo.OrigenAgregarCarrusel = modelo.TieneCarrusel ? GetOrigenPedidoWebDetalle(origen, modelo.TieneCarrusel) : 0;

            modelo.TieneCompartir = !MobileAppConfiguracion.EsAppMobile &&
                !(Constantes.NombrePalanca.HerramientasVenta == palanca
                || Constantes.NombrePalanca.PackNuevas == palanca);

            modelo.NoEsCampaniaActual = campaniaId != userData.CampaniaID;

            #endregion

            #region ODD
            if (modelo.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaDelDia)
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
            }

            #endregion

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

        private int GetTipoAccionNavegar(int origen, bool esMobile, bool esEditar)
        {
            int tipo = Constantes.TipoAccionNavegar.SinBoton;

            if (esMobile && origen.ToString().StartsWith(Constantes.IngresoExternoOrigen.App))
            {
                return tipo;
            }

            if (esEditar)
            {
                tipo = Constantes.TipoAccionNavegar.Volver;
            }
            else
            {
                tipo = GetAccionNavegarSegunOrigen(origen);
            }

            return tipo;
        }

        private int GetAccionNavegarSegunOrigen(int origen)
        {
            int tipo = Constantes.TipoAccionNavegar.BreadCrumbs;

            // aplicar logica para los origenes de sugeridos
            return tipo;
        }
    }
}