using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoController : BaseMobileController
    {
        private const string TextoMensajeSaludoCorreo = "Revisa los catálogos de esta campaña y comunícate conmigo si estás interesada en algunos de los productos.";

        public ActionResult Index()
        {
            var clienteModel = new MisCatalogosRevistasModel();
            clienteModel.PaisID = userData.PaisID;
            clienteModel.CodigoZona = userData.CodigoZona; //R20160204
            clienteModel.CampaniaActual = userData.CampaniaID.ToString();
            clienteModel.CampaniaAnterior = CalcularCampaniaAnterior(clienteModel.CampaniaActual);
            clienteModel.CampaniaSiguiente = CalcularCampaniaSiguiente(clienteModel.CampaniaActual);
            clienteModel.CodigoRevistaActual = GetRevistaCodigoIssuu(clienteModel.CampaniaActual);
            clienteModel.CodigoRevistaAnterior = GetRevistaCodigoIssuu(clienteModel.CampaniaAnterior);
            clienteModel.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(clienteModel.CampaniaSiguiente);

            ViewBag.CodigoISO = userData.CodigoISO;
            ViewBag.EsConsultoraNueva = userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Registrada ||
                userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Retirada;

            string PaisesCatalogoWhatsUp = ConfigurationManager.AppSettings.Get("PaisesCatalogoWhatsUp") ?? string.Empty;
            ViewBag.ActivacionAppCatalogoWhastUp = PaisesCatalogoWhatsUp.Contains(userData.CodigoISO) ? 1 : 0;

            ViewBag.TextoMensajeSaludoCorreo = TextoMensajeSaludoCorreo;

            return View(clienteModel);
        }

        public ActionResult EnterateMas()
        {
            return View("EnterateMas");
        }

        private string CalcularCampaniaAnterior(string CampaniaActual)
        {
            if (CampaniaActual.Substring(4, 2) == "01")
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) - 1) + UserData().NroCampanias.ToString();
            return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(CampaniaActual.Substring(4, 2)) - 1).ToString().PadLeft(2, '0');
        }

        private string CalcularCampaniaSiguiente(string CampaniaActual)
        {
            if (CampaniaActual.Substring(4, 2) == UserData().NroCampanias.ToString())
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) + 1) + "01";
            return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(CampaniaActual.Substring(4, 2)) + 1).ToString().PadLeft(2, '0');
        }

        public JsonResult AutocompleteCorreo()
        {
            var term = (Request["term"] ?? "").ToString();
            List<BECliente> lista = new List<BECliente>();
            lista = (List<BECliente>)Session[Constantes.ConstSession.ClientesByConsultora] ?? new List<BECliente>();
            if (!lista.Any())
            {
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lista = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }
                lista.Update(c => { c.Nombre = c.Nombre.Trim(); c.eMail = c.eMail.Trim(); });
                Session[Constantes.ConstSession.ClientesByConsultora] = lista;
            }
            lista = lista.Where(c => c.eMail.Contains(term)).ToList();

            var data = lista.Select(c =>
                new
                {
                    value = c.eMail,
                    label = c.eMail,
                    email = c.eMail,
                    nombre = c.Nombre,
                    clienteID = c.ClienteID,
                });

            return Json(data, JsonRequestBehavior.AllowGet);
        }
		
        [HttpPost]


        public JsonResult ObtenerPortadaRevista(string codigoRevista)
        {
            var url = string.Empty;
            var urlNotFound = Url.Content("~/Content/Images/revista_no_disponible.jpg");

            try
            {
                WebClient client = new WebClient();
                string getString = client.DownloadString(string.Format("https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/{0}", codigoRevista));
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                dynamic item = serializer.Deserialize<object>(getString);
                url = item["thumbnail_url"];
            }
            catch (FaultException faulException)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(faulException, userData.CodigoConsultora, userData.CodigoISO + " - " + "ObtenerPortadaRevista");
                url = urlNotFound;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO + " - " + "ObtenerPortadaRevista");
                url = urlNotFound;
            }

            return Json(url);
        }

        public ActionResult MiRevista(string campaniaRevista)
        {
            ViewBag.Campania = campaniaRevista;
            return View();
        }
    }
}