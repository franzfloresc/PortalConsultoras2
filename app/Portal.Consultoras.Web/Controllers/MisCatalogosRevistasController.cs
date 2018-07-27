using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisCatalogosRevistasController : BaseController
    {
        private const string TextoMensajeSaludoCorreo = "Revisa los catálogos de esta campaña y comunícate conmigo si estás interesada en algunos de los productos.";
        private readonly IssuuProvider _issuuProvider;

        public MisCatalogosRevistasController()
        {
            _issuuProvider = new IssuuProvider();
        }

        public ActionResult Index()
        {
            if (EsDispositivoMovil())
            {
                return RedirectToAction("Index", "Catalogo", new { area = "Mobile" });
            }

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
            clienteModel.Titulo = clienteModel.TieneSeccionRD || clienteModel.TieneSeccionRevista ? "Catálogos y Revistas" : "Catálogos";

            clienteModel.CodigoRevistaActual = _issuuProvider.GetRevistaCodigoIssuu(clienteModel.CampaniaActual, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            clienteModel.CodigoRevistaAnterior = _issuuProvider.GetRevistaCodigoIssuu(clienteModel.CampaniaAnterior, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
            clienteModel.CodigoRevistaSiguiente = _issuuProvider.GetRevistaCodigoIssuu(clienteModel.CampaniaSiguiente, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);

            clienteModel.PartialSectionBpt = GetPartialSectionBptModel();

            ViewBag.CodigoISO = userData.CodigoISO;
            ViewBag.EsConsultoraNueva = userData.EsConsultoraNueva;
            ViewBag.TextoMensajeSaludoCorreo = TextoMensajeSaludoCorreo;
            return View(clienteModel);
        }

        public JsonResult Detalle(int campania)
        {
            List<BECatalogoConfiguracion> lstCatalogoConfiguracion;
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lstCatalogoConfiguracion = sv.GetCatalogoConfiguracion(userData.PaisID).ToList();
            }

            List<Catalogo> listCatalogo = this.GetCatalogosPublicados(userData.CodigoISO, campania.ToString());

            campania = campania <= 0 ? userData.CampaniaID : campania;
            string estadoLbel = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.LBel), campania);
            string estadoEsika = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.Esika), campania);
            string estadoCyzone = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.Cyzone), campania);
            string estadoFinart = CampaniaInicioFin(lstCatalogoConfiguracion.FirstOrDefault(l => l.MarcaID == (int)Enumeradores.TypeMarca.Finart), campania);
            string catalogoUnificado = "0";

            if (EsCatalogoUnificado(campania))
            {
                estadoEsika = "1";
                catalogoUnificado = "1";
            }

            var data = new
            {
                estadoLbel = estadoLbel,
                estadoEsika = estadoEsika,
                estadoCyzone = estadoCyzone,
                estadoFinart = estadoFinart,
                catalogoUnificado = catalogoUnificado,
                listCatalogo
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public List<Catalogo> GetCatalogosPublicados(string paisIso, string campaniaId)
        {
            List<Catalogo> catalogos = new List<Catalogo>();
            string urlIssuuSearch = "http:" + Constantes.CatalogoUrlIssu.Buscador;
            string urlIssuuVisor = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlIssuu);

            try
            {
                string catalogoLbel = _issuuProvider.GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.LBel, userData.CodigoISO, userData.CodigoZona);
                string catalogoEsika = _issuuProvider.GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Esika, userData.CodigoISO, userData.CodigoZona);
                string catalogoCyzone = _issuuProvider.GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Cyzone, userData.CodigoISO, userData.CodigoZona);
                string catalogoFinart = _issuuProvider.GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Finart, userData.CodigoISO, userData.CodigoZona);

                var url = urlIssuuSearch +
                    "docname:" + catalogoLbel + "+OR+" +
                    "docname:" + catalogoEsika + "+OR+" +
                    "docname:" + catalogoCyzone + "+OR+" +
                    "docname:" + catalogoFinart + "&jsonCallback=?";

                string response = "";
                using (var wc = new WebClient())
                {
                    using (Stream myStream = wc.OpenRead(new Uri(url)))
                    {
                        if (myStream != null)
                        {
                            using (StreamReader streamReader = new StreamReader(myStream))
                            {
                                response = streamReader.ReadToEnd();
                            }
                        }
                    }
                }

                if (response.Substring(0, 2) == "?(") response = response.Substring(2, response.Length - 3);
                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                var jsonReponse = javaScriptSerializer.Deserialize<dynamic>(response);

                foreach (var doc in jsonReponse["response"]["docs"])
                {
                    string docName = doc["docname"], documentId = doc["documentId"];

                    if (docName == catalogoLbel) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.LBel, marcaCatalogo = "LBel", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                    else if (docName == catalogoEsika) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Esika, marcaCatalogo = "Esika", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                    else if (docName == catalogoCyzone) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Cyzone, marcaCatalogo = "Cyzone", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                    else if (docName == catalogoFinart) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Finart, marcaCatalogo = "Finart", DocumentID = documentId, SkinURL = string.Format(urlIssuuVisor, docName) });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                catalogos = new List<Catalogo>();
            }
            return catalogos;
        }

        public JsonResult AutocompleteCorreo()
        {
            var term = (Request["term"] ?? "").ToString();
            var lista = sessionManager.GetClientesByConsultora() ?? new List<BECliente>();
            if (!lista.Any())
            {
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lista = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }
                lista.Update(c => { c.Nombre = c.Nombre.Trim(); c.eMail = c.eMail.Trim(); });
                lista = lista.Where(c => c.eMail != "").ToList();
                sessionManager.SetClientesByConsultora(lista);
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
        public JsonResult EnviarEmail(List<CatalogoClienteModel> ListaCatalogosCliente, string Mensaje, string Campania)
        {
            try
            {
                List<Catalogo> catalogos;
                string campaniaId;
                string fechaFacturacion;
                try
                {
                    if (Campania == userData.CampaniaID.ToString())
                    {
                        campaniaId = userData.CampaniaID.ToString();

                        if (!userData.DiaPROL) fechaFacturacion = userData.FechaFacturacion.ToShortDateString();
                        else
                        {
                            DateTime fechaHoraActual = DateTime.Now.AddHours(userData.ZonaHoraria);
                            if (userData.DiasCampania != 0 && fechaHoraActual < userData.FechaInicioCampania)
                            {
                                fechaFacturacion = userData.FechaInicioCampania.ToShortDateString();
                            }
                            else
                            {
                                fechaFacturacion = fechaHoraActual.ToShortDateString();
                            }
                        }
                    }
                    else
                    {
                        campaniaId = Campania;
                        using (UsuarioServiceClient sv = new UsuarioServiceClient())
                        {
                            fechaFacturacion = sv.GetFechaFacturacion(campaniaId, userData.ZonaID, userData.PaisID).ToShortDateString();
                        }
                    }

                    catalogos = this.GetCatalogosPublicados(userData.CodigoISO, campaniaId);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    return Json(new
                    {
                        success = false,
                        message = "Por favor vuelva ingresar en unos momentos, ya que el servicio de catálogos virtuales está teniendo problemas.",
                        extra = string.Empty
                    });
                }

                if (catalogos.Count <= 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se pudo realizar el envió de correos a lo(s) clientes seleccionados, debido a que por ahora no existen catálogos publicados para esta Campaña.",
                        extra = ""
                    });
                }

                string rutaPublicaImagen = "";

                Catalogo catalogoLbel = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.LBel);
                Catalogo catalogoEsika = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Esika);
                Catalogo catalogoCyZone = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Cyzone);

                DateTime dd = DateTime.Parse(fechaFacturacion, new CultureInfo("es-ES"));
                string fdf = dd.ToString("dd", new CultureInfo("es-ES"));
                string fmf = dd.ToString("MMMM", new CultureInfo("es-ES"));
                string ffechaFact = fdf + " de " + char.ToUpper(fmf[0]) + fmf.Substring(1);
                string urlIssuCatalogo = string.Empty;

                string urlImagenLogo = Globals.RutaCdn + "/ImagenesPortal/Iconos/logo.png";
                string urlIconEmail = Globals.RutaCdn + "/ImagenesPortal/Iconos/mensaje_mail.png";
                string urlIconTelefono = Globals.RutaCdn + "/ImagenesPortal/Iconos/celu_mail.png";

                if (!_configuracionManagerProvider.GetPaisesEsikaFromConfig().Contains(userData.CodigoISO))
                {
                    urlImagenLogo = Globals.RutaCdn + "/ImagenesPortal/Iconos/logod.png";
                    urlIconEmail = Globals.RutaCdn + "/ImagenesPortal/Iconos/mensaje_mail_lbel.png";
                    urlIconTelefono = Globals.RutaCdn + "/ImagenesPortal/Iconos/celu_mail_lbel.png";
                }

                var txtBuil = new StringBuilder();
                foreach (var item in ListaCatalogosCliente)
                {
                    #region foreach
                    string mailBody = string.Empty;

                    mailBody += "<html>";
                    mailBody += "<body style=\"margin:0px; padding:0px; background:#FFF;\">";
                    mailBody += "<table width=\"100%\" cellspacing=\"0\" align=\"center\" style=\"background:#FFF;\">";
                    mailBody += "<thead>";
                    mailBody += "<tr>";
                    mailBody += "<th colspan=\"3\" style=\"width:100%; height:50px; border-bottom:1px solid #000; padding:12px 0px; text-align:center;\"><img src=\"" + urlImagenLogo + "\" alt=\"Logo Esika\" /></th>";
                    mailBody += "</tr>";
                    mailBody += "</thead>";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";
                    mailBody += "<td colspan=\"3\" style=\"height:30px;\"></td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td colspan=\"3\">";
                    mailBody += "<table align=\"center\" style=\"width:100%; text-align:center; padding-bottom:20px;\">";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"font-family:'Calibri'; font-size:17px; text-align:center; font-weight:500; color:#000; padding:0 0 20px 0;\">¡Hola!</td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"text-align:center; font-family:'Calibri'; font-size:22px; font-weight:700; color:#000; padding-bottom:15px;\">ENT&Eacute;RATE DE LAS NOVEDADES DE TUS CAT&Aacute;LOGOS</td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"text-align:center; font-family:'Calibri'; color:#000; font-weight:500; font-size:14px; padding-bottom:30px;\">" + (Mensaje ?? "");
                    mailBody += "<br/><br/>Recuerda que tienes hasta el " + ffechaFact + " para enviarme tu pedido.<br/><br />Si tienes alguna consulta no dudes en contactarme:</td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td>";
                    mailBody += "<table align=\"center\" style=\"text-align:center; font-size:13px; padding:0 13px; width:100%; max-width:450px;  font-family:'Calibri'; color:#000;\">";
                    mailBody += "<!--[if gte mso 9]>";
                    mailBody += "<table id=\"tableForOutlook\"><tr><td>";
                    mailBody += "<![endif]-->";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"text-align:center; width:48%;\">";

                    if (!string.IsNullOrEmpty(userData.EMail))
                    {
                        mailBody += "<img style=\"vertical-align:middle;\" src=\"" + urlIconEmail + "\" alt=\"Icono Mensaje\" /> &nbsp;" + userData.EMail;

                    }
                    mailBody += "</td>";
                    mailBody += "<td style=\"text-align:center; width:48%;\">";

                    if (!string.IsNullOrEmpty(userData.Celular))
                    {
                        mailBody += "<img style=\"vertical-align:middle;\"  src=\"" + urlIconTelefono + "\" alt=\"Icono Celular\" /> &nbsp;" + userData.Celular;
                        if (!string.IsNullOrEmpty(userData.Telefono))
                        {
                            mailBody += " / " + userData.Telefono;
                        }
                    }

                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</tbody>";
                    mailBody += "<!--[if gte mso 9]>";
                    mailBody += "</td></tr></table>";
                    mailBody += "<![endif]-->";
                    mailBody += "</table>";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td>";
                    mailBody += "<table align=\"center\" style=\"text-align:center; width:100%; max-width:500px;  font-family:'Calibri'; color:#000; padding-top:25px;\">";
                    mailBody += "<!--[if gte mso 9]>";
                    mailBody += "<table id=\"tableForOutlook\"><tr><td>";
                    mailBody += "<![endif]-->";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";

                    if (item.LBel == "1")
                    {
                        if (catalogoLbel != null && !string.IsNullOrEmpty(catalogoLbel.DocumentID))
                        {
                            rutaPublicaImagen = Constantes.CatalogoUrlParameters.UrlPart01 + catalogoLbel.DocumentID + Constantes.CatalogoUrlParameters.UrlPart03;
                            urlIssuCatalogo = catalogoLbel.SkinURL;
                        }

                        mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                        mailBody += "<a href=\"" + urlIssuCatalogo + "\" style=\"width:100%; display:block;\">";
                        mailBody += "<img width=\"100%\" display=\"block\" style=\"width:120px;height:150px\" src=\"" + rutaPublicaImagen + "\" alt=\"Revista\" />";
                        mailBody += "</a>";
                        mailBody += "</td>";
                    }

                    if (item.Esika == "1")
                    {
                        if (catalogoEsika != null && !string.IsNullOrEmpty(catalogoEsika.DocumentID))
                        {
                            rutaPublicaImagen = Constantes.CatalogoUrlParameters.UrlPart01 + catalogoEsika.DocumentID + Constantes.CatalogoUrlParameters.UrlPart03;
                            urlIssuCatalogo = catalogoEsika.SkinURL;
                        }

                        mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                        mailBody += "<a href=\"" + urlIssuCatalogo + "\" style=\"width:100%; display:block;\">";
                        mailBody += "<img width=\"100%\" display=\"block\" style=\"width:120px;height:150px\" src=\"" + rutaPublicaImagen + "\" alt=\"Revista\" />";
                        mailBody += "</a>";
                        mailBody += "</td>";
                    }

                    if (item.Cyzone == "1")
                    {
                        if (catalogoCyZone != null && !string.IsNullOrEmpty(catalogoCyZone.DocumentID))
                        {
                            rutaPublicaImagen = Constantes.CatalogoUrlParameters.UrlPart01 + catalogoCyZone.DocumentID + Constantes.CatalogoUrlParameters.UrlPart03;
                            urlIssuCatalogo = catalogoCyZone.SkinURL;
                        }

                        mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                        mailBody += "<a href=\"" + urlIssuCatalogo + "\" style=\"width:100%; display:block;\">";
                        mailBody += "<img width=\"100%\" display=\"block\" style=\"width:120px;height:150px\" src=\"" + rutaPublicaImagen + "\" alt=\"Revista\" />";
                        mailBody += "</a>";
                        mailBody += "</td>";
                    }

                    mailBody += "</tr>";

                    mailBody += "</tbody>";
                    mailBody += "<!--[if gte mso 9]>";
                    mailBody += "</td></tr></table>";
                    mailBody += "<![endif]-->";
                    mailBody += "</table>";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td colspan=\"3\" style=\"text-align:center; font-family:'Calibri'; color:#000; font-size:12px; font-weight:400;padding-top:45px; padding-bottom:27px;\"></td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td colspan=\"3\" style=\"background:#000; height:62px;\">";
                    mailBody += "<table align=\"center\" style=\"text-align:center; padding:0 13px; width:100%; max-width:550px; \">";
                    mailBody += "<!--[if gte mso 9]>";
                    mailBody += "<table id=\"tableForOutlook\"><tr><td>";
                    mailBody += "<![endif]-->";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"width:11%; text-align:left; vertical-align:top;\">";
                    mailBody += "<img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-belcorp.png\" alt=\"Logo Belcorp\" />";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:8%; text-align:left;\">";
                    mailBody += "<a href=\"http://www.esika.biz\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-esika.png\" alt=\"Logo Esika\" />";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:8%; text-align:left;\">";
                    mailBody += "<a href=\"http://www.lbel.com\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-lbel.png\" alt=\"Logo L'bel\" />";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:15%; text-align:left;border-right:1px solid #FFF;\">";
                    mailBody += "<a href=\"http://www.cyzone.com\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"" + Globals.RutaCdn + "/Correo/logo-cyzone.png\" alt=\"Logo Cyzone\" />";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:15%; font-family:'Calibri'; font-weight:400; font-size:13px; color:#FFF; vertical-align:middle;\">";
                    mailBody += "<table align=\"center\" style=\"text-align:center; width:100%;\">";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"text-align: right; font-family:'Calibri'; font-weight:400; font-size:13px; vertical-align: middle; width: 69%; color:white;\">S&Iacute;GUENOS</td>";
                    mailBody += "<td style=\"text-align: right; position: relative; top: 2px; left: 10px; width: 20%; vertical-align: top;\">";
                    mailBody += "<a href=\"https://es-la.facebook.com/SomosBelcorpOficial\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"" + Globals.RutaCdn + "/ImagenesPortal/Iconos/logo-facebook.png\" alt=\"Logo Facebook\" /></td>";
                    mailBody += "</a>";
                    mailBody += "</tr>";
                    mailBody += "</tbody>";
                    mailBody += "</table>";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</tbody>";
                    mailBody += "<!--[if gte mso 9]>";
                    mailBody += "</td></tr></table>";
                    mailBody += "<![endif]-->";
                    mailBody += "</table>";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td colspan=\"3\">";
                    mailBody += "<table align=\"center\" style=\"text-align:center; width:200px;\">";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";
                    mailBody += "<td colspan=\"2\" style=\"height:6px;\"></td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"text-align:center; width:48%; border-right:1px solid #000;\">";
                    mailBody += "<a href=\"http://comunidad.somosbelcorp.com\" style=\"width:100%; display:block;\">";
                    mailBody += "<span style=\"font-family:'Calibri'; font-size:12px; color:#000;\">¿Tienes dudas?</span>";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "<td style=\"text-align:center; width:48%;\">";
                    mailBody += "<a href=\"http://belcorpresponde.somosbelcorp.com\" style=\"width:100%; display:block;\">";
                    mailBody += "<span style=\"font-family:'Calibri'; font-size:12px; color:#000;\">Cont&aacute;ctanos</span>";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</tbody>";
                    mailBody += "</table>";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</tbody>";
                    mailBody += "</table>";
                    mailBody += "</body>";
                    mailBody += "</html>";

                    if (!ValidarCorreoFormato(item.Email)) txtBuil.Append(item.Email + "; ");
                    else Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", item.Email, "Revisa tus catálogos de campaña " + campaniaId.Substring(4, 2), mailBody, true, userData.NombreConsultora);

                    #endregion
                }

                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    sv.InsCatalogoCampania(userData.PaisID, userData.CodigoConsultora, Convert.ToInt32(campaniaId));
                }

                string correosInvalidos = txtBuil.ToString();
                return Json(new
                {
                    success = string.IsNullOrEmpty(correosInvalidos),
                    message = string.IsNullOrEmpty(correosInvalidos)
                        ? "Se envió satisfactoriamente el correo a los cliente(s) seleccionado(s)."
                        : ("Los siguientes correos no fueron enviados pues no tienen un formato correcto: " + correosInvalidos),
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        private string CampaniaInicioFin(BECatalogoConfiguracion catalogo, int campania)
        {
            string resultado = catalogo.Estado.ToString();
            if (catalogo.Estado == 2)
            {
                resultado = "1";
                if ((campania >= catalogo.CampaniaInicio && campania <= catalogo.CampaniaFin)
                    || (catalogo.CampaniaInicio != 0 && catalogo.CampaniaFin == 0 && campania >= catalogo.CampaniaInicio)
                    )
                {
                    resultado = "0";
                }
            }
            return resultado;
        }

        private bool ValidarCorreoFormato(string correo)
        {
            bool result;
            try
            {
                if (string.IsNullOrEmpty(correo))
                    return false;

                if (correo.ToLower().Contains("ñ") || correo.ToLower().Contains("á") || correo.ToLower().Contains("é") ||
                    correo.ToLower().Contains("í") || correo.ToLower().Contains("ó") || correo.ToLower().Contains("ú"))
                    return false;

                RegexUtilities emailutil = new RegexUtilities();
                if (!emailutil.IsValidEmail(correo))
                    return false;

                result = true;
            }
            catch
            {
                result = false;
            }
            return result;
        }

        public ActionResult MiRevista(string campaniaRevista)
        {
            ViewBag.Campania = campaniaRevista;
            return View();
        }

        public JsonResult GetUrlRevistaIssuu(string campania)
        {
            try
            {
                if (string.IsNullOrEmpty(campania)) return Json(new { success = false }, JsonRequestBehavior.AllowGet);

                string codigo = _issuuProvider.GetRevistaCodigoIssuu(campania, revistaDigital.TieneRDCR, userData.CodigoISO, userData.CodigoZona);
                if (string.IsNullOrEmpty(codigo)) return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                
                string url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlIssuu);
                url = string.Format(url, codigo);
                return Json(new { success = true, urlRevista = url }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }

        private bool EsCatalogoUnificado(int campania)
        {
            string paisesCatalogoUnificado = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesCatalogoUnificado);
            if (!paisesCatalogoUnificado.Contains(userData.CodigoISO)) return false;

            string paisUnificado = paisesCatalogoUnificado.Split(';').FirstOrDefault(pais => pais.Contains(userData.CodigoISO));
            if (paisUnificado == null) return false;

            string[] paisCamp = paisUnificado.Split(',');
            if (paisCamp.Length < 2) return false;

            int campaniaInicio = Convert.ToInt32(paisCamp[1]);
            return campania >= campaniaInicio;
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
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DCatalogoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DCatalogoNoInscritaActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                    else
                    {
                        if (revistaDigital.EsSuscrita)
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DCatalogoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                        else
                        {
                            partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RD.DCatalogoNoInscritaNoActiva) ?? new ConfiguracionPaisDatosModel();
                        }
                    }
                }
                else if (revistaDigital.TieneRDI)
                {
                    partial.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.FirstOrDefault(x => x.Codigo == Constantes.ConfiguracionPaisDatos.RDI.DCatalogoIntriga) ?? new ConfiguracionPaisDatosModel();
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
