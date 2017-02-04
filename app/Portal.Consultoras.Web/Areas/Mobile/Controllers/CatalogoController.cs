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
            var clienteModel = new ClienteMobileModel();
            clienteModel.PaisID = userData.PaisID;
            clienteModel.CampaniaActual = userData.CampaniaID.ToString();
            clienteModel.CampaniaAnterior = CalcularCampaniaAnterior(clienteModel.CampaniaActual);
            clienteModel.CampaniaSiguiente = CalcularCampaniaSiguiente(clienteModel.CampaniaActual);
            clienteModel.CodigoZona = userData.CodigoZona; //R20160204

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
            string urlISSUUVisor = "http://issuu.com/somosbelcorp/docs/";
            //string parameterDisplayMain = "?e=1/2";
            string parameterDisplayMain = "?mode=embed"; 

            try
            {
                string catalogoCampania = ObtenerNombrePaisByISO(paisISO) + ".c" + campaniaId.Substring(4, 2) + "." + campaniaId.Substring(0, 4);
                string catalogoLbel = "lbel." + catalogoCampania;
                string catalogoEsika = "esika." + catalogoCampania;
                string catalogoCyzone = "cyzone." + catalogoCampania;
                string catalogoFinart = "finart." + catalogoCampania;

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

                    if (docName == catalogoLbel) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.LBel, marcaCatalogo = "LBel", DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                    else if (docName == catalogoEsika) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Esika, marcaCatalogo = "Esika", DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                    else if (docName == catalogoCyzone) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Cyzone, marcaCatalogo = "Cyzone", DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                    else if (docName == catalogoFinart) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Finart, marcaCatalogo = "Finart", DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                }
            }
            catch (Exception) { catalogos = new List<Catalogo>(); }
            return catalogos;
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
        public JsonResult EnviarEmail(List<Portal.Consultoras.Web.Areas.Mobile.Models.CatalogoClienteModel> ListaCatalogosCliente, string Mensaje, string Campania)
        {
            string CampaniaID = string.Empty;
            string FechaFacturacion = string.Empty;
            List<Portal.Consultoras.Web.Areas.Mobile.Models.CatalogoClienteModel> lstClientesCat = new List<Portal.Consultoras.Web.Areas.Mobile.Models.CatalogoClienteModel>();

            // Flags => Considerar a todos los clientes
            //if (Flags.Split('|')[0] == "1" || Flags.Split('|')[1] == "1" || Flags.Split('|')[2] == "1" || Flags.Split('|')[3] == "1")
            //{

            //    List<BECliente> lstClientes = new List<BECliente>();
            //    using (ClienteServiceClient sv = new ClienteServiceClient())
            //    {
            //        lstClientes = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            //    }

            //    lstClientes = (from req in lstClientes
            //                   where req.eMail.ToString().Trim() != string.Empty
            //                   select req).ToList();

            //    foreach (var item in lstClientes)
            //    {
            //        CatalogoClienteModel model = new CatalogoClienteModel();
            //        model.ClienteID = item.ClienteID;
            //        model.Nombre = item.Nombre;
            //        model.Email = item.eMail;
            //        model.LBel = Flags.Split('|')[0] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).LBel;
            //        model.Cyzone = Flags.Split('|')[1] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).Cyzone;
            //        model.Esika = Flags.Split('|')[2] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).Esika;
            //        model.Finart = Flags.Split('|')[3] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).Finart;
            //        lstClientesCat.Add(model);
            //    }
            //}
            //if (lstClientesCat.Count > 0) ListaCatalogosCliente = lstClientesCat;

            try
            {
                List<Catalogo> catalogos = new List<Catalogo>();
                try
                {
                    if (Campania == userData.CampaniaID.ToString())
                    {
                        CampaniaID = userData.CampaniaID.ToString();

                        if (!userData.DiaPROL)
                        {
                            FechaFacturacion = userData.FechaFacturacion.ToShortDateString();
                        }
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
                        success = true,
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
                        
                            #region Email Perú LBel

                            if (UserData().PaisID == 11)
                            {
                                if (CampaniaID == "201614")
                                {
                                    if (UserData().CodigoZona == "1072")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "1075")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoLbel.SkinURL + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                }
                                else if (CampaniaID == "201615")
                                {
                                    if (UserData().CodigoZona == "1081")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3033")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoLbel.SkinURL + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                }
                                else if (CampaniaID == "201616")
                                {
                                    if (UserData().CodigoZona == "1081")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1616pe" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3033")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1616pe" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1616pe" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1616pe" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_lb1616pe" + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoLbel.SkinURL + "\" style=\"color:#333;\">";
                                        if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                        else mailBody += "LBel</a></td>";
                                    }
                                }
                                else
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoLbel.SkinURL + "\" style=\"color:#333;\">";
                                    if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                    else mailBody += "LBel</a></td>";
                                }
                            }
                            else
                            {
                                mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoLbel.SkinURL + "\" style=\"color:#333;\">";
                                if (catalogoUnificado == "1") mailBody += "LBel - Esika</a></td>";
                                else mailBody += "LBel</a></td>";
                            }

                            #endregion
                        
                        else 
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.lbel.com" + "\" style=\"color:#333;\">LBel</a></td>";
                    }
                    if (item.Esika == "1")
                    {
                        if (catalogoEsika != null && !string.IsNullOrEmpty(catalogoEsika.DocumentID))

                            #region Email Perú Esika

                            if (UserData().PaisID == 11)
                            {
                                if (CampaniaID == "201614")
                                {
                                    if (UserData().CodigoZona == "1072")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "1075")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoEsika.SkinURL + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                }
                                else if (CampaniaID == "201615")
                                {
                                    if (UserData().CodigoZona == "1081")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3033")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoEsika.SkinURL + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                }
                                else if (CampaniaID == "201616")
                                {
                                    if (UserData().CodigoZona == "1081")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_ek1616pe" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3033")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_ek1616pe" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_ek1616pe" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_ek1616pe" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_ek1616pe" + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoEsika.SkinURL + "\" style=\"color:#333;\">Esika</a></td>";
                                    }
                                }
                                else
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoEsika.SkinURL + "\" style=\"color:#333;\">Esika</a></td>";
                                }

                            }
                            else
                            {
                                mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoEsika.SkinURL + "\" style=\"color:#333;\">Esika</a></td>";
                            }

                            #endregion

                        else
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.cyzone.com" + "\" style=\"color:#333;\">Esika</a></td>";
                    }
                    if (item.Cyzone == "1")
                    {
                        if (catalogoCyZone != null && !string.IsNullOrEmpty(catalogoCyZone.DocumentID))

                            #region Email Perú Cyzone

                            if (UserData().PaisID == 11)
                            {
                                if (CampaniaID == "201614")
                                {
                                    if (UserData().CodigoZona == "1072")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "1075")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoCyZone.SkinURL + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                }
                                else if (CampaniaID == "201615")
                                {
                                    if (UserData().CodigoZona == "1081")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3033")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoCyZone.SkinURL + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                }
                                else if (CampaniaID == "201616")
                                {
                                    if (UserData().CodigoZona == "1081")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_cy1616pe" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3033")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_cy1616pe" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_cy1616pe" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "3036")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_cy1616pe" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else if (UserData().CodigoZona == "5035")
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "https://issuu.com/somosbelcorp/docs/piloto_cy1616pe" + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                    else
                                    {
                                        mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoCyZone.SkinURL + "\" style=\"color:#333;\">Cyzone</a></td>";
                                    }
                                }
                                else
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoCyZone.SkinURL + "\" style=\"color:#333;\">Cyzone</a></td>";
                                }
                            }
                            else
                            {
                                mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoCyZone.SkinURL + "\" style=\"color:#333;\">Cyzone</a></td>";
                            }

                            #endregion

                        else
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.esika.biz" + "\" style=\"color:#333;\">Cyzone</a></td>";
                    }
                    if (item.Finart == "1")
                    {
                        if (catalogoFinart != null && !string.IsNullOrEmpty(catalogoFinart.DocumentID))
                            // RQ 2295 Mejoras en Catalogos Belcorp
                            //mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + Url + "FI" + catalogoFinart.DocumentID + "\" style=\"color:#333;\">Finart</a></td>";
                            mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoFinart.SkinURL + "\" style=\"color:#333;\">Esika by Finart</a></td>";
                        else
                            //mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.finartsa.biz" + "\" style=\"color:#333;\">Finart</a></td>";
                            // RQ 2295 Mejoras en Catalogos Belcorp
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
                    
                    mailBody += "<tr>";
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

                    if (!ValidarCorreoFormato(item.Email))
                    {
                        CorreosInvalidos += item.Email + "; ";
                    }
                    else
                    {
                        Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", item.Email, "(" + userData.CodigoISO + ") Revisa Tus Catálogos " + CampaniaID, mailBody, true, userData.NombreConsultora);
                    }

                    #endregion
                }

                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    sv.InsCatalogoCampania(userData.PaisID, userData.CodigoConsultora, Convert.ToInt32(CampaniaID));
                }

                return Json(new
                {
                    success = false,
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

        private static string CampaniaInicioFin(BECatalogoConfiguracion catalogo, int campania)
        {
            string resultado = null;
            if (catalogo.Estado == 2)
            {
                if (campania >= catalogo.CampaniaInicio && campania <= catalogo.CampaniaFin)
                {
                    resultado = "0";
                }
                else if (catalogo.CampaniaInicio != 0 && catalogo.CampaniaFin == 0 && campania >= catalogo.CampaniaInicio)
                {
                    resultado = "0";
                }
                else
                {
                    resultado = "1";
                }
            }
            else
            {
                resultado = catalogo.Estado.ToString();
            }

            return resultado;
        }

        private static string ObtenerNombrePaisByISO(string paisIso)
        {
            string resultado = string.Empty;

            switch (paisIso)
            {
                case Constantes.CodigosISOPais.Argentina:
                    resultado = "argentina";
                    break;

                case Constantes.CodigosISOPais.Bolivia:
                    resultado = "bolivia";
                    break;

                case Constantes.CodigosISOPais.Chile:
                    resultado = "chile";
                    break;

                case Constantes.CodigosISOPais.Colombia:
                    resultado = "colombia";
                    break;

                case Constantes.CodigosISOPais.CostaRica:
                    resultado = "costarica";
                    break;

                case Constantes.CodigosISOPais.Dominicana:
                    resultado = "republicadominicana";
                    break;

                case Constantes.CodigosISOPais.Ecuador:
                    resultado = "ecuador";
                    break;

                case Constantes.CodigosISOPais.Salvador:
                    resultado = "elsalvador";
                    break;

                case Constantes.CodigosISOPais.Guatemala:
                    resultado = "guatemala";
                    break;

                case Constantes.CodigosISOPais.Mexico:
                    resultado = "mexico";
                    break;

                case Constantes.CodigosISOPais.Panama:
                    resultado = "panama";
                    break;

                case Constantes.CodigosISOPais.Peru:
                    resultado = "peru";
                    break;

                case Constantes.CodigosISOPais.PuertoRico:
                    resultado = "puertorico";
                    break;

                case Constantes.CodigosISOPais.Venezuela:
                    resultado = "venezuela";
                    break;

                default:
                    resultado = "sinpais";
                    break;
            }

            return resultado;
        }

        private static bool ValidarCorreoFormato(string correo)
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
    }
}