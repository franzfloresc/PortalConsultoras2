﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisCatalogosRevistasController : BaseController
    {
        private const string TextoMensajeSaludoCorreo = "Revisa los catálogos de esta campaña y comunícate conmigo si estás interesada en algunos de los productos.";

        public ActionResult Index()
        {
            var clienteModel = new MisCatalogosRevistasModel();

            clienteModel.PaisNombre = getPaisNombreByISO(userData.CodigoISO);
            clienteModel.CampaniaActual = userData.CampaniaID.ToString();
            clienteModel.CampaniaAnterior = AddCampaniaAndNumero(userData.CampaniaID, -1).ToString();
            clienteModel.CampaniaSiguiente = AddCampaniaAndNumero(userData.CampaniaID, 1).ToString();
            clienteModel.CodigoRevistaActual = GetRevistaCodigoIssuu(clienteModel.CampaniaActual);
            clienteModel.CodigoRevistaAnterior = GetRevistaCodigoIssuu(clienteModel.CampaniaAnterior);
            clienteModel.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(clienteModel.CampaniaSiguiente);

            ViewBag.CodigoISO = userData.CodigoISO;
            ViewBag.EsConsultoraNueva = EsConsultoraNueva();
            ViewBag.TextoMensajeSaludoCorreo = TextoMensajeSaludoCorreo;

            clienteModel.MostrarRevistaDigital = revistaDigital.TieneRDR;
            clienteModel.RevistaDigital = revistaDigital;
            return View(clienteModel);
        }

        public JsonResult Detalle(int campania)
        {
            string ISO = userData.CodigoISO;
            // RQ 2295 Mejoras en Catalogos Belcorp
            List<BECatalogoConfiguracion> lstCatalogoConfiguracion = new List<BECatalogoConfiguracion>();
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lstCatalogoConfiguracion = sv.GetCatalogoConfiguracion(userData.PaisID).ToList();
            }

            List<Catalogo> listCatalogo = this.GetCatalogosPublicados(userData.CodigoISO, campania.ToString());

            campania = campania <= 0 ? userData.CampaniaID : campania;
            string estadoLbel = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.LBel).FirstOrDefault(), campania);
            string estadoEsika = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Esika).FirstOrDefault(), campania);
            string estadoCyzone = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Cyzone).FirstOrDefault(), campania);
            string estadoFinart = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Finart).FirstOrDefault(), campania);
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

        public List<Catalogo> GetCatalogosPublicados(string paisISO, string campaniaId)
        {
            List<Catalogo> catalogos = new List<Catalogo>();
            string urlISSUUSearch = "http://search.issuu.com/api/2_0/document?username=somosbelcorp&q=";
            string urlISSUUVisor = ConfigurationManager.AppSettings["UrlIssuu"];

            try
            {
                string catalogoLbel = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.LBel);
                string catalogoEsika = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Esika);
                string catalogoCyzone = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Cyzone);
                string catalogoFinart = GetCatalogoCodigoIssuu(campaniaId, Constantes.Marca.Finart);

                var url = urlISSUUSearch +
                    "docname:" + catalogoLbel + "+OR+" +
                    "docname:" + catalogoEsika + "+OR+" +
                    "docname:" + catalogoCyzone + "+OR+" +
                    "docname:" + catalogoFinart + "&jsonCallback=?";

                string response = "";
                using (var wc = new WebClient())
                {
                    using (Stream myStream = wc.OpenRead(new Uri(url)))
                    {
                        using (StreamReader streamReader = new StreamReader(myStream))
                        {
                            response = streamReader.ReadToEnd();
                        }
                    }
                }

                if (response.Substring(0, 2) == "?(") response = response.Substring(2, response.Length - 3);
                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                var jsonReponse = javaScriptSerializer.Deserialize<dynamic>(response);

                foreach (var doc in jsonReponse["response"]["docs"])
                {
                    string docName = doc["docname"], documentId = doc["documentId"];

                    if (docName == catalogoLbel) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.LBel, marcaCatalogo = "LBel", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoEsika) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Esika, marcaCatalogo = "Esika", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoCyzone) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Cyzone, marcaCatalogo = "Cyzone", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                    else if (docName == catalogoFinart) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Finart, marcaCatalogo = "Finart", DocumentID = documentId, SkinURL = string.Format(urlISSUUVisor, docName) });
                }
            }
            catch (Exception) { catalogos = new List<Catalogo>(); }
            return catalogos;
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
                lista = lista.Where(c => c.eMail != "").ToList();
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
        public JsonResult EnviarEmail(List<CatalogoClienteModel> ListaCatalogosCliente, string Mensaje, string Campania)
        {
            string CampaniaID = string.Empty;
            string FechaFacturacion = string.Empty;
            List<CatalogoClienteModel> lstClientesCat = new List<CatalogoClienteModel>();

            try
            {
                List<Catalogo> catalogos = new List<Catalogo>();
                try
                {
                    if (Campania == userData.CampaniaID.ToString())
                    {
                        CampaniaID = userData.CampaniaID.ToString();

                        if (!userData.DiaPROL) FechaFacturacion = userData.FechaFacturacion.ToShortDateString();
                        else
                        {
                            DateTime FechaHoraActual = DateTime.Now.AddHours(userData.ZonaHoraria);
                            if (userData.DiasCampania != 0 && FechaHoraActual < userData.FechaInicioCampania)
                            {
                                FechaFacturacion = userData.FechaInicioCampania.ToShortDateString();
                            }
                            else
                            {
                                FechaFacturacion = FechaHoraActual.ToShortDateString();
                            }
                        }
                    }
                    else
                    {
                        CampaniaID = Campania; // CalcularCampaniaSiguiente(userData.CampaniaID.ToString());
                        using (UsuarioServiceClient sv = new UsuarioServiceClient())
                        {
                            FechaFacturacion = sv.GetFechaFacturacion(CampaniaID, userData.ZonaID, userData.PaisID).ToShortDateString();
                        }
                    }

                    catalogos = this.GetCatalogosPublicados(userData.CodigoISO, CampaniaID);
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

                //string catalogoUnificado = "0";
                //string ISO = userData.CodigoISO;

                //if (ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Contains(ISO))
                //{
                //    string[] paises = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Split(';');
                //    if (paises.Length > 0)
                //    {
                //        foreach (var pais in paises)
                //        {
                //            if (pais.Contains(ISO))
                //            {
                //                string[] PaisCamp = pais.Split(',');
                //                if (PaisCamp.Length > 0)
                //                {
                //                    int CampaniaInicio = Convert.ToInt32(PaisCamp[1]);
                //                    if (Convert.ToInt32(CampaniaID) >= CampaniaInicio)
                //                        catalogoUnificado = "1";
                //                }
                //            }
                //        }
                //    }
                //}

                string RutaPublicaImagen = "";
                string nombrecorto = userData.NombreCorto;
                //Mejora - Correo
                //string nomPais = Util.ObtenerNombrePaisPorISO(userData.CodigoISO);
                string CorreosInvalidos = string.Empty;

                Catalogo catalogoLbel = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.LBel);
                Catalogo catalogoEsika = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Esika);
                Catalogo catalogoCyZone = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Cyzone);
                Catalogo catalogoFinart = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Finart);

                /*EPD-1003*/
                DateTime dd = DateTime.Parse(FechaFacturacion, new CultureInfo("es-ES"));
                string fdf = dd.ToString("dd", new CultureInfo("es-ES"));
                string fmf = dd.ToString("MMMM", new CultureInfo("es-ES"));
                string ffechaFact = fdf + " de " + char.ToUpper(fmf[0]) + fmf.Substring(1);
                string urlIssuCatalogo = string.Empty;

                string urlImagenLogo = "http://www.genesis-peru.com/mailing-belcorp/logo.png";
                string urlIconEmail = "http://www.genesis-peru.com/mailing-belcorp/mensaje_mail.png";
                string urlIconTelefono = "http://www.genesis-peru.com/mailing-belcorp/celu_mail.png";

                if (!ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO))
                {
                    urlImagenLogo = "https://s3.amazonaws.com/uploads.hipchat.com/583104/4578891/jG6i4d6VUyIaUwi/logod.png";
                    urlIconEmail = "https://s3.amazonaws.com/uploads.hipchat.com/583104/4578891/SWR2zWZftNbE4mn/mensaje_mail.png";
                    urlIconTelefono = "https://s3.amazonaws.com/uploads.hipchat.com/583104/4578891/1YI6wJJKvX90WZk/celu_mail.png";
                }

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
                    //mailBody += "<tr>";
                    //mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                    //mailBody += "<a href=\"#\" style=\"width:100%; display:block;\">";
                    //mailBody += "<img width=\"100%\" display=\"block\" src=\"http://www.genesis-peru.com/mailing-belcorp/revista.png\" alt=\"Revista\" />";
                    //mailBody += "</a>";
                    //mailBody += "</td>";
                    //mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                    //mailBody += "<a href=\"#\" style=\"width:100%; display:block;\">";
                    //mailBody += "<img width=\"100%\" display=\"block\" src=\"http://www.genesis-peru.com/mailing-belcorp/revista.png\" alt=\"Revista\" />";
                    //mailBody += "</a>";
                    //mailBody += "</td>";
                    //mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                    //mailBody += "<a href=\"#\" style=\"width:100%; display:block;\">";
                    //mailBody += "<img width=\"100%\" display=\"block\" src=\"http://www.genesis-peru.com/mailing-belcorp/revista.png\" alt=\"Revista\" />";
                    //mailBody += "</a>";
                    //mailBody += "</td>";
                    //mailBody += "</tr>";

                    mailBody += "<tr>";

                    if (item.LBel == "1")
                    {
                        if (catalogoLbel != null && !string.IsNullOrEmpty(catalogoLbel.DocumentID))
                        {
                            RutaPublicaImagen = Constantes.CatalogoUrlParameters.UrlPart01 + catalogoLbel.DocumentID + Constantes.CatalogoUrlParameters.UrlPart03;
                            urlIssuCatalogo = catalogoLbel.SkinURL;
                        }

                        mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                        mailBody += "<a href=\"" + urlIssuCatalogo + "\" style=\"width:100%; display:block;\">";
                        mailBody += "<img width=\"100%\" display=\"block\" style=\"width:120px;height:150px\" src=\"" + RutaPublicaImagen + "\" alt=\"Revista\" />";
                        mailBody += "</a>";
                        mailBody += "</td>";
                    }

                    if (item.Esika == "1")
                    {
                        if (catalogoEsika != null && !string.IsNullOrEmpty(catalogoEsika.DocumentID))
                        {
                            RutaPublicaImagen = Constantes.CatalogoUrlParameters.UrlPart01 + catalogoEsika.DocumentID + Constantes.CatalogoUrlParameters.UrlPart03;
                            urlIssuCatalogo = catalogoEsika.SkinURL;
                        }

                        mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                        mailBody += "<a href=\"" + urlIssuCatalogo + "\" style=\"width:100%; display:block;\">";
                        mailBody += "<img width=\"100%\" display=\"block\" style=\"width:120px;height:150px\" src=\"" + RutaPublicaImagen + "\" alt=\"Revista\" />";
                        mailBody += "</a>";
                        mailBody += "</td>";
                    }

                    if (item.Cyzone == "1")
                    {
                        if (catalogoCyZone != null && !string.IsNullOrEmpty(catalogoCyZone.DocumentID))
                        {
                            RutaPublicaImagen = Constantes.CatalogoUrlParameters.UrlPart01 + catalogoCyZone.DocumentID + Constantes.CatalogoUrlParameters.UrlPart03;
                            urlIssuCatalogo = catalogoCyZone.SkinURL;
                        }

                        mailBody += "<td style=\"width:29.3%; display: table-cell; padding-left:2%; padding-right:2%;\">";
                        mailBody += "<a href=\"" + urlIssuCatalogo + "\" style=\"width:100%; display:block;\">";
                        mailBody += "<img width=\"100%\" display=\"block\" style=\"width:120px;height:150px\" src=\"" + RutaPublicaImagen + "\" alt=\"Revista\" />";
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
                    mailBody += "<img src=\"http://www.genesis-peru.com/mailing-belcorp/logo-belcorp.png\" alt=\"Logo Belcorp\" />";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:8%; text-align:left;\">";
                    mailBody += "<a href=\"http://www.esika.biz\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/G9GQryrWRTreo75/logo-esika.png\" alt=\"Logo Esika\" />";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:8%; text-align:left;\">";
                    mailBody += "<a href=\"http://www.lbel.com\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/T3o8rSPUKtKpe4g/logo-lbel.png\" alt=\"Logo L'bel\" />";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:15%; text-align:left;border-right:1px solid #FFF;\">";
                    mailBody += "<a href=\"http://www.cyzone.com\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"https://s3.amazonaws.com/uploads.hipchat.com/583104/4019711/qZf6NJ5d9D75LCO/logo-cyzone.png\" alt=\"Logo Cyzone\" />";
                    mailBody += "</a>";
                    mailBody += "</td>";
                    mailBody += "<td style=\"width:15%; font-family:'Calibri'; font-weight:400; font-size:13px; color:#FFF; vertical-align:middle;\">";
                    mailBody += "<table align=\"center\" style=\"text-align:center; width:100%;\">";
                    mailBody += "<tbody>";
                    mailBody += "<tr>";
                    mailBody += "<td style=\"text-align: right; font-family:'Calibri'; font-weight:400; font-size:13px; vertical-align: middle; width: 69%; color:white;\">S&Iacute;GUENOS</td>";
                    mailBody += "<td style=\"text-align: right; position: relative; top: 2px; left: 10px; width: 20%; vertical-align: top;\">";
                    mailBody += "<a href=\"https://es-la.facebook.com/SomosBelcorpOficial\" style=\"width:100%; display:block;\">";
                    mailBody += "<img src=\"http://www.genesis-peru.com/mailing-belcorp/logo-facebook.png\" alt=\"Logo Facebook\" /></td>";
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

                    if (!ValidarCorreoFormato(item.Email)) CorreosInvalidos += item.Email + "; ";
                    else Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", item.Email, "Revisa tus catálogos de campaña " + CampaniaID.Substring(4, 2), mailBody, true, userData.NombreConsultora);

                    #endregion
                }
                /*EPD-1003*/

                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    sv.InsCatalogoCampania(userData.PaisID, userData.CodigoConsultora, Convert.ToInt32(CampaniaID));
                }

                return Json(new
                {
                    success = string.IsNullOrEmpty(CorreosInvalidos),
                    message = string.IsNullOrEmpty(CorreosInvalidos)
                        ? "Se envió satisfactoriamente el correo a los cliente(s) seleccionado(s)."
                        : ("Los siguientes correos no fueron enviados pues no tienen un formato correcto: " + CorreosInvalidos),
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
            bool Result = false;
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

                Result = true;
            }
            catch
            {
                Result = false;
            }
            return Result;
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

                string codigo = GetRevistaCodigoIssuu(campania);
                if (string.IsNullOrEmpty(codigo)) return Json(new { success = false }, JsonRequestBehavior.AllowGet);

                string url = ConfigurationManager.AppSettings["UrlIssuu"].ToString();
                url = string.Format(url, codigo);
                return Json(new { success = true, urlRevista = url }, JsonRequestBehavior.AllowGet);
            }
            catch { }
            return Json(new { success = false }, JsonRequestBehavior.AllowGet);
        }

        private bool EsCatalogoUnificado(int campania)
        {
            string paisesCatalogoUnificado = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"] ?? "";
            if (!paisesCatalogoUnificado.Contains(userData.CodigoISO)) return false;

            string paisUnificado = paisesCatalogoUnificado.Split(';').FirstOrDefault(pais => pais.Contains(userData.CodigoISO));
            if (paisUnificado == null) return false;

            string[] paisCamp = paisUnificado.Split(',');
            if (paisCamp.Length < 2) return false;

            int campaniaInicio = Convert.ToInt32(paisCamp[1]);
            return campania >= campaniaInicio;
        }
    }
}
