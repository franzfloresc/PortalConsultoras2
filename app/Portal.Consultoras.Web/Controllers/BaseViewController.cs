using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

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

        public ActionResult DEFicha(string palanca, int campaniaId, string cuv, string origen, bool esMobile = false)
        {
            try
            {

                if (!_ofertaPersonalizadaProvider.EnviaronParametrosValidos(palanca, campaniaId, cuv)) return RedirectToAction("Index", "Ofertas");

                if (!_ofertaPersonalizadaProvider.TienePermisoPalanca(palanca)) return RedirectToAction("Index", "Ofertas");

                DetalleEstrategiaFichaModel modelo;
                if (_ofertaPersonalizadaProvider.PalancasConSesion(palanca))
                {
                    var estrategiaPresonalizada = _ofertaPersonalizadaProvider.ObtenerEstrategiaPersonalizada(userData, palanca, cuv, campaniaId);
                    if (estrategiaPresonalizada == null) return RedirectToAction("Index", "Ofertas");
                    modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(estrategiaPresonalizada);
                }
                else
                {
                    modelo = new DetalleEstrategiaFichaModel();
                }

                modelo.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile());

                modelo.Origen = origen;
                modelo.Palanca = palanca;
                modelo.TieneSession = _ofertaPersonalizadaProvider.PalancasConSesion(palanca);
                modelo.Campania = campaniaId;
                modelo.Cuv = cuv;


                ViewBag.PaisAnalytics = userData.CodigoISO;
                ViewBag.TieneRevistaDigital = revistaDigital.TieneRevistaDigital();

                return View(modelo);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });
        }

        #endregion
    }
}