using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;
using System.IO;

namespace Portal.Consultoras.Web.Controllers
{
    public class CronogramaFICController : BaseController
    {
        //
        // GET: /CronogramaFIC/

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CronogramaFIC/Index"))
                return RedirectToAction("Index", "Bienvenida");
            CronogramaFICModel model = new CronogramaFICModel();
            model.listaPaises = DropDowListPaises();
            model.listaZonas = new List<ZonaModel>();
            model.DropDownListCampania = CargarCampania();
            model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            return View(model);
        }

        public ActionResult ConfigurarCronogramaFIC()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CronogramaFIC/ConfigurarCronogramaFIC"))
                return RedirectToAction("Index", "Bienvenida");
            CronogramaFICModel model = new CronogramaFICModel();
            model.listaPaises = DropDowListPaises();
            model.DropDownListCampania = CargarCampania();
            //model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            return View(model);
        }

        public ActionResult DesactivarCronogramaFIC()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CronogramaFIC/DesactivarCronogramaFIC"))
                return RedirectToAction("Index", "Bienvenida");
            CronogramaFICModel model = new CronogramaFICModel();
            model.listaPaises = DropDowListPaises();
            model.listaZonas = DropDownListZonas(UserData().PaisID);
            model.DropDownListCampania = CargarCampania();
            return View(model);
        }

        public ActionResult DescargaModelo()
        {
            string finalPath = string.Empty, httpPath = string.Empty;

            string fileName = "PlantillaModelFIC.xlsx";
            string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");
            httpPath = Url.Content("~/Content/ArchivoFaltante") + "/" + fileName;
            if (!Directory.Exists(pathfaltante))
                Directory.CreateDirectory(pathfaltante);
            finalPath = Path.Combine(pathfaltante, fileName);

            HttpContext.Response.Clear();
            HttpContext.Response.Buffer = false;
            HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + fileName);
            HttpContext.Response.Charset = "UTF-8";
            HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Response.ContentType = "application/octet-stream";
            HttpContext.Response.TransmitFile(finalPath);
            HttpContext.Response.Flush();
            HttpContext.Response.End();

            return View();
        }

        public ActionResult ConsultarCronogramaFIC(string sidx, string sord, int page, int rows, string CampaniaID, string PaisID)
        {
            if (ModelState.IsValid)
            {
                List<BECronogramaFIC> lst;
                if (PaisID == "" || CampaniaID == "")
                    lst = new List<BECronogramaFIC>();
                else
                {
                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        lst = sv.GetCronogramaFICByCampania(Convert.ToInt32(PaisID), CampaniaID).ToList();
                    }
                }
                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
                IEnumerable<BECronogramaFIC> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Zona":
                            items = lst.OrderBy(x => x.Zona);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderBy(x => x.Campania);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderBy(x => x.FechaFin);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Zona":
                            items = lst.OrderByDescending(x => x.Zona);
                            break;
                        case "FechaInicioWeb":
                            items = lst.OrderByDescending(x => x.Campania);
                            break;
                        case "FechaFinWeb":
                            items = lst.OrderByDescending(x => x.FechaFin);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ZonaID,
                               cell = new string[] 
                               {
                                   a.Campania.ToString(),
                                   a.Zona.ToString(),
                                   //a.FechaFin == null ? "" : Convert.ToDateTime(a.FechaFin.ToString()).ToShortDateString(),
                                   a.FechaFin == null ? "" : Convert.ToDateTime(a.FechaFin.ToString()).Day.ToString() + " de " + NombreMes(Convert.ToDateTime(a.FechaFin.ToString()).Month),                                   
                                   a.ZonaID.ToString(),
                                   a.CampaniaID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult ObtenerZonas(int PaisID, int CampaniaID)
        {
            bool issuccess = true;
            List<ZonaModel> lstZonasActivas;
            List<ZonaModel> lstZonasInactivas;
            try
            {
                lstZonasActivas = ObtenerZonasActivas(PaisID, CampaniaID);
                lstZonasInactivas = ObtenerZonasInactivas(PaisID, CampaniaID);
                issuccess = true;

                Session["lstZonasActivas"] = lstZonasActivas;
                Session["lstZonasInactivas"] = lstZonasInactivas;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }

            return Json(new
            {
                success = issuccess,
                lstZonasActivas = lstZonasActivas,
                lstZonasInactivas = lstZonasInactivas
            }, JsonRequestBehavior.AllowGet);

        }

        public JsonResult InsCronogramaFIC(int PaisID, int CampaniaID, string ZonaCodigo)
        {
            bool issuccess = true;
            List<ZonaModel> lstZonasActivas = new List<ZonaModel>();
            List<ZonaModel> lstZonasInactivas = new List<ZonaModel>();
            List<ZonaModel> lstZonasInactivasEliminar = new List<ZonaModel>();

            string[] Zonas = ZonaCodigo.Split(',');

            try
            {
                //using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                //{
                //    sv.InsInsCronogramaFIC(PaisID, CampaniaID.ToString(), ZonaCodigo);
                //}

                //issuccess = true;
                //lstZonasActivas = ObtenerZonasActivas(PaisID, CampaniaID);
                //lstZonasInactivas = ObtenerZonasInactivas(PaisID, CampaniaID);

                lstZonasActivas = (List<ZonaModel>)Session["lstZonasActivas"];
                lstZonasInactivas = (List<ZonaModel>)Session["lstZonasInactivas"];

                foreach (var item in lstZonasInactivas)
                {
                    foreach (string zona in Zonas)
                    {
                        if (zona.Trim() == item.Codigo.Trim())
                        {
                            lstZonasActivas.Add(item);
                            lstZonasInactivasEliminar.Add(item);
                            //lstZonasInactivas.Remove(item);
                        }
                    }
                }

                foreach (var item in lstZonasInactivasEliminar)
                {
                    ZonaModel zona = lstZonasInactivas.Where(x => x.ZonaID == item.ZonaID).First();
                    lstZonasInactivas.Remove(item);
                }

                lstZonasActivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));
                lstZonasInactivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));

                Session["lstZonasActivas"] = lstZonasActivas;
                Session["lstZonasInactivas"] = lstZonasInactivas;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                lstZonasActivas = null;
                lstZonasInactivas = null;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                lstZonasActivas = null;
                lstZonasInactivas = null;
            }

            return Json(new
            {
                success = issuccess,
                lstZonasActivas = lstZonasActivas,
                lstZonasInactivas = lstZonasInactivas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DelCronogramaFIC(int PaisID, int CampaniaID, string ZonaCodigo)
        {
            bool issuccess = true;
            List<ZonaModel> lstZonasActivas;
            List<ZonaModel> lstZonasInactivas;
            List<ZonaModel> lstZonasActivasEliminar = new List<ZonaModel>();

            string[] Zonas = ZonaCodigo.Split(',');

            try
            {
                //using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                //{
                //    sv.DelCronogramaFIC(PaisID, CampaniaID.ToString(), ZonaCodigo);
                //}

                //lstZonasActivas = ObtenerZonasActivas(PaisID, CampaniaID);
                //lstZonasInactivas = ObtenerZonasInactivas(PaisID, CampaniaID);
                //issuccess = true;

                lstZonasActivas = (List<ZonaModel>)Session["lstZonasActivas"];
                lstZonasInactivas = (List<ZonaModel>)Session["lstZonasInactivas"];

                foreach (var item in lstZonasActivas)
                {
                    foreach (string zona in Zonas)
                    {
                        if (zona.Trim() == item.Codigo.Trim())
                        {
                            lstZonasInactivas.Add(item);
                            lstZonasActivasEliminar.Add(item);
                            //lstZonasInactivas.Remove(item);
                        }
                    }
                }

                foreach (var item in lstZonasActivasEliminar)
                {
                    ZonaModel zona = lstZonasActivas.Where(x => x.ZonaID == item.ZonaID).First();
                    lstZonasActivas.Remove(item);
                }

                lstZonasActivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));
                lstZonasInactivas.Sort((x, y) => string.Compare(x.Codigo, y.Codigo));

                Session["lstZonasActivas"] = lstZonasActivas;
                Session["lstZonasInactivas"] = lstZonasInactivas;

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lstZonasActivas = null;
                lstZonasInactivas = null;
                issuccess = false;
            }

            return Json(new
            {
                success = issuccess,
                lstZonasActivas = lstZonasActivas,
                lstZonasInactivas = lstZonasInactivas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult MantenerCronogramaFIC(int PaisID, int CampaniaID, string ZonaCodigoEliminar, string ZonaCodigoInsertar)
        {
            bool issuccess = true;
            string mensaje;
            try
            {
                //ZonaCodigoEliminar = Session["ZonaCodigoEliminar"].ToString();
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    sv.InsInsCronogramaFIC(PaisID, CampaniaID.ToString(), ZonaCodigoInsertar);
                    sv.DelCronogramaFIC(PaisID, CampaniaID.ToString(), ZonaCodigoEliminar);
                }

                mensaje = "Los cambios han sido guardados correctamente.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                mensaje = "Ocurrió un error al guardar los cambios, por favor inténtelo más tarde.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
                mensaje = "Ocurrió un error al guardar los cambios, por favor inténtelo más tarde.";
            }

            return Json(new
            {
                success = issuccess,
                message = mensaje
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EstablecerSesion(string ZonaCodigoEliminar)
        {
            try
            {
                Session["ZonaCodigoEliminar"] = ZonaCodigoEliminar;
                return Json(new
                {
                    success = true,
                    message = "Se eliminó con éxito el Código de Oferta.",
                    extra = ""
                });
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
        public JsonResult Update(CronogramaFICModel model)
        {
            #region Validar Fechas

            string mensaje = string.Empty;

            if (model.FechaFin.ToShortDateString() == "01/01/0001")
                mensaje += "La Fecha de Inicio de Facturación no tiene el formato correcto, verifique dd/MM/yyyy. \n";

            if (!mensaje.Equals(string.Empty))
            {
                return Json(new
                {
                    success = false,
                    message = mensaje,
                    extra = ""
                });
            }

            #endregion

            try
            {
                Mapper.CreateMap<CronogramaFICModel, BECronogramaFIC>()
                    .ForMember(t => t.Zona, f => f.MapFrom(c => c.Zona))
                    .ForMember(t => t.Campania, f => f.MapFrom(c => c.Campania))
                    .ForMember(t => t.FechaFin, f => f.MapFrom(c => c.FechaFin));

                BECronogramaFIC entidad = Mapper.Map<CronogramaFICModel, BECronogramaFIC>(model);

                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    //entidad.PaisID = 11;
                    sv.UpdCronogramaFIC(model.PaisID, entidad.Campania, entidad.Zona, entidad.FechaFin);
                }
                return Json(new
                {
                    success = true,
                    message = "Cronograma actualizado satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public List<BECampania> CargarCampania()
        {
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                BECampania[] becampania = servicezona.SelectCampanias(11);
                return becampania.ToList();
            }
        }

        private List<ZonaModel> ObtenerZonasActivas(int PaisID, int CampaniaID)
        {
            //PaisID = 11;
            IList<BEZona> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectZonasActivasFIC(PaisID, CampaniaID).ToList();
            }
            Mapper.CreateMap<BEZona, ZonaModel>()
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

            return Mapper.Map<IList<BEZona>, List<ZonaModel>>(lst);
        }

        private List<ZonaModel> ObtenerZonasInactivas(int PaisID, int CampaniaID)
        {
            //PaisID = 11;
            IList<BEZona> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectZonasInactivasFIC(PaisID, CampaniaID).ToList();
            }
            Mapper.CreateMap<BEZona, ZonaModel>()
                    .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

            return Mapper.Map<IList<BEZona>, List<ZonaModel>>(lst);
        }

        [HttpPost]
        public string ProcesarMasivo(HttpPostedFileBase uplArchivo, CronogramaFICModel model)
        {
            int paisID = model.PaisID;
            int campaniaID = Convert.ToInt32(model.NombreCorto.Trim());
            string message = string.Empty;
            try
            {
                // valida que el archivo exista
                if (uplArchivo == null)
                {
                    return message = "El archivo especificado no existe.";
                }

                // valida la extensión del archivo
                if (!Util.isFileExtension(uplArchivo.FileName, Enumeradores.TypeDocExtension.Excel))
                {
                    return message = "El archivo especificado no es un documento de tipo MS-Excel.";
                }

                //Guarda el archivo en una ruta del servidor
                string finalPath = string.Empty, httpPath = string.Empty;
                string fileextension = Path.GetExtension(uplArchivo.FileName);

                if (!fileextension.ToLower().Equals(".xlsx"))
                {
                    return message = "Sólo se permiten archivos MS-Excel versiones 2007-2012.";
                }

                string fileName = Guid.NewGuid().ToString();
                string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");
                httpPath = Url.Content("~/Content/ArchivoFaltante") + "/" + fileName;
                if (!Directory.Exists(pathfaltante))
                    Directory.CreateDirectory(pathfaltante);
                finalPath = Path.Combine(pathfaltante, fileName + fileextension);
                uplArchivo.SaveAs(finalPath);

                bool IsCorrect = false;
                CronogramaFICModel prod = new CronogramaFICModel();
                IList<CronogramaFICModel> lista = Util.ReadXmlFile(finalPath, prod, false, ref IsCorrect);

                //elimina el documento, una vez que haya sido procesado
                System.IO.File.Delete(finalPath);

                if (IsCorrect && lista != null)
                {
                    Mapper.CreateMap<CronogramaFICModel, BECronogramaFIC>()
                   .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                   .ForMember(t => t.Zona, f => f.MapFrom(c => c.Zona));

                    var lst = Mapper.Map<IList<CronogramaFICModel>, IEnumerable<BECronogramaFIC>>(lista);

                    using (ZonificacionServiceClient srv = new ZonificacionServiceClient())
                    {
                        srv.InsCronogramaFICMasivo(paisID, campaniaID, lst.ToArray());
                    }
                    return message = "Se realizó satisfactoriamente la carga de datos.";
                }
                else
                {
                    return message = "Ocurrió un problema al cargar el documento o tal vez se encuentra vacío.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return message = "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return message = "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
        }

        public JsonResult CargarArbolRegionesZonas(string PaisID, string Codigocampaña, string ZonaID)
        {
            if (PaisID == "" || PaisID == null)
                return Json(null, JsonRequestBehavior.AllowGet);

            if (ZonaID == "" || ZonaID == null)
                ZonaID = "x";

            // consultar las regiones y zonas
            List<BECronogramaFIC> lst = new List<BECronogramaFIC>();
            List<String> zonas;

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.GetCronogramaFICByZona(Convert.ToInt32(PaisID), Codigocampaña, ZonaID).ToList();
            }

            zonas = (from item in lst
                     select item.Zona).ToList();

            zonas = (from item in zonas
                     select item).Distinct().ToList();

            // se crea el arbol de nodos para el control de la vista
            JsTreeModel2[] tree = zonas.Select(
                                 r => new JsTreeModel2
                                 {
                                     data = r,
                                     attr = new JsTreeAttribute_
                                         {
                                             tipo = 1,
                                             CodigoZona = r,
                                             selected = false
                                         },
                                     children = lst.Where(i => i.Zona.Trim() == r.Trim()).Select(
                                                         z => new JsTreeModel2
                                                         {
                                                             data = z.CodigoConsultora,
                                                             attr = new JsTreeAttribute_
                                                             {
                                                                 tipo = 2,
                                                                 CodigoZona = z.Zona,
                                                                 CodigoCampania = z.Campania,
                                                                 CodigoConsultora = z.CodigoConsultora,
                                                                 selected = false
                                                             }
                                                         }).ToArray()
                                 }).ToArray();
            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DeshabilitarConsultoras(List<BECronogramaFIC> lista)
        {
            try
            {
                // se hace la actualizacion de modificación de cronograma
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    foreach (BECronogramaFIC item in lista)
                    {
                        sv.DelCronogramaFICConsultora(UserData().PaisID, item.Campania, item.Zona, item.CodigoConsultora);
                    }
                }
                return Json(new
                {
                    success = true,
                    message = "Modificación de cronograma exitosa.",
                    extra = ""
                });
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

        public string NombreMes(int Mes)
        {
            string Result = string.Empty;
            switch (Mes)
            {
                case 1: Result = "Enero";
                    break;
                case 2: Result = "Febrero";
                    break;
                case 3: Result = "Marzo";
                    break;
                case 4: Result = "Abril";
                    break;
                case 5: Result = "Mayo";
                    break;
                case 6: Result = "Junio";
                    break;
                case 7: Result = "Julio";
                    break;
                case 8: Result = "Agosto";
                    break;
                case 9: Result = "Setiembre";
                    break;
                case 10: Result = "Octubre";
                    break;
                case 11: Result = "Noviembre";
                    break;
                case 12: Result = "Diciembre";
                    break;
            }
            return Result;
        }
    }
}
