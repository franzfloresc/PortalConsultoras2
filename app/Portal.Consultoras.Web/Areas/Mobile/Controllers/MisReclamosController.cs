using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCDR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MisReclamosController : BaseMobileController
    {
        public ActionResult Index()
        {
            if (userData.TieneCDR == 0) return RedirectToAction("Index", "Bienvenida");
            MisReclamosModel model = new MisReclamosModel();
            var listaCDRWebModel = new List<CDRWebModel>();

            try
            {
                using (CDRServiceClient cdr = new CDRServiceClient())
                {
                    var beCdrWeb = new BECDRWeb();
                    beCdrWeb.ConsultoraID = userData.ConsultoraID;

                    var listaReclamo = cdr.GetCDRWebMobile(userData.PaisID, beCdrWeb).ToList();
                    listaCDRWebModel = Mapper.Map<List<BECDRWeb>, List<CDRWebModel>>(listaReclamo);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaCDRWebModel = new List<CDRWebModel>();
            }

            string urlPoliticaCdr = ConfigurationManager.AppSettings.Get("UrlPoliticasCDR") ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.ListaCDRWeb = listaCDRWebModel.FindAll(p => p.CantidadDetalle > 0);
            model.MensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitadaYChatEnLinea();

            if (!string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return View(model);
            if (model.ListaCDRWeb.Count == 0) return RedirectToAction("Reclamo");
            return View(model);
        }

        public ActionResult Reclamo(int pedidoId = 0)
        {
            var model = new MisReclamosModel { PedidoID = pedidoId };
            model.MensajeGestionCdrInhabilitada = MensajeGestionCdrInhabilitadaYChatEnLinea();
            if (pedidoId == 0 && !string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return RedirectToAction("Index");

            CargarInformacion();
            model.ListaCampania = (List<CampaniaModel>)Session[Constantes.ConstSession.CDRCampanias];
            if (model.ListaCampania.Count <= 1) return RedirectToAction("Index");

            if (pedidoId != 0)
            {
                var listaCdr = CargarBECDRWeb(new MisReclamosModel { PedidoID = pedidoId });
                if (listaCdr.Count == 0) return RedirectToAction("Index");

                if (listaCdr.Count == 1)
                {
                    model.CampaniaID = listaCdr[0].CampaniaID;
                    model.CDRWebID = listaCdr[0].CDRWebID;
                    model.NumeroPedido = listaCdr[0].PedidoNumero;
                }
            }

            string urlPoliticaCdr = ConfigurationManager.AppSettings.Get("UrlPoliticasCDR") ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.Email = userData.EMail;
            model.Telefono = userData.Celular;
            model.MontoMinimo = userData.MontoMinimo;

            #region CDR_Express
            //EPD-1919
            //model.TieneCDRExpress = userData.TieneCDRExpress;
            //model.EsConsultoraNueva = userData.EsConsecutivoNueva;
            //model.FleteDespacho = GetValorFleteExpress();
            //model.MensajesExpress = new MensajesCDRExpressModel
            //{
            //    RegularPrincipal = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.RegularPrincipal),
            //    RegularAdicional = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.RegularAdicional),
            //    ExpressPrincipal = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressPrincipal),
            //    ExpressAdicional = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.ExpressAdicional),
            //    Nuevas = GetMensajeCDRExpress(Constantes.MensajesCDRExpress.Nuevas)
            //};
            //model.MensajesExpress.ExpressFlete = SetMensajeFleteExpress(model.FleteDespacho);
            #endregion

            if (userData.PaisID == 9)
            {
                model.limiteMinimoTelef = 5;
                model.limiteMaximoTelef = 15;
            }
            else if (userData.PaisID == 11)
            {
                model.limiteMinimoTelef = 7;
                model.limiteMaximoTelef = 9;
            }
            else if (userData.PaisID == 4)
            {
                model.limiteMinimoTelef = 10;
                model.limiteMaximoTelef = 10;
            }
            else if (userData.PaisID == 8 || userData.PaisID == 7 || userData.PaisID == 10 || userData.PaisID == 5)
            {
                model.limiteMinimoTelef = 8;
                model.limiteMaximoTelef = 8;
            }
            else if (userData.PaisID == 6)
            {
                model.limiteMinimoTelef = 9;
                model.limiteMaximoTelef = 10;
            }
            else
            {
                model.limiteMinimoTelef = 0;
                model.limiteMaximoTelef = 15;
            }

            return View(model);
        }

        public ActionResult DetalleCDRCulminado(long SolicitudId)
        {

            var cdrWeb = new BECDRWeb();
            var listaCdrWebDetalle = new List<BECDRWebDetalle>();
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                cdrWeb = sv.GetCDRWebByLogCDRWebCulminadoId(userData.PaisID, SolicitudId);

                listaCdrWebDetalle = sv.GetCDRWebDetalleByLogCDRWebCulminadoId(userData.PaisID, SolicitudId).ToList() ?? new List<BECDRWebDetalle>();
                listaCdrWebDetalle.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado).Descripcion);
                listaCdrWebDetalle.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado).Descripcion);
            }

            var model = Mapper.Map<CDRWebModel>(cdrWeb);
            model.CodigoIso = userData.CodigoISO;
            model.NombreConsultora = userData.NombreConsultora;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;
            model.OrigenCDRDetalle = "1";
            if (model.FechaCulminado.HasValue)
            {
                model.FormatoFechaCulminado = string.Format("{0}/{1}/{2}",
                model.FechaCulminado.Value.Day.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Month.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Year);
            }
            model.FormatoCampaniaID = string.Format("{0}-{1}",
            model.CampaniaID.ToString().Substring(0, 4),
            model.CampaniaID.ToString().Substring(4, 2));
            model.CantidadAprobados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Aceptado);
            model.CantidadRechazados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Observado);

            Session["ListaCDRDetalle"] = model;
            return RedirectToAction("Detalle");
        }

        public ActionResult DetalleCDR(long solicitudId)
        {
            BELogCDRWeb logCdrWeb = new BELogCDRWeb();
            var listaCdrWebDetalle = new List<BECDRWebDetalle>();
            using (CDRServiceClient sv = new CDRServiceClient())
            {
                logCdrWeb = sv.GetLogCDRWebByLogCDRWebId(userData.PaisID, solicitudId);

                listaCdrWebDetalle = sv.GetCDRWebDetalleLog(userData.PaisID, logCdrWeb).ToList() ?? new List<BECDRWebDetalle>();
                listaCdrWebDetalle.Update(p => p.Solicitud = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.Finalizado).Descripcion);
                listaCdrWebDetalle.Update(p => p.SolucionSolicitada = ObtenerDescripcion(p.CodigoOperacion, Constantes.TipoMensajeCDR.MensajeFinalizado).Descripcion);
            }

            var model = Mapper.Map<CDRWebModel>(logCdrWeb);
            model.NombreConsultora = userData.NombreConsultora;
            model.CodigoIso = userData.CodigoISO;
            model.Simbolo = userData.Simbolo;
            model.ListaDetalle = listaCdrWebDetalle;
            model.OrigenCDRDetalle = "1";
            if (model.FechaCulminado.HasValue)
            {
                model.FormatoFechaCulminado = string.Format("{0}/{1}/{2}",
                model.FechaCulminado.Value.Day.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Month.ToString().PadLeft(2, '0'),
                model.FechaCulminado.Value.Year);
            }
            model.FormatoCampaniaID = string.Format("{0}-{1}",
            model.CampaniaID.ToString().Substring(0, 4),
            model.CampaniaID.ToString().Substring(4, 2));
            model.CantidadAprobados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Aceptado);
            model.CantidadRechazados = listaCdrWebDetalle.Count(f => f.Estado == Constantes.EstadoCDRWeb.Observado);

            Session["ListaCDRDetalle"] = model;
            return RedirectToAction("Detalle");
        }

        public ActionResult Detalle()
        {
            var objCDR = Session["ListaCDRDetalle"] as CDRWebModel;

            MisReclamosModel obj = new MisReclamosModel();
            obj.CDRWebID = objCDR.CDRWebID;
            obj.PedidoID = objCDR.PedidoID;

            Session[Constantes.ConstSession.CDRWebDetalle] = null;
            objCDR.ListaDetalle = CargarDetalle(obj);

            ViewBag.Origen = objCDR.OrigenCDRDetalle;
            ViewBag.FormatoCampania = objCDR.FormatoCampaniaID;
            ViewBag.FormatoFechaCulminado = objCDR.FormatoFechaCulminado;
            string estadoAprobado = objCDR.CantidadAprobados == 1 ? objCDR.CantidadAprobados + " producto aprobado, " : objCDR.CantidadAprobados + " productos aprobados, ";
            string estadoRechazado = objCDR.CantidadRechazados == 1 ? objCDR.CantidadRechazados + " rechazado" : objCDR.CantidadRechazados + " rechazados";

            ViewBag.EstadoProductos = estadoAprobado + estadoRechazado;
            ViewBag.CDR_ID = objCDR.CDRWebID;
            ViewBag.Simbolo = userData.Simbolo;
            ViewBag.ListaDetalle = objCDR.ListaDetalle;
            return View();
        }

        public JsonResult ValidarCargaDetalle(CDRWebModel model)
        {
            try
            {
                if (model.OrigenCDRDetalle == "1")
                {
                    Session["ListaCDRDetalle"] = model;
                }
                return Json(new
                {
                    success = true,
                    message = "OK"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Error: " + ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult BuscarMotivo(MisReclamosModel model)
        {
            var lista = CargarMotivo(model);
            return Json(new
            {
                success = true,
                message = "",
                detalle = lista
            }, JsonRequestBehavior.AllowGet);
        }
    }
}