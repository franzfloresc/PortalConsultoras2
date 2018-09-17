using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
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
        private readonly IssuuProvider _issuuProvider;

        public CatalogoController()
        {
            _issuuProvider = new IssuuProvider();
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

            clienteModel.PartialSectionBpt = GetPartialSectionBptModel();

            ViewBag.CodigoISO = userData.CodigoISO;
            ViewBag.EsConsultoraNueva = userData.EsConsultoraNueva;
            ViewBag.TextoMensajeSaludoCorreo = TextoMensajeSaludoCorreo;

            string paisesCatalogoWhatsUp = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesCatalogoWhatsUp);
            ViewBag.ActivacionAppCatalogoWhastUp = paisesCatalogoWhatsUp.Contains(userData.CodigoISO) ? 1 : 0;

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

        [HttpPost]
        public JsonResult ObtenerPortadaRevista(string codigoRevista)
        {
            string url;
            var urlNotFound = Url.Content("~/Content/Images/revista_no_disponible.jpg");

            try
            {
                codigoRevista = _issuuProvider.GetRevistaCodigoIssuuRDR(codigoRevista, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);

                string stringIssuuRevista = GetStringIssuRevista(codigoRevista);
                dynamic item = new JavaScriptSerializer().Deserialize<object>(stringIssuuRevista);
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

        private string GetStringIssuRevista(string codigoRevista)
        {
            string stringIssuuRevista;
            using (var client = new WebClient())
            {
                var urlIssuuRevista = string.Format("https://issuu.com/oembed?url=https://issuu.com/somosbelcorp/docs/{0}", codigoRevista);
                stringIssuuRevista = client.DownloadString(urlIssuuRevista);
            }

            return stringIssuuRevista;
        }

        public ActionResult MiRevista(string campaniaRevista)
        {
            ViewBag.Campania = campaniaRevista;
            return View();
        }

        private PartialSectionBpt GetPartialSectionBptModel()
        {
            var partial = new PartialSectionBpt();
            try
            {
                partial.RevistaDigital = revistaDigital;
                partial.TieneGND = userData.TieneGND;

                if (revistaDigital.TieneRDC)
                {
                    if (revistaDigital.EsActiva)
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoNoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                    else
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.MCatalogoNoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                }
                else if (revistaDigital.TieneRDI)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RDI.MCatalogoIntriga) ?? new ConfiguracionPaisDatosModel();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, (userData ?? new UsuarioModel()).CodigoConsultora, (userData ?? new UsuarioModel()).CodigoISO);
            }

            return partial;
        }
    }
}