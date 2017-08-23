using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCDR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
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
                listaCDRWebModel = new List<CDRWebModel>();
            }

            string urlPoliticaCdr = ConfigurationManager.AppSettings.Get("UrlPoliticasCDR") ?? "{0}";
            model.UrlPoliticaCdr = string.Format(urlPoliticaCdr, userData.CodigoISO);
            model.ListaCDRWeb = listaCDRWebModel.FindAll(p => p.CantidadDetalle > 0);
            model.MensajeGestionCdrInhabilitada = "";// MensajeGestionCdrInhabilitadaYChatEnLinea();

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
            return View();
        }
    }
}