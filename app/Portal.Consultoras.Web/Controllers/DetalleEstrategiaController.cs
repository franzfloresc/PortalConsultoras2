﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Controllers
{
    public class DetalleEstrategiaController : BaseViewController
    {
        public DetalleEstrategiaController() : base()
        {

        }

        public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider, OfertaViewProvider ofertaViewProvider)
            : base(sesionManager, logManager, ofertaPersonalizadaProvider, ofertaViewProvider)
        {
        }

        public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager, EstrategiaComponenteProvider estrategiaComponenteProvider)
            : base(sesionManager, logManager, estrategiaComponenteProvider)
        {
        }

        public override ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            try
            {
                var url = (Request.Url.Query).Split('?');
                if (EsDispositivoMovil()
                    && url.Length > 1
                    && url[1].Contains("sap")
                    && url[1].Contains("VC"))
                {
                    string sap = "&" + url[1].Substring(3);
                    return RedirectToAction("Ficha", "DetalleEstrategia", new { area = "Mobile", palanca, campaniaId, cuv, origen, sap });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return base.Ficha(palanca, campaniaId, cuv, origen);
            
        }

        public JsonResult ObtenerModelo(string palanca, int campaniaId, string cuv, string origen)
        {
            try
            {
                var modelo = FichaModelo(palanca, campaniaId, cuv, origen);
                return Json(new
                {
                    success = true,
                    data = modelo
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ObtenerComponentes(string estrategiaId, string cuv2, string campania, string codigoVariante, string codigoEstrategia = "", List<EstrategiaComponenteModel> lstHermanos = null)
        {
            try
            {
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    EstrategiaID = estrategiaId.ToInt(),
                    CUV2 = cuv2,
                    CampaniaID = campania.ToInt(),
                    CodigoVariante = codigoVariante,
                    Hermanos = lstHermanos
                };

                bool esMultimarca = false;
                string mensaje = "";
                var componentes = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, codigoEstrategia, out esMultimarca, out mensaje);

                return Json(new
                {
                    success = true,
                    esMultimarca,
                    componentes,
                    mensaje
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}