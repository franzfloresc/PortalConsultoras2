﻿//using Portal.Consultoras.Common;
//using Portal.Consultoras.Web.LogManager;
//using Portal.Consultoras.Web.Models;
//using Portal.Consultoras.Web.SessionManager;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web.Mvc;

//namespace Portal.Consultoras.Web.Controllers
//{
//    public class BaseLanzamientosController : BaseEstrategiaController
//    {
//        public BaseLanzamientosController()
//            : base()
//        {
//            //
//        }

//        public BaseLanzamientosController(ISessionManager sessionManager)
//            : base(sessionManager)
//        {
//        }

//        public BaseLanzamientosController(ISessionManager sessionManager, ILogManager logManager)
//            : base(sessionManager, logManager)
//        {

//        }

//        //public virtual ActionResult Detalle(string cuv, int campaniaId)
//        //{
//        //    try
//        //    {
//        //        var esMobile = IsMobile();

//        //        if (!revistaDigital.TieneRevistaDigital() || !revistaDigital.EsActiva)
//        //        {
//        //            return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });
//        //        }

//        //        var modelo = sessionManager.GetProductoTemporal();
//        //        if (modelo == null || modelo.EstrategiaID == 0 || _ofertaPersonalizadaProvider.EsCampaniaFalsa(modelo.CampaniaID) ||
//        //            modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
//        //        {
//        //            return RedirectToAction("Index", "Ofertas", new { area = esMobile ? "Mobile" : "" });
//        //        }

//        //        modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
//        //        modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();

//        //        var EstrategiaDetalle = EstrategiaGetDetalle(modelo.EstrategiaID);
//        //        if (EstrategiaDetalle.Hermanos != null)
//        //        {
//        //            modelo.Hermanos = EstrategiaDetalle.Hermanos;
//        //        }

//        //        if (modelo.CodigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos)
//        //        {
//        //            if ((modelo.Hermanos.Any()))
//        //            {
//        //                modelo.ClaseBloqueada = "btn_desactivado_general";
//        //            }
//        //        }
//        //        else if (modelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || modelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
//        //        {
//        //            if (modelo.Hermanos != null && modelo.Hermanos.Any())
//        //            {
//        //                if (modelo.Hermanos[0].Digitable == 1 && modelo.Hermanos[0].Hermanos.Any())
//        //                {
//        //                    modelo.ClaseBloqueada = "btn_desactivado_general";
//        //                }
//        //            }
//        //        }

//        //        modelo.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(esMobile);

//        //        ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
//        //        ViewBag.Campania = campaniaId;

//        //        return View(modelo);
//        //    }
//        //    catch (Exception ex)
//        //    {
//        //        logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "BaseLanzamientosController.Detalle");
//        //        throw;
//        //    }
//        //}
//    }
//}