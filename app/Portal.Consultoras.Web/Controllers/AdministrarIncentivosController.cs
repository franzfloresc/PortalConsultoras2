using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarIncentivosController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarIncentivos/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                IEnumerable<CampaniaModel> lstCampania = DropDowListCampanias(UserData().PaisID);
                var administrarIncentivosModel = new AdministrarIncentivosModel()
                {
                    listaPaises = DropDowListPaises(),
                    listaCampania = lstCampania
                };
                return View(administrarIncentivosModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new AdministrarIncentivosModel());
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

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            //PaisID = 11;
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenterDropDownPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lstcampania = DropDowListCampanias(PaisID);

            return Json(new
            {
                lstCampania = lstcampania
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vpaisID, int vCampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEIncentivo> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectIncentivos(vpaisID, vCampaniaID).ToList();
                }

                // 1664
                if (lst != null)
                {
                    var carpetaPais = Globals.UrlIncentivos + "/" + UserData().CodigoISO;
                    if (lst.Count > 0) { lst.Update(x => x.ArchivoPortada = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPortada, Globals.RutaImagenesIncentivos + "/" + UserData().CodigoISO)); }
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEIncentivo> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        //case "PaisNombre":
                        //    items = lst.OrderBy(x => x.PaisNombre);
                        //    break;
                        case "NombreCortoInicio":
                            items = lst.OrderBy(x => x.NombreCortoInicio);
                            break;
                        case "NombreCortoFin":
                            items = lst.OrderBy(x => x.NombreCortoFin);
                            break;
                        case "Titulo":
                            items = lst.OrderBy(x => x.Titulo);
                            break;
                        case "Subtitulo":
                            items = lst.OrderBy(x => x.Subtitulo);
                            break;
                        case "ArchivoPortada":
                            items = lst.OrderBy(x => x.ArchivoPortada);
                            break;
                        case "ArchivoPDF":
                            items = lst.OrderBy(x => x.ArchivoPDF);
                            break;
                        case "Url":
                            items = lst.OrderBy(x => x.Url);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        //case "PaisNombre":
                        //    items = lst.OrderByDescending(x => x.PaisNombre);
                        //    break;
                        case "NombreCortoInicio":
                            items = lst.OrderByDescending(x => x.NombreCortoInicio);
                            break;
                        case "NombreCortoFin":
                            items = lst.OrderByDescending(x => x.NombreCortoFin);
                            break;
                        case "Titulo":
                            items = lst.OrderByDescending(x => x.Titulo);
                            break;
                        case "Subtitulo":
                            items = lst.OrderByDescending(x => x.Subtitulo);
                            break;
                        case "ArchivoPortada":
                            items = lst.OrderByDescending(x => x.ArchivoPortada);
                            break;
                        case "ArchivoPDF":
                            items = lst.OrderByDescending(x => x.ArchivoPDF);
                            break;
                        case "Url":
                            items = lst.OrderByDescending(x => x.Url);
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
                    ISOPais = Util.GetPaisISO(vpaisID),
                    rows = from a in items
                           select new
                           {
                               id = a.IncentivoID.ToString(),
                               cell = new string[] 
                               {
                                   a.IncentivoID.ToString(),
                                   a.PaisID.ToString(),
                                   a.CampaniaIDInicio.ToString(),
                                   a.CampaniaIDFin.ToString(),
                                   a.ArchivoPortada,
                                   a.NombreCortoInicio,
                                   a.NombreCortoFin,
                                   a.Titulo,
                                   a.Subtitulo,
                                   string.Empty,
                                   a.Url,
                                   a.ArchivoPDF,
                                   string.Empty,
                                   a.Url,
                                   a.ArchivoPDF
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarIncentivos");
        }

        [HttpPost]
        public ActionResult Mantener(HttpPostedFileBase flArchivoPDF, AdministrarIncentivosModel model)
        {
            JsonResult result;
            result = model.IncentivoID == 0 ? Insertar(flArchivoPDF, model) : Actualizar(flArchivoPDF, model);
            if (Request.IsAjaxRequest())
            {
               return result;
            }
            return Content(JsonConvert.SerializeObject(result.Data), "text/html");
        }

        [HttpPost]
        public JsonResult Insertar(HttpPostedFileBase flArchivoPDF, AdministrarIncentivosModel model)
        {
            try
            {
                Mapper.CreateMap<AdministrarIncentivosModel, BEIncentivo>()
                   .ForMember(t => t.IncentivoID, f => f.MapFrom(c => c.IncentivoID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.CampaniaIDInicio, f => f.MapFrom(c => c.CampaniaIDInicio))
                   .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                   .ForMember(t => t.Titulo, f => f.MapFrom(c => c.Titulo))
                   .ForMember(t => t.Subtitulo, f => f.MapFrom(c => c.Subtitulo))
                   .ForMember(t => t.ArchivoPortada, f => f.MapFrom(c => c.ArchivoPortada))
                   .ForMember(t => t.ArchivoPDF, f => f.MapFrom(c => c.ArchivoPDF))
                   .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

                BEIncentivo entidad = Mapper.Map<AdministrarIncentivosModel, BEIncentivo>(model);

                if (model.PaisID == 0)
                {
                    entidad.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                    model.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                }

                string finalPath = string.Empty;
                string fileName = string.Empty;
                if (flArchivoPDF != null)
                {
                    fileName = Path.GetFileName(flArchivoPDF.FileName);

                    // string pathBanner = Server.MapPath("~/Content/FileConsultoras");
                    // 1664
                    string pathBanner = Globals.RutaTemporales;
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    finalPath = Path.Combine(pathBanner, fileName);
                    flArchivoPDF.SaveAs(finalPath);

                    // 1664
                    var carpetaPais = Globals.UrlFileConsultoras + "/" + UserData().CodigoISO;
                    ConfigS3.SetFileS3(finalPath, carpetaPais, fileName);

                    entidad.ArchivoPDF = fileName;
                }

                entidad.ArchivoPDF = fileName;

                if (entidad.Url == null)
                    entidad.Url = string.Empty;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    string tempImage01 = model.ArchivoPortada ?? string.Empty;
                    string ISO = Util.GetPaisISO(model.PaisID);

                    if (!string.IsNullOrEmpty(tempImage01))
                    {
                        // entidad.ArchivoPortada = FileManager.CopyImagesMatriz(Globals.RutaImagenesIncentivos + "\\" + ISO, tempImage01, Globals.RutaImagenesTempIncentivos, ISO, model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString(), "01");
                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        var carpetaPais = Globals.UrlIncentivos + "/" + UserData().CodigoISO;
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ArchivoPortada = newfilename;
                    }
                    else
                        entidad.ArchivoPortada = string.Empty;

                    sv.InsertIncentivo(entidad);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempIncentivos, tempImage01);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito tu incentivo.",
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

        [HttpPost]
        public JsonResult Actualizar(HttpPostedFileBase flArchivoPDF, AdministrarIncentivosModel model)
        {
            try
            {
                Mapper.CreateMap<AdministrarIncentivosModel, BEIncentivo>()
                   .ForMember(t => t.IncentivoID, f => f.MapFrom(c => c.IncentivoID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.CampaniaIDInicio, f => f.MapFrom(c => c.CampaniaIDInicio))
                   .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                   .ForMember(t => t.Titulo, f => f.MapFrom(c => c.Titulo))
                   .ForMember(t => t.Subtitulo, f => f.MapFrom(c => c.Subtitulo))
                   .ForMember(t => t.ArchivoPortada, f => f.MapFrom(c => c.ArchivoPortada))
                   .ForMember(t => t.ArchivoPortadaAnterior, f => f.MapFrom(c => c.ArchivoPortadaAnterior))
                   .ForMember(t => t.ArchivoPDF, f => f.MapFrom(c => c.ArchivoPDF))
                   .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

                BEIncentivo entidad = Mapper.Map<AdministrarIncentivosModel, BEIncentivo>(model);

                string finalPath = string.Empty;
                string fileName = string.Empty;

                switch (model.grupoUrlPDF.ToLower())
                {
                    case "url":
                        // no es pdf
                        entidad.ArchivoPDF = string.Empty;
                        break;
                    case "pdf":
                        // si hay pdf se guarda
                        if (flArchivoPDF != null)
                        {
                            fileName = Path.GetFileName(flArchivoPDF.FileName);
                            
                            // string pathBanner = Server.MapPath("~/Content/FileConsultoras");
                            // 1664
                            string pathBanner = Globals.RutaTemporales;
                            if (!Directory.Exists(pathBanner))
                                Directory.CreateDirectory(pathBanner);
                            finalPath = Path.Combine(pathBanner, fileName);
                            flArchivoPDF.SaveAs(finalPath); 
                             
                            // 1664
                            var carpetaPais = Globals.UrlFileConsultoras + "/" + UserData().CodigoISO;
                            ConfigS3.SetFileS3(finalPath, carpetaPais, fileName);

                            entidad.ArchivoPDF = fileName;
                        }
                        // no es url
                        entidad.Url = string.Empty;
                        break;
                        
                }

                using (SACServiceClient sv = new SACServiceClient())
                {
                    string tempImage01 = model.ArchivoPortada ?? string.Empty;
                    string tempImagenLogoAnterior01 = model.ArchivoPortadaAnterior ?? string.Empty;
                    string ISO = Util.GetPaisISO(model.PaisID);

                    if (tempImage01 != tempImagenLogoAnterior01)
                    {
                        //if (!model.ImagenProducto01.ToString().Trim().Equals("prod_grilla_vacio.png"))
                        /*
                        entidad.ArchivoPortada = FileManager.CopyImagesMatriz(Globals.RutaImagenesIncentivos + "\\" + ISO, tempImage01, Globals.RutaImagenesTempIncentivos, ISO, model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString(), "01");
                        FileManager.DeleteImage(Globals.RutaImagenesIncentivos + "\\" + ISO, tempImagenLogoAnterior01);
                        */

                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        var carpetaPais = Globals.UrlIncentivos + "/" + UserData().CodigoISO;

                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenLogoAnterior01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ArchivoPortada = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage01))
                        entidad.ArchivoPortada = string.Empty;

                    sv.UpdateIncentivo(entidad);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempIncentivos, tempImage01);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu incentivo.",
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

        public JsonResult Eliminar(int IncentivoID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteIncentivo(UserData().PaisID, IncentivoID);
                }
                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
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

    }
}
