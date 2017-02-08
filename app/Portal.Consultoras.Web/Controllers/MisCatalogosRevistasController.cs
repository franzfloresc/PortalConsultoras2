﻿using Portal.Consultoras.Common;
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
            ViewBag.TextoMensajeSaludoCorreo = TextoMensajeSaludoCorreo;

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

            if (ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Contains(ISO))
            {
                string[] paises = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Split(';');
                if (paises.Length > 0)
                {
                    foreach (var pais in paises)
                    {
                        if (pais.Contains(ISO))
                        {
                            string[] PaisCamp = pais.Split(',');
                            if (PaisCamp.Length > 0)
                            {
                                int CampaniaInicio = Convert.ToInt32(PaisCamp[1]);
                                if (campania >= CampaniaInicio)
                                {
                                    estadoEsika = "1";
                                    catalogoUnificado = "1";
                                }
                            }
                        }
                    }
                }
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
        
        private string CalcularCampaniaAnterior(string CampaniaActual)
        {
            var campAct = CampaniaActual.Substring(4, 2);
            if (campAct == "01")
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) - 1).ToString() + userData.NroCampanias.ToString();
            else
                return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(campAct) - 1).ToString().PadLeft(2, '0');
        }

        private string CalcularCampaniaSiguiente(string CampaniaActual)
        {
            var campAct = CampaniaActual.Substring(4, 2);
            if (campAct == userData.NroCampanias.ToString())
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) + 1).ToString() + "01";
            else
                return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(campAct) + 1).ToString().PadLeft(2, '0');
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
                lista.Update(c=> {c.Nombre = c.Nombre.Trim(); c.eMail = c.eMail.Trim();});
                lista = lista.Where(c => c.eMail != "").ToList();
                Session[Constantes.ConstSession.ClientesByConsultora] = lista;
            }
            lista = lista.Where(c => c.eMail.Contains(term)).ToList();

            var data = lista.Select(c => 
                new {
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


                string catalogoUnificado = "0";
                string ISO = userData.CodigoISO;

                if (ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Contains(ISO))
                {
                    string[] paises = ConfigurationManager.AppSettings["PaisesCatalogoUnificado"].Split(';');
                    if (paises.Length > 0)
                    {
                        foreach (var pais in paises)
                        {
                            if (pais.Contains(ISO))
                            {
                                string[] PaisCamp = pais.Split(',');
                                if (PaisCamp.Length > 0)
                                {
                                    int CampaniaInicio = Convert.ToInt32(PaisCamp[1]);
                                    if (Convert.ToInt32(CampaniaID) >= CampaniaInicio)
                                        catalogoUnificado = "1";
                                }
                            }
                        }
                    }
                }


                string RutaPublicaImagen = "";
                string nombrecorto = userData.NombreCorto;
                //Mejora - Correo
                //string nomPais = Util.ObtenerNombrePaisPorISO(userData.CodigoISO);
                string CorreosInvalidos = string.Empty;

                Catalogo catalogoLbel = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.LBel);
                Catalogo catalogoEsika = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Esika);
                Catalogo catalogoCyZone = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Cyzone);
                Catalogo catalogoFinart = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Finart);

                foreach (var item in ListaCatalogosCliente)
                {
                    #region foreach
                    string mailBody = string.Empty;

                    mailBody += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
                    mailBody += "<tr>";
                    mailBody += "<td width=\"100%\" style=\"height: 50px; background:#6C207F;\">&nbsp;</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";

                    mailBody += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"padding:0px; margin:0px;font-family:Calibri;\" >";
                    mailBody += "<tr>";
                    mailBody += "<td width=\"100%\" style=\"text-align:center; background-color:#F0F0F0; overflow:hidden; display:block; padding: 24px 0px 24px 0px;\">";
                    mailBody += "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:722px; margin: 0px auto; text-align:left;\" >";
                    mailBody += "<tr>";
                    mailBody += "<td valign=\"top\">";
                    mailBody += "<table width=\"722\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
                    mailBody += "<tr>";
                    mailBody += "<td width=\"454\" valign=\"top\">";
                    mailBody += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
                    mailBody += "<tr>";
                    mailBody += "<td align=\"left\" style=\"color:#000000; font-size:35px; text-align:left;\">Catálogos</td>";
                    mailBody += "</tr>";
                    mailBody += "<tr>";
                    mailBody += "<td align=\"left\" style=\"color:#6C207F; font-size:25px; padding: 0px 0px 35px 50px; text-align:left;\">";
                    mailBody += "VIRTUALES";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";
                    mailBody += "<table border=\"0\" cellpadding=\"0\" cellspacing=\"5\">";
                    mailBody += "<tr>";

                    if (item.LBel == "1")
                    {
                        if (catalogoLbel != null && !string.IsNullOrEmpty(catalogoLbel.DocumentID))
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogoLbel.DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\"></td>";
                        else
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + RutaPublicaImagen + "\"></td>";
                    }
                    if (item.Esika == "1")
                    {
                        if (catalogoEsika != null && !string.IsNullOrEmpty(catalogoEsika.DocumentID))
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogoEsika.DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\"></td>";
                        else
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + RutaPublicaImagen + "\"></td>";
                    }
                    if (item.Cyzone == "1")
                    {
                        if (catalogoCyZone != null && !string.IsNullOrEmpty(catalogoCyZone.DocumentID))
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogoCyZone.DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\"></td>";
                        else
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + RutaPublicaImagen + "\"></td>";
                    }
                    if (item.Finart == "1")
                    {
                        if (catalogoFinart != null && !string.IsNullOrEmpty(catalogoFinart.DocumentID))
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogoFinart.DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\"></td>";
                        else
                            mailBody += "<td width=\"98\" style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\"><img src=\"" + RutaPublicaImagen + "\"></td>";
                    }
                    mailBody += "</tr>";

                    mailBody += "<tr>";
                    if (item.LBel == "1")
                    {
                        if (catalogoLbel != null && !string.IsNullOrEmpty(catalogoLbel.DocumentID))
                        {
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoLbel.SkinURL + "\" style=\"color:#333;\">";
                            if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                            else mailBody += "LBel</a></td>";
                        }
                        else
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.lbel.com" + "\" style=\"color:#333;\">LBel</a></td>";
                    }
                    if (item.Esika == "1")
                    {
                        if (catalogoEsika != null && !string.IsNullOrEmpty(catalogoEsika.DocumentID))
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoEsika.SkinURL + "\" style=\"color:#333;\">Esika</a></td>";                            
                        else
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.cyzone.com" + "\" style=\"color:#333;\">Esika</a></td>";
                    }
                    if (item.Cyzone == "1")
                    {
                        if (catalogoCyZone != null && !string.IsNullOrEmpty(catalogoCyZone.DocumentID))
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoCyZone.SkinURL + "\" style=\"color:#333;\">Cyzone</a></td>";

                        else
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.esika.biz" + "\" style=\"color:#333;\">Cyzone</a></td>";
                    }
                    if (item.Finart == "1")
                    {
                        if (catalogoFinart != null && !string.IsNullOrEmpty(catalogoFinart.DocumentID))
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoFinart.SkinURL + "\" style=\"color:#333;\">Esika by Finart</a></td>";
                        else
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "#" + "\" style=\"color:#333;\">Esika by Finart</a></td>";
                    }
                    mailBody += "</tr>";
                    mailBody += "</table>";
                    mailBody += "</td>";

                    mailBody += "<td width=\"228\" valign=\"top\" style=\"background:#E5E5E5; line-height: 18px; padding: 20px 20px 30px 20px;\">";
                    mailBody += "<table width=\"100%\" border=\"0\" cellpadding=\"0\">";
                    mailBody += " <tr>";

                    item.Nombre = Util.SubStr(item.Nombre, 0);
                    String[] NombreClienteConsultora = item.Nombre.Split(' ');

                    mailBody += " <td style=\"padding: 0px 0px 15px 0px; text-align:left; display:block;\"><b>Hola </b>" + NombreClienteConsultora[0] + ",</td>";
                    mailBody += " </tr>";

                    if (!string.IsNullOrEmpty(Mensaje))
                    {
                        mailBody += "<tr>";
                        mailBody += "<td style=\"padding: 0px 0px 15px 0px; text-align:left; display:block;\">";
                        mailBody += Mensaje.Replace("Hola,", "");
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                    }
                    
                    mailBody += "<td style=\"padding: 0px 0px 15px 0px; text-align:left; display:block;\">Recuerda que tienes hasta el día <b>" + FechaFacturacion + "</b> para enviarme tu pedido.";
                    mailBody += "</td>";
                    mailBody += " </tr>";
                    if (!userData.EMail.ToString().Equals(string.Empty))
                    {
                        mailBody += "<tr>";
                        mailBody += "<td>Para cualquier duda; mi correo electrónico es: </td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td><b><a href=\"#\" style=\"color:#333333; text-align:left;\">" + userData.EMail + "</a></b></td>";
                        mailBody += " </tr>";
                    }
                    if (!userData.Telefono.ToString().Equals(string.Empty))
                    {
                        mailBody += "<tr>";
                        mailBody += "<td style=\"text-align:left;\">Mi Teléfono es: <b>" + userData.Telefono + "</b></td>";
                        mailBody += "</tr>";
                    }
                    if (!userData.Celular.ToString().Equals(string.Empty))
                    {
                        mailBody += "<tr>";
                        mailBody += "<td style=\"text-align:left;\">Mi Celular es: <b>" + userData.Celular + "</b></td>";
                        mailBody += "</tr>";
                    }
                    mailBody += "</tr></table></td></tr></table></td></tr></table></td></tr></table>";
                    mailBody += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"text-align:center;\">";
                    mailBody += "<tr>";
                    mailBody += "<td width=\"100%\" style=\"height: 50px; background:#FFFFFF;\">";
                    mailBody += "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:722px; margin:0px auto;\">";
                    mailBody += "<tr>";
                    mailBody += "<td width=\"400\" style=\"padding: 5px 0px 0px 0px; text-align:left;\">";
                    mailBody += "<b>Recuerda</b> debes tener internet para ver los Catálogos";
                    mailBody += "</td>";

                    mailBody += "<td width=\"322\" style=\"padding: 5px 0px 0px 0px; font-size: 11px; color:#6C207F; text-align:right;\">";
                    mailBody += "Copyright Belcorp 2013. All rights reserved";
                    mailBody += "</td>";
                    mailBody += "</tr>";
                    mailBody += "</table>";
                    mailBody += "</td>";
                    mailBody += "</tr>";

                    mailBody += "</table>";

                    if (!ValidarCorreoFormato(item.Email)) CorreosInvalidos += item.Email + "; ";
                    else Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", item.Email, "(" + userData.CodigoISO + ") Revisa Tus Catálogos " + CampaniaID, mailBody, true, userData.NombreConsultora);

                    #endregion
                }

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

        [AllowAnonymous]
        public ActionResult DescargarAppCatalogos()
        {
            var redirect = "";
            if (System.Web.HttpContext.Current.Request.UserAgent != null)
            {
                var userAgent = System.Web.HttpContext.Current.Request.UserAgent.ToLower();

                if (userAgent.Contains("iphone;"))
                {
                    redirect = "<script>window.location = 'https://itunes.apple.com/pe/app/catalogos-esika-lbel-cyzone/id1052948837?mt=8';</script>";

                }
                else
                {
                    redirect = "<script>window.location = 'https://play.google.com/store/apps/details?id=belcorp.modobeta.catalogov2&hl=es_419';</script>";
                }
            }

            return Content(redirect);
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
    }
}
