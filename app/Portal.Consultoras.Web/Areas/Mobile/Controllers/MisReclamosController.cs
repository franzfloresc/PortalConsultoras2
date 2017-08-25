using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCDR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using System.ServiceModel;

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
                listaCDRWebModel = new List<CDRWebModel>();
            }

            string urlPoliticaCdr = ConfigurationManager.AppSettings.Get("UrlPoliticasCDR") ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.ListaCDRWeb = listaCDRWebModel.FindAll(p => p.CantidadDetalle > 0);
            model.MensajeGestionCdrInhabilitada =  MensajeGestionCdrInhabilitadaYChatEnLinea();

            if (!string.IsNullOrEmpty(model.MensajeGestionCdrInhabilitada)) return View(model);
            if (model.ListaCDRWeb.Count == 0) return RedirectToAction("Reclamo");
            return View(model);
        }

        public ActionResult Reclamo()
        {
            return View();
        }

        public ActionResult Detalle()
        {
            //try
            //{
            //    if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MisReclamos/Detalle"))
            //        return RedirectToAction("Index", "MisReclamos", new { area = "Mobile" });
            //}
            //catch (FaultException ex)
            //{
            //    LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            //}



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
    }
}