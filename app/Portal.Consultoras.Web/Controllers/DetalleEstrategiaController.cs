﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models.DetalleEstrategia;
using System.Linq;

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

        [HttpGet]
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

        [HttpPost]
        public JsonResult ObtenerModelo(string palanca, int campaniaId, string cuv, string origen, bool esEditable = false)
        {
            try
            {
                var modelo = FichaModelo(palanca, campaniaId, cuv, origen, esEditable);

                if (modelo != null)
                {
                    return Json(new
                    {
                        success = !modelo.Error,
                        data = modelo
                    }, JsonRequestBehavior.AllowGet);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                success = false
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
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

        [HttpPost]
        //public JsonResult ObtenerComponenteDetalle(string estrategiaId, string cuv2, string campania, string codigoVariante, string codigoEstrategia = "")
        public JsonResult ObtenerComponenteDetalle(string estrategiaId, string cuv2, string campaniaId, string codigoVariante, string codigoEstrategia)

        {
            try
            {                  
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    EstrategiaID = estrategiaId.ToInt(),
                    CUV2 = cuv2,
                    CampaniaID = campaniaId.ToInt(),
                    CodigoVariante = codigoVariante,
                    Hermanos = null
                };

                bool esMultimarca = false;
                string mensaje = "";
                List<EstrategiaComponenteSeccionModel> secciones;

                EstrategiaPersonalizadaProductoModel res = _estrategiaComponenteProvider.GetListaComponenteDetalle(estrategiaModelo, codigoEstrategia, out esMultimarca, out mensaje).FirstOrDefault();

                #region Desde Product Api
                //secciones = res.Secciones;
                #endregion

                #region desde data tmp
                secciones = new List<EstrategiaComponenteSeccionModel>(){
                new EstrategiaComponenteSeccionModel()
                {
                    Titulo = "Modo de uso",
                    Detalles = new List<EstrategiaComponenteSeccionDetalleModel>() { new EstrategiaComponenteSeccionDetalleModel { Titulo = "modo uso 1", Descripcion = "valor 1", Key = "" } }
                },
                new EstrategiaComponenteSeccionModel()
                {
                    Titulo = "Descubre más",
                    Detalles = new List<EstrategiaComponenteSeccionDetalleModel>() { new EstrategiaComponenteSeccionDetalleModel { Titulo = "Descubre más 1", Descripcion = "valor 1", Key = "" } }
                },
                new EstrategiaComponenteSeccionModel()
                {
                    Titulo = "Tips de venta",
                    Detalles = new List<EstrategiaComponenteSeccionDetalleModel>() { new EstrategiaComponenteSeccionDetalleModel { Titulo = "Tips de venta 1", Descripcion = "valor 1", Key = "" } }
                },
                new EstrategiaComponenteSeccionModel()
                {
                    Titulo = "Videos",
                    Detalles = new List<EstrategiaComponenteSeccionDetalleModel>() {
                        new EstrategiaComponenteSeccionDetalleModel { Titulo = "Videos 1", Descripcion = "", Key = "https://www.youtube.com/watch?v=M4V0Tkim7PA" },
                        new EstrategiaComponenteSeccionDetalleModel { Titulo = "Videos 2", Descripcion = "", Key = "https://www.youtube.com/embed/_UwWYtLWEZg" }
                    }
                }
                };
                #endregion

                secciones.ForEach(x => { x.EsVideos = x.Detalles.FindAll(y => !string.IsNullOrEmpty(y.Key)).Count > 0; });

                //EAAR: consumir servicio de juanjo

                return Json(new
                {
                    success = true,
                    data = secciones,
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