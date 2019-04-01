using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using Portal.Consultoras.Web.Models.DetalleEstrategia;

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
        public JsonResult ObtenerComponenteDetalle(string cuv)

        {
            try
            {

                bool esMultimarca = false;
                string mensaje = "";

                ComponenteDetalleModel res = new ComponenteDetalleModel();

                res.Marca = "Marca 1";
                res.Descripcion = "Descripción 1";
                res.UnidadMedida = new List<string>() { "10 gr", "11 x 12 x 13 milimentos" };
                res.Moneda = "s/";
                res.PrecioCliente = 100.38;

                res.ModoUso = new List<SeccionComponenteDetalle>() { new SeccionComponenteDetalle { Titulo = "Titulo modo uso 1", Valor = "descripción de modo de uso 1" }, new SeccionComponenteDetalle { Titulo = "Titulo modo uso 2", Valor = "descripción de modo de uso 2" } };
                res.DescubreMas = new List<SeccionComponenteDetalle>() { new SeccionComponenteDetalle { Titulo = "Titulo descubre´más 1", Valor = "descripción de descubre más 1" }, new SeccionComponenteDetalle { Titulo = "Titulo descubre´más 2", Valor = "descripción de descubre más 2" } };
                res.TipVenta = new List<SeccionComponenteDetalle>() { new SeccionComponenteDetalle { Titulo = "titulo tip de venta 1", Valor = "descripcion de tip de venta 1" }, new SeccionComponenteDetalle { Titulo = "titulo tip de venta 2", Valor = "descripcion de tip de venta 2" } };
                res.Video = new List<SeccionComponenteDetalle>() { new SeccionComponenteDetalle { Titulo = "titulo de video 1", Valor = "ulr 1" }, new SeccionComponenteDetalle { Titulo = "titulo video 2", Valor = "url 2" } };

                //EAAR: consumir servicio de juanjo

                return Json(new
                {
                    success = true,
                    data = res,
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