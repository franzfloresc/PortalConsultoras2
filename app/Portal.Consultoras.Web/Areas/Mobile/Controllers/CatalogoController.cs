﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web;
using System.Web.Caching;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class CatalogoController : BaseMobileController
    {
        private readonly IssuuProvider _issuuProvider;
        private readonly ConfiguracionPaisDatosProvider _configuracionPaisDatosProvider;
        public CatalogoController()
        {
            _issuuProvider = new IssuuProvider();
            _configuracionPaisDatosProvider = new ConfiguracionPaisDatosProvider();
        }

        public ActionResult Index(string marca = "")
        {

            ViewBag.MarcaCatalogo = marca;

            var clienteModel = new MisCatalogosRevistasModel
            {
                PaisNombre = Util.GetPaisNombreByISO(userData.CodigoISO),
                CampaniaActual = userData.CampaniaID.ToString(),
                CampaniaAnterior = Util.AddCampaniaAndNumero(userData.CampaniaID, -1, userData.NroCampanias).ToString(),
                CampaniaSiguiente = Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias).ToString(),
                TieneSeccionRD = (revistaDigital.TieneRDC && !userData.TieneGND && !revistaDigital.EsSuscrita) || revistaDigital.TieneRDI,
                TieneSeccionRevista = !revistaDigital.TieneRDC || !revistaDigital.EsActiva,
                TieneGND = userData.TieneGND
            };
            clienteModel.MostrarTab = clienteModel.TieneSeccionRD || clienteModel.TieneSeccionRevista;
            clienteModel.Titulo = clienteModel.TieneSeccionRD || clienteModel.TieneSeccionRevista ? "MIS CATÁLOGOS Y REVISTAS" : "MIS CATÁLOGOS";

            clienteModel.CodigoRevistaActual = _issuuProvider.GetRevistaCodigoIssuu(clienteModel.CampaniaActual, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            clienteModel.CodigoRevistaAnterior = _issuuProvider.GetRevistaCodigoIssuu(clienteModel.CampaniaAnterior, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            clienteModel.CodigoRevistaSiguiente = _issuuProvider.GetRevistaCodigoIssuu(clienteModel.CampaniaSiguiente, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);

            clienteModel.PartialSectionBpt = _configuracionPaisDatosProvider.GetPartialSectionBptModel(Constantes.OrigenPedidoWeb.SectionBptMobileCatalogo);
            ViewBag.EsConsultoraNueva = userData.EsConsultoraNueva;

            bool paisesCatalogoWhatsUp = _configuracionManagerProvider.GetConfiguracionManagerContains(Constantes.ConfiguracionManager.PaisesCatalogoWhatsUp, userData.CodigoISO);
            ViewBag.ActivacionAppCatalogoWhastUp = paisesCatalogoWhatsUp.ToInt();

            var paisesEsika = _configuracionManagerProvider.GetPaisesEsikaFromConfig().ToLower();
            ViewBag.EsPaisEsika = paisesEsika.Contains(userData.CodigoISO.ToLower());

            return View(clienteModel);
        }

        public ActionResult EnterateMas()
        {
            return View("EnterateMas");
        }

        public JsonResult AutocompleteCorreo()
        {
            var term = (Request["term"] ?? "").ToString();
            var lista = SessionManager.GetClientesByConsultora() ?? new List<BECliente>();
            if (!lista.Any())
            {
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lista = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }
                lista.Update(c => { c.Nombre = c.Nombre.Trim(); c.eMail = c.eMail.Trim(); });
                SessionManager.SetClientesByConsultora(lista);
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
        public ActionResult MiRevista(string campaniaRevista)
        {
            ViewBag.Campania = campaniaRevista;
            return View();
        }
        [HttpPost]
        public async Task<JsonResult> ObtenerPortadaRevista(string codigoRevista)
        {
            string url;
            var urlNotFound = Url.Content("~/Content/Images/revista_no_disponible.jpg");

            try
            {
                codigoRevista = _issuuProvider.GetRevistaCodigoIssuuRDR(codigoRevista, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
                url = await _issuuProvider.GetUrlThumbnail(userData.CodigoISO, codigoRevista);
                if (string.IsNullOrEmpty(url))
                    url = urlNotFound;
                else
                {

                    HttpContext.Response.Cache.SetCacheability(HttpCacheability.Server); 
                    HttpContext.Response.Cache.SetExpires(DateTime.Now.AddDays(1)); 
                    HttpContext.Response.Cache.SetValidUntilExpires(true);
                    HttpContext.Response.Cache.VaryByParams["*"] = true;

                }
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
    }
}