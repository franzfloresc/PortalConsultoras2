using Portal.Consultoras.Common;
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
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class CatalogoController : BaseController
    {
        #region Actions

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Catalogo/Index")) return RedirectToAction("Index", "Bienvenida");

            var userData = UserData();
            var clienteModel = new ClienteModel();
            clienteModel.PaisID = UserData().PaisID;
            clienteModel.CampaniaActual = userData.CampaniaID.ToString();
            clienteModel.CampaniaAnterior = CalcularCampaniaAnterior(clienteModel.CampaniaActual);
            clienteModel.CampaniaSiguiente = CalcularCampaniaSiguiente(clienteModel.CampaniaActual);
            clienteModel.CodigoZona = UserData().CodigoZona; //R20160204

            return View(clienteModel);
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

        public ActionResult ConsultarClientes(string sidx, string sord, int page, int rows)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<BECliente> lst;
                    using (ClienteServiceClient sv = new ClienteServiceClient())
                    {
                        lst = sv.SelectByConsultora(UserData().PaisID, UserData().ConsultoraID).ToList();
                    }

                    // Usamos el modelo para obtener los datos
                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
                    //int buscar = int.Parse(txtBuscar);
                    BEPager pag = new BEPager();
                    IEnumerable<BECliente> items = lst;

                    #region Sort Section
                    if (sord == "asc")
                    {
                        switch (sidx)
                        {
                            case "Nombre":
                                items = lst.OrderBy(x => x.Nombre);
                                break;
                        }
                    }
                    else
                    {
                        switch (sidx)
                        {
                            case "Nombre":
                                items = lst.OrderByDescending(x => x.Nombre);
                                break;
                        }
                    }
                    #endregion

                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                    pag = Util.PaginadorGenerico(grid, lst);
                    //Actualizo la lista 
                    items.Update(x => x.Pagina = pag.CurrentPage);

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.ClienteID,
                                   cell = new string[] 
                                   {
                                        a.ClienteID.ToString(),
                                        a.Nombre,
                                        a.eMail.ToString(),
                                        a.Pagina.ToString()
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult ColumnasDeshabilitadasxPais()
        {
            string ISO = UserData().CodigoISO;
            // RQ 2295 Mejoras en Catalogos Belcorp
            List<BECatalogoConfiguracion> lstCatalogoConfiguracion = new List<BECatalogoConfiguracion>();
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lstCatalogoConfiguracion = sv.GetCatalogoConfiguracion(UserData().PaisID).ToList();
            }

            int campania = UserData().CampaniaID;
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
                                if (Convert.ToInt32(UserData().CampaniaID) >= CampaniaInicio)
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
                catalogoUnificado = catalogoUnificado
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ColumnasDeshabilitadasxPais2(string Tipo)
        {
            string campania = string.Empty;

            if (Tipo == "1")
                campania = CalcularCampaniaAnterior(UserData().CampaniaID.ToString());
            else
                campania = CalcularCampaniaSiguiente(UserData().CampaniaID.ToString());

            string ISO = UserData().CodigoISO;
            // RQ 2295 Mejoras en Catalogos Belcorp
            List<BECatalogoConfiguracion> lstCatalogoConfiguracion = new List<BECatalogoConfiguracion>();
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lstCatalogoConfiguracion = sv.GetCatalogoConfiguracion(UserData().PaisID).ToList();
            }

            int campaniaCalculada = Int32.Parse(campania);
            string estadoLbel = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.LBel).FirstOrDefault(), campaniaCalculada);
            string estadoEsika = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Esika).FirstOrDefault(), campaniaCalculada);
            string estadoCyzone = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Cyzone).FirstOrDefault(), campaniaCalculada);
            string estadoFinart = CampaniaInicioFin(lstCatalogoConfiguracion.Where(l => l.MarcaID == (int)Enumeradores.TypeMarca.Finart).FirstOrDefault(), campaniaCalculada);
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
                                if (Convert.ToInt32(campania) >= CampaniaInicio)
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
                catalogoUnificado = catalogoUnificado
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        // RQ 2295 Mejoras en Catalogos Belcorp
        private string CampaniaInicioFin(BECatalogoConfiguracion catalogo, int campania)
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

        public JsonResult GetCatalogosByCampaniaId()
        {
            Catalogo[] catalogos = null;
            try
            {
                using (MulticatalogoWebService sv = new MulticatalogoWebService())
                {
                    catalogos = sv.GetCatalogosPublicados(UserData().CodigoFuente, UserData().CodigoISO, UserData().CampaniaID.ToString());
                }

                return Json(new
                {
                    catalogos = catalogos,
                    Action = string.Empty,
                    Controller = string.Empty,
                    isRedirect = false,
                    Campania = UserData().CampaniaID.ToString()
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    catalogos = catalogos,
                    Action = "Index",
                    Controller = "Bievenida",
                    isRedirect = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    catalogos = catalogos,
                    Action = "Index",
                    Controller = "Bievenida",
                    isRedirect = true
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetCatalogosByCampaniaId2(string TipoCatalogo)
        {
            Catalogo[] catalogos = null;
            try
            {
                string campania;

                if (TipoCatalogo == "1")
                    campania = CalcularCampaniaAnterior(UserData().CampaniaID.ToString());
                else
                    campania = CalcularCampaniaSiguiente(UserData().CampaniaID.ToString());

                using (MulticatalogoWebService sv = new MulticatalogoWebService())
                {
                    catalogos = sv.GetCatalogosPublicados(UserData().CodigoFuente, UserData().CodigoISO, campania);
                }

                return Json(new
                {
                    catalogos = catalogos,
                    Action = string.Empty,
                    Controller = string.Empty,
                    isRedirect = false,
                    Campania = campania
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    catalogos = catalogos,
                    Action = "Index",
                    Controller = "Bievenida",
                    isRedirect = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    catalogos = catalogos,
                    Action = "Index",
                    Controller = "Bievenida",
                    isRedirect = true
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult EnviarEmail(List<CatalogoClienteModel> ListaCatalogosCliente, string Mensaje, string Flags, string Tipo)
        {
            string CampaniaID = string.Empty;
            string FechaFacturacion = string.Empty;
            List<CatalogoClienteModel> lstClientesCat = new List<CatalogoClienteModel>();
            if (Flags.Split('|')[0] == "1" || Flags.Split('|')[1] == "1" || Flags.Split('|')[2] == "1" || Flags.Split('|')[3] == "1")
            {

                List<BECliente> lstClientes = new List<BECliente>();
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lstClientes = sv.SelectByConsultora(UserData().PaisID, UserData().ConsultoraID).ToList();
                }

                lstClientes = (from req in lstClientes
                               where req.eMail.ToString().Trim() != string.Empty
                               select req).ToList();

                foreach (var item in lstClientes)
                {
                    CatalogoClienteModel model = new CatalogoClienteModel();
                    model.ClienteID = item.ClienteID;
                    model.Nombre = item.Nombre;
                    model.Email = item.eMail;
                    model.LBel = Flags.Split('|')[0] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).LBel;
                    model.Cyzone = Flags.Split('|')[1] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).Cyzone;
                    model.Esika = Flags.Split('|')[2] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).Esika;
                    model.Finart = Flags.Split('|')[3] == "1" ? "1" : ListaCatalogosCliente.FindAll(x => x.ClienteID == item.ClienteID).Count == 0 ? "0" : ListaCatalogosCliente.Find(x => x.ClienteID == item.ClienteID).Finart;
                    lstClientesCat.Add(model);
                }
            }
            if (lstClientesCat.Count > 0) ListaCatalogosCliente = lstClientesCat;

            try
            {
                List<Catalogo> catalogos = new List<Catalogo>();
                try
                {
                    if (Tipo == "1")
                    {
                        CampaniaID = UserData().CampaniaID.ToString();
                        //Inicio R2584 CSR - Correccion 
                        DateTime FechaHoraActual = DateTime.Now.AddHours(UserData().ZonaHoraria);
                        if (!UserData().DiaPROL)
                        {
                            FechaFacturacion = UserData().FechaFacturacion.ToShortDateString();
                        }
                        else
                        {
                            if (UserData().DiasCampania != 0 && FechaHoraActual < UserData().FechaInicioCampania)
                            {
                                FechaFacturacion = UserData().FechaInicioCampania.ToShortDateString();
                            }
                            else
                            {
                                FechaFacturacion = FechaHoraActual.ToShortDateString();
                            }
                        }
                        //FIN R2584 CSR  
                    }
                    else
                    {
                        CampaniaID = CalcularCampaniaSiguiente(UserData().CampaniaID.ToString());
                        using (UsuarioServiceClient sv = new UsuarioServiceClient())
                        {
                            FechaFacturacion = sv.GetFechaFacturacion(CampaniaID, UserData().ZonaID, UserData().PaisID).ToShortDateString();
                        }
                    }
                    catalogos = this.GetCatalogosPublicados(UserData().CodigoISO, CampaniaID);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                    return Json(new
                    {
                        success = false,
                        message = "Por favor vuelva ingresar en unos momentos, ya que el servicio de catálogos virtuales está teniendo problemas.",
                        extra = string.Empty
                    });
                }

                if (catalogos.Count > 0)
                {
                    string catalogoUnificado = "0";
                    string ISO = UserData().CodigoISO;

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
                    string nombrecorto = UserData().NombreCorto;
                    //Mejora - Correo
                    //string nomPais = Util.ObtenerNombrePaisPorISO(UserData().CodigoISO);
                    string CorreosInvalidos = string.Empty;

                    Catalogo catalogoLbel = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.LBel);
                    Catalogo catalogoEsika = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Esika);
                    Catalogo catalogoCyZone = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Cyzone);
                    Catalogo catalogoFinart = catalogos.FirstOrDefault(x => x.IdMarcaCatalogo == Constantes.Marca.Finart);

                    foreach (var item in ListaCatalogosCliente)
                    {
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
                            else mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://www.lbel.com" + "\" style=\"color:#333;\">LBel</a></td>";
                        }
                        if (item.Esika == "1")
                        {
                            if (catalogoEsika != null && !string.IsNullOrEmpty(catalogoEsika.DocumentID))

                                if (UserData().PaisID == 3 && CampaniaID == "201604" && UserData().CodigoZona == "1319")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c04.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }
                                else if (UserData().PaisID == 3 && CampaniaID == "201604" && UserData().CodigoZona == "1401")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c04.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }
                                else if (UserData().PaisID == 3 && CampaniaID == "201604" && UserData().CodigoZona == "1410")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c04.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }
                                else if (UserData().PaisID == 3 && CampaniaID == "201604" && UserData().CodigoZona == "1405")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c04.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }

                                else if (UserData().PaisID == 3 && CampaniaID == "201605" && UserData().CodigoZona == "1319")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c05.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }
                                else if (UserData().PaisID == 3 && CampaniaID == "201605" && UserData().CodigoZona == "1401")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c05.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }
                                else if (UserData().PaisID == 3 && CampaniaID == "201605" && UserData().CodigoZona == "1410")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c05.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }
                                else if (UserData().PaisID == 3 && CampaniaID == "201605" && UserData().CodigoZona == "1405")
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + "http://issuu.com/somosbelcorp/docs/piloto.esika.chile.c05.2016" + "\" style=\"color:#333;\">Esika</a></td>";
                                }
                                else
                                {
                                    mailBody += "<td width=\"98\" style=\"text-align:center;\"><a href=\"" + catalogoEsika.SkinURL + "\" style=\"color:#333;\">Esika</a></td>";
                                }

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
                        String[] NombreClienteConsultora = item.Nombre.Split(' ');
                        mailBody += " <td style=\"padding: 0px 0px 15px 0px; text-align:left; display:block;\"><b>Hola </b>" + NombreClienteConsultora[0] + ",</td>";
                        mailBody += " </tr>";
                        /*RE2584 - CS(CGI) - INI */
                        mailBody += "<tr>";
                        mailBody += "<td style=\"padding: 0px 0px 15px 0px; text-align:left; display:block;\">";
                        mailBody += "Soy <b>" + UserData().NombreConsultora + "</b>, tu consultora de belleza Belcorp, te envío los catálogos de esta campaña.";
                        mailBody += "</td>";
                        mailBody += "</tr>";
                        mailBody += "<tr>";
                        mailBody += "<td style=\"padding: 0px 0px 15px 0px; text-align:left; display:block;\">Recuerda que tienes hasta el día <b>" + FechaFacturacion + "</b> para enviarme tu pedido.";
                        mailBody += "</td>";
                        mailBody += " </tr>";
                        //mailBody += "<tr>";
                        //mailBody += "<td style=\"padding: 0px 0px 15px 0px; text-align:left;\">Cualquier duda comunícate conmigo</td>";                       
                        //mailBody += " </tr>";
                        if (!UserData().EMail.ToString().Equals(string.Empty))
                        {
                            mailBody += "<tr>";
                            mailBody += "<td>Cualquier duda comunícate conmigo; mi correo electrónico es: </td>";
                            /*RE2584 - CS(CGI) - FIN*/
                            mailBody += "</tr>";
                            mailBody += "<tr>";
                            mailBody += "<td><b><a href=\"#\" style=\"color:#333333; text-align:left;\">" + UserData().EMail + "</a></b></td>";
                            mailBody += " </tr>";
                        }
                        if (!UserData().Telefono.ToString().Equals(string.Empty))
                        {
                            mailBody += "<tr>";
                            mailBody += "<td style=\"text-align:left;\">Mi Teléfono es: <b>" + UserData().Telefono + "</b></td>";
                            mailBody += "</tr>";
                        }
                        if (!UserData().Celular.ToString().Equals(string.Empty))
                        {
                            mailBody += "<tr>";
                            mailBody += "<td style=\"text-align:left;\">Mi Celular es: <b>" + UserData().Celular + "</b></td>";
                            mailBody += "</tr>";
                        }
                        mailBody += "<tr><td>" + Mensaje + "</td></tr>";
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

                        #region Catalogo Anterior
                        //mailBody += "<div style=\"height: 50px; background:#6C207F;\"></div>";
                        //mailBody += "<div style=\"text-align:center; background-color:#F0F0F0; overflow:hidden; display:block; padding: 24px 0px 24px 0px;\">";
                        //mailBody += "<div style=\"width:722px; margin: 0px auto; text-align:left;\">";

                        ///* Div Contenedor de Imagenes de Catalogo */

                        //mailBody += "<div style=\"float:left; padding: 0px 0px 0px 0px; width:452px;\">";
                        //mailBody += "<div style=\"color:#000000; font-size:35px;\">Catálogos</div>";
                        //mailBody += "<div style=\"color:#6C207F; font-size:25px; padding: 0px 0px 35px 50px;\">VIRTUALES</div>";


                        ///* Aquí comienza la iteración */

                        //if (item.LBel == "1")
                        //{
                        //    mailBody += "<div style=\"width:98px; float:left; margin: 0px 15px 0px 0px;\">";
                        //    mailBody += "<div style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\">";
                        //    mailBody += "<img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.LBel).DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\">";
                        //    mailBody += "</div>";
                        //    mailBody += "<div style=\"text-align:center; padding: 10px 0px 0px 0px;\"><a href=\"" + Url + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.LBel).DocumentID + "\" style=\"color:#333;\">LBel</a></div>";
                        //    mailBody += "</div>";
                        //}
                        //if (item.Cyzone == "1")
                        //{
                        //    mailBody += "<div style=\"width:98px; float:left; margin: 0px 15px 0px 0px;\">";
                        //    mailBody += "<div style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\">";
                        //    mailBody += "<img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Cyzone).DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\">";
                        //    mailBody += "</div>";
                        //    mailBody += "<div style=\"text-align:center; padding: 10px 0px 0px 0px;\"><a href=\"" + Url + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Cyzone).DocumentID + "\" style=\"color:#333;\">Cyzone</a></div>";
                        //    mailBody += "</div>";
                        //}

                        //if (item.Esika == "1")
                        //{
                        //    mailBody += "<div style=\"width:98px; float:left; margin: 0px 15px 0px 0px;\">";
                        //    mailBody += "<div style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\">";
                        //    mailBody += "<img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Esika).DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\">";
                        //    mailBody += "</div>";
                        //    mailBody += "<div style=\"text-align:center; padding: 10px 0px 0px 0px;\"><a href=\"" + Url + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Esika).DocumentID + "\" style=\"color:#333;\">Esika</a></div>";
                        //    mailBody += "</div>";
                        //}

                        //if (item.Finart == "1")
                        //{
                        //    mailBody += "<div style=\"width:98px; float:left; margin: 0px 15px 0px 0px;\">";
                        //    mailBody += "<div style=\"background:#D7D7D7; padding: 4px 0px 4px 4px;\">";
                        //    mailBody += "<img src=\"" + Constantes.CatalogoUrlParameters.UrlPart01 + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Finart).DocumentID + Constantes.CatalogoUrlParameters.UrlPart02 + "\">";
                        //    mailBody += "</div>";
                        //    mailBody += "<div style=\"text-align:center; padding: 10px 0px 0px 0px;\"><a href=\"" + Url + catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Finart).DocumentID + "\" style=\"color:#333;\">Finart</a></div>";
                        //    mailBody += "</div>";
                        //}
                        ///*Fin iteración de Imagenes*/

                        //mailBody += "</div>";
                        ///* Fin de Contenedor de Imagenes */

                        ///*Inicia el contenedor del correo*/
                        //mailBody += "<div style=\"float:right; padding: 20px 20px 30px 20px; width:228px; background:#E5E5E5; line-height: 18px;\">";
                        //mailBody += "<div style=\"padding: 0px 0px 15px 0px;\"><b>Hola:</b> " + item.Nombre + "</div>";
                        //mailBody += "<div style=\"padding: 0px 0px 15px 0px;\">";
                        //mailBody += "Soy tu consultora <b>" + UserData().NombreConsultora + "</b> Aqui te envio los enlaces de los catálogos de <b>" + UserData().NombreCorto + "</b> vigente hasta el <b>07/03/2013</b>";
                        //mailBody += "</div>";
                        //mailBody += "<div style=\"padding: 0px 0px 15px 0px;\">Cualquier duda comunícate conmigo</div>";
                        //mailBody += "<div style=\"padding: 0px 0px 15px 0px;\">";
                        //if (!UserData().EMail.ToString().Equals(string.Empty))
                        //{
                        //    mailBody += "<div>Mi correo electrónico es:</div>";
                        //    mailBody += "<div><b>" + UserData().EMail + "</b></div>";
                        //}
                        //if (!UserData().Telefono.ToString().Equals(string.Empty))
                        //    mailBody += "<div>Mi Teléfono es: <b>" + UserData().Telefono + "</b></div>";
                        //if (!UserData().Celular.ToString().Equals(string.Empty))
                        //    mailBody += "<div>Mi Celular es: <b>" + UserData().Celular + "</b></div>";
                        //mailBody += "</div>";

                        //mailBody += "</div>";
                        ///*Fin del contenedor del correo*/

                        //mailBody += "</div>";
                        //mailBody += "</div>";

                        ///*Pie dePagina*/
                        //mailBody += "<div style=\"height: 50px; background:#FFFFFF; text-align:center;\">";
                        //mailBody += "<div style=\"width:722px; margin: 0px auto;\">";
                        //mailBody += "<div style=\"float:left; padding: 19px 0px 0px 0px;\"> <b>Recuerda</b> debes tener internet para ver los Catálogos</div>";
                        //mailBody += "<div style=\"float:right; padding: 19px 0px 0px 0px; font-size: 11px; color:#6C207F;\">Copyright Belcorp 2013. All Rights Reserved</div>";
                        //mailBody += "</div>";
                        //mailBody += "</div>";

                        #endregion

                        //Mejora - Correo
                        //Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", item.Email, "Revisa Tus Catálogos " + UserData().NombreCorto, mailBody, true, string.Format("{0} - Envio de Catalogos", Util.SinAcentosCaracteres(nomPais.ToUpper())));
                        //Util.EnviarMailMasivoColas2(Globals.EmailCatalogos, item.Email, "Revisa Tus Catálogos " + CampaniaID, mailBody, true, String.Empty, UserData().NombreConsultora);

                        if (!ValidarCorreoFormato(item.Email))
                        {
                            CorreosInvalidos += item.Email + "; ";
                        }
                        else
                        {
                            Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", item.Email, "(" + UserData().CodigoISO + ") Revisa Tus Catálogos " + CampaniaID, mailBody, true, UserData().NombreConsultora);
                        }
                    }
                    using (ClienteServiceClient sv = new ClienteServiceClient())
                    {
                        sv.InsCatalogoCampania(UserData().PaisID, UserData().CodigoConsultora, Convert.ToInt32(CampaniaID));
                    }
                    if (string.IsNullOrEmpty(CorreosInvalidos))
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Se envió satisfactoriamente el correo a los cliente(s) seleccionado(s).",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Los siguientes correos no fueron enviados pues no tienen un formato correcto: " + CorreosInvalidos,
                            extra = ""
                        });
                    }
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        message = "No se pudo realizar el envió de correos a lo(s) clientes seleccionados, debido a que por ahora no existen catálogos publicados para esta Campaña.",
                        extra = ""
                    });
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
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

        private string CalcularCampaniaAnterior(string CampaniaActual)
        {
            if (CampaniaActual.Substring(4, 2) == "01")
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) - 1).ToString() + UserData().NroCampanias.ToString();
            else
                return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(CampaniaActual.Substring(4, 2)) - 1).ToString().PadLeft(2, '0');
        }

        private string CalcularCampaniaSiguiente(string CampaniaActual)
        {
            if (CampaniaActual.Substring(4, 2) == UserData().NroCampanias.ToString())
                return (Convert.ToInt32(CampaniaActual.Substring(0, 4)) + 1).ToString() + "01";
            else
                return CampaniaActual.Substring(0, 4) + (Convert.ToInt32(CampaniaActual.Substring(4, 2)) + 1).ToString().PadLeft(2, '0');
        }

        public bool Email(string EmailsLbel, string EmailsCyzone, string EmailsEsika, string EmailsFinart, string Mensaje)
        {
            string Url = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/CatalogoVirtual.aspx?DocumentId=";
            #region Mensaje a Enviar

            string mailBody = string.Empty;
            mailBody = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
            mailBody += "<div style='font-size:12px;'> " + Mensaje.Replace("\n", "<br />") + "</div> <br />";


            //mailBody += "<div style='font-size:12px;'> " + Mensaje + "</div> <br />";

            #endregion

            Catalogo entidad = new Catalogo(); ;
            List<Catalogo> catalogos = null;
            try
            {
                catalogos = this.GetCatalogosPublicados(UserData().CodigoISO, UserData().CampaniaID.ToString());
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return false;
            }

            if (EmailsLbel.ToString().Trim() != string.Empty)
            {
                entidad = catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.LBel);
                if ((entidad != null) || (!entidad.DocumentID.ToString().Equals(string.Empty)))
                {
                    var emails = EmailsLbel.Split(',');
                    //var emails = ("eflorespalma@gmail.com,chino_nemesis4@hotmail.com").Split(',');
                    //await Task.Run(() => LoadConsultorasCache(11));
                    //Util.EnviarMailMasivo("belcorpit2@belcorp.biz", emails, "Catálogo LBel", mailBody + "<a href='" + Url + entidad.DocumentID + "' style='font-size:12px;'>Ver Catálogo</a> <br />", true);
                }
            }
            if (EmailsCyzone.ToString().Trim() != string.Empty)
            {
                entidad = catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Cyzone);
                if ((entidad != null) || (!entidad.DocumentID.ToString().Equals(string.Empty)))
                {
                    var emails = EmailsCyzone.Split(',');
                    //var emails = ("edgar.flores@gestionysistemas.com").Split(',');
                    //Util.EnviarMailMasivo("belcorpit2@belcorp.biz", emails, "Catálogo Cyzone", mailBody + "<a href='" + Url + entidad.DocumentID + "' style='font-size:12px;'>Ver Catálogo</a> <br />", true);
                }
            }
            if (EmailsEsika.ToString().Trim() != string.Empty)
            {
                entidad = catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Esika);
                if ((entidad != null) || (!entidad.DocumentID.ToString().Equals(string.Empty)))
                {
                    var emails = EmailsEsika.Split(',');
                    //var emails = ("edgar.flores@gestionysistemas.com").Split(',');
                    //Util.EnviarMailMasivo("belcorpit2@belcorp.biz", emails, "Catálogo Esika", mailBody + "<a href='" + Url + entidad.DocumentID + "' style='font-size:12px;'>Ver Catálogo</a> <br />", true);
                }
            }
            if (EmailsFinart.ToString().Trim() != string.Empty)
            {
                entidad = catalogos.Find(x => x.IdMarcaCatalogo == Constantes.Marca.Finart);
                if ((entidad != null) || (!entidad.DocumentID.ToString().Equals(string.Empty)))
                {
                    var emails = EmailsFinart.Split(',');
                    //var emails = ("edgar.flores@gestionysistemas.com").Split(',');
                    //Util.EnviarMailMasivo("belcorpit2@belcorp.biz", emails, "Catálogo Finart", mailBody + "<a href='" + Url + entidad.DocumentID + "' style='font-size:12px;'>Ver Catálogo</a> <br />", true);
                }
            }
            return true;
        }

        #endregion

        #region Molde Correo Anterior
        //[HttpPost]
        //public JsonResult EnviarEmail(string EmailsLbel, string EmailsCyzone, string EmailsEsika, string EmailsFinart, string Mensaje)
        //{
        //    //int lbel = 0, cyzone = 0, esika = 0, finart = 0;
        //    //List<KeyValuePair<string, object>> lst = EmailsLbel.Split(',').ToList().Select(x => new KeyValuePair<string, object>(x[0],)).ToList();
        //    //lstPaises = lst.ToList().Select(t => new KeyValuePair<string, string>(t.PaisID.ToString(), t.Nombre.ToString())).ToList();



        //    try
        //    {


        //        //EmailsLbel


        //        bool _rslt = true;
        //        bool _validacion = false;
        //        if (EmailsLbel == "0" || EmailsCyzone == "0" || EmailsEsika == "0" || EmailsFinart == "0")
        //        {
        //            List<BECliente> lst;
        //            using (ClienteServiceClient sv = new ClienteServiceClient())
        //            {
        //                lst = sv.SelectByConsultora(UserData().PaisID, UserData().ConsultoraID).ToList();
        //            }
        //            var data = (from req in lst
        //                        where req.eMail.ToString().Trim() == string.Empty
        //                        select req).ToList();

        //            if (data.Count > 0)
        //                _validacion = true;
        //            else
        //            {
        //                string Emails = string.Empty;
        //                foreach (var item in lst)
        //                {
        //                    if (Emails == string.Empty)
        //                        Emails = item.eMail;
        //                    else
        //                        Emails = Emails + "," + item.eMail;
        //                }
        //                _rslt = Email(EmailsLbel == "0" ? Emails : string.Empty, EmailsLbel == "0" ? Emails : string.Empty, EmailsLbel == "0" ? Emails : string.Empty, EmailsLbel == "0" ? Emails : string.Empty, Mensaje);
        //                if (_rslt)
        //                {
        //                    return Json(new
        //                    {
        //                        success = true,
        //                        message = "Se envió satisfactoriamente el correo a los cliente(s) seleccionado(s).",
        //                        extra = ""
        //                    });
        //                }
        //                else
        //                {
        //                    return Json(new
        //                    {
        //                        success = false,
        //                        message = "Por favor vuelva ingresar en unos momentos, ya que el servicio de catálogos virtuales está teniendo problemas.",
        //                        extra = "R"
        //                    });
        //                }
        //            }
        //        }

        //        if (!_validacion)
        //        {
        //            _rslt = Email(EmailsLbel, EmailsCyzone, EmailsEsika, EmailsFinart, Mensaje);
        //            if (_rslt)
        //            {
        //                return Json(new
        //                {
        //                    success = true,
        //                    message = "Se envió satisfactoriamente el correo a los cliente(s) seleccionado(s).",
        //                    extra = ""
        //                });
        //            }
        //            else
        //            {
        //                return Json(new
        //                {
        //                    success = false,
        //                    message = "Por favor vuelva ingresar en unos momentos, ya que el servicio de catálogos virtuales está teniendo problemas.",
        //                    extra = "R"
        //                });
        //            }
        //        }
        //        else
        //        {
        //            return Json(new
        //            {
        //                success = false,
        //                message = "No todos los clientes seleccionados tienen un correo electronico registrado, verifique",
        //                extra = ""
        //            });
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //}
        #endregion

        #region Functions

        public List<Catalogo> GetCatalogosPublicados(string paisISO, string campaniaId)
        {
            List<Catalogo> catalogos = new List<Catalogo>();
            string urlISSUUSearch = "http://search.issuu.com/api/2_0/document?username=somosbelcorp&q=";
            string urlISSUUVisor = "http://issuu.com/somosbelcorp/docs/";
            string parameterDisplayMain = "?e=1/2";

            try
            {
                string catalogoCampania = getPaisNombreByISO(paisISO) + ".c" + campaniaId.Substring(4, 2) + "." + campaniaId.Substring(0, 4);
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

                    if (docName == catalogoLbel) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.LBel, DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                    else if (docName == catalogoEsika) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Esika, DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                    else if (docName == catalogoCyzone) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Cyzone, DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                    else if (docName == catalogoFinart) catalogos.Add(new Catalogo { IdMarcaCatalogo = Constantes.Marca.Finart, DocumentID = documentId, SkinURL = urlISSUUVisor + docName + parameterDisplayMain });
                }
            }
            catch (Exception) { catalogos = new List<Catalogo>(); }
            return catalogos;
        }

        private string getPaisNombreByISO(string paisISO)
        {
            switch (paisISO)
            {
                case "AR": return "argentina";
                case "BO": return "bolivia";
                case "CL": return "chile";
                case "CO": return "colombia";
                case "CR": return "costarica";
                case "DO": return "republicadominicana";
                case "EC": return "ecuador";
                case "GT": return "guatemala";
                case "MX": return "mexico";
                case "PA": return "panama";
                case "PE": return "peru";
                case "PR": return "puertorico";
                case "SV": return "elsalvador";
                case "VE": return "venezuela";
                default: return "sinpais";
            }
        }

        #endregion

    }
}
        
