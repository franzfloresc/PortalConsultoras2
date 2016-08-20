using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServicePedido;
using AutoMapper;
using Portal.Consultoras.Common;
using System.IO;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Controllers
{
    public class LugaresPagoController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "LugaresPago/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var lugaresPagoModel = GetLugarPago();

                return View("_Index", lugaresPagoModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View("_Index", new LugaresPagoModel());
        }
        
        private LugaresPagoModel GetLugarPago()
        {
            List<BELugarPago> lst;
            int paisID = userData.PaisID;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = (sv.SelectLugarPago(paisID) ?? new BELugarPago[0]).ToList();
            }

            string iso = userData.CodigoISO;
            var carpetaPais = Globals.UrlLugaresPago + "/" + iso;
            if (lst.Any())
                lst.Update(x => x.ArchivoLogo = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoLogo, Globals.RutaImagenesLugaresPago + "/" + iso));

            var lugaresPagoModel = new LugaresPagoModel()
            {
                PaisID = paisID,
                CampaniaID = userData.CampaniaID,
                ISO = iso,
                listaLugaresPago = lst
            };

            return lugaresPagoModel;
        }

    }
}
