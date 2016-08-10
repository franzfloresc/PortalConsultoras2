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
    public class AdministrarLugaresPagoController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarLugaresPago/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                //IEnumerable<CampaniaModel> lstCampania = DropDowListCampanias(UserData().PaisID);
                var administrarLugaresPagoModel = new AdministrarLugaresPagoModel()
                {
                    listaPaises = DropDowListPaises()//,
                    //listaCampania = lstCampania
                };
                return View(administrarLugaresPagoModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(new AdministrarLugaresPagoModel());
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

        //private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        //{
        //    //PaisID = 11;
        //    IList<BECampania> lst;
        //    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
        //    {
        //        lst = sv.SelectCampanias(PaisID);
        //    }
        //    Mapper.CreateMap<BECampania, CampaniaModel>()
        //            .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
        //            .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

        //    return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        //}

        //public JsonResult ObtenterDropDownPorPais(int PaisID)
        //{
        //    IEnumerable<CampaniaModel> lstcampania = DropDowListCampanias(PaisID);

        //    return Json(new
        //    {
        //        lstCampania = lstcampania
        //    }, JsonRequestBehavior.AllowGet);
        //}

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vpaisID)
        {
            if (ModelState.IsValid)
            {
                List<BELugarPago> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectLugarPago(vpaisID).ToList();
                }

                // 1664
                if (lst != null)
                {
                    var carpetaPais = Globals.UrlLugaresPago + "/" + UserData().CodigoISO;
                    if (lst.Count > 0) { lst.Update(x => x.ArchivoLogo = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoLogo, Globals.RutaImagenesLugaresPago + "/" + UserData().CodigoISO)); }
                }
                

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BELugarPago> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "PaisNombre":
                            items = lst.OrderBy(x => x.PaisNombre);
                            break;
                        case "NombreCorto":
                            items = lst.OrderBy(x => x.NombreCorto);
                            break;
                        case "Lugar":
                            items = lst.OrderBy(x => x.Nombre);
                            break;
                        case "UrlSitio":
                            items = lst.OrderBy(x => x.UrlSitio);
                            break;
                        case "ArchivoLogo":
                            items = lst.OrderBy(x => x.ArchivoLogo);
                            break;
                        case "ArchivoInstructivo":
                            items = lst.OrderBy(x => x.ArchivoInstructivo);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "PaisNombre":
                            items = lst.OrderByDescending(x => x.PaisNombre);
                            break;
                        case "NombreCorto":
                            items = lst.OrderByDescending(x => x.NombreCorto);
                            break;
                        case "Lugar":
                            items = lst.OrderByDescending(x => x.Nombre);
                            break;
                        case "UrlSitio":
                            items = lst.OrderByDescending(x => x.UrlSitio);
                            break;
                        case "ArchivoLogo":
                            items = lst.OrderByDescending(x => x.ArchivoLogo);
                            break;
                        case "ArchivoInstructivo":
                            items = lst.OrderByDescending(x => x.ArchivoInstructivo);
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
                               id = a.LugarPagoID.ToString(),
                               cell = new string[] 
                               {
                                   a.LugarPagoID.ToString(),
                                   a.PaisID.ToString(),
                                   //a.CampaniaID.ToString(),
                                   a.ArchivoLogo,
                                   //a.NombreCorto,
                                   a.Nombre,
                                   a.UrlSitio,
                                   string.Empty,
                                   a.ArchivoInstructivo,
                                   string.Empty,
                                   a.UrlSitio,
                                   a.ArchivoInstructivo
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarLugaresPago");
        }

        //public JsonResult Mantener(HttpPostedFileBase flArchivoInstructivo, AdministrarLugaresPagoModel model)
        [HttpPost]
        public ActionResult Mantener(AdministrarLugaresPagoModel model)
        {
            var result = model.LugarPagoID == 0 ? Insertar(model) : Actualizar(model);
            if (Request.IsAjaxRequest())
            {
                return result;
            }
            return Content(JsonConvert.SerializeObject(result.Data), "text/html");
        }
        
        //public JsonResult Insertar(HttpPostedFileBase flArchivoInstructivo, AdministrarLugaresPagoModel model)
        [HttpPost]
        public JsonResult Insertar(AdministrarLugaresPagoModel model)
        {
            try
            {
                Mapper.CreateMap<AdministrarLugaresPagoModel, BELugarPago>()
                   .ForMember(t => t.LugarPagoID, f => f.MapFrom(c => c.LugarPagoID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   //.ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                   .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                   .ForMember(t => t.UrlSitio, f => f.MapFrom(c => c.UrlSitio))
                   .ForMember(t => t.ArchivoLogo, f => f.MapFrom(c => c.ArchivoLogo))
                   .ForMember(t => t.ArchivoInstructivo, f => f.MapFrom(c => c.ArchivoInstructivo));

                BELugarPago entidad = Mapper.Map<AdministrarLugaresPagoModel, BELugarPago>(model);

                if (model.PaisID == 0)
                {
                    entidad.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                    model.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                }

                //string finalPath = string.Empty;
                //string fileName = string.Empty;
                //if (flArchivoInstructivo != null)
                //{
                //    fileName = Path.GetFileName(flArchivoInstructivo.FileName);
                //    string pathBanner = Server.MapPath("~/Content/FileConsultoras");
                //    if (!Directory.Exists(pathBanner))
                //        Directory.CreateDirectory(pathBanner);
                //    finalPath = Path.Combine(pathBanner, fileName);
                //    flArchivoInstructivo.SaveAs(finalPath);
                //}

                //entidad.ArchivoInstructivo = fileName;

                if (entidad.ArchivoInstructivo == null)
                    entidad.ArchivoInstructivo = string.Empty;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    string tempImage01 = model.ArchivoLogo ?? string.Empty;
                    string ISO = Util.GetPaisISO(model.PaisID);
                    /*
                    if (!string.IsNullOrEmpty(tempImage01))
                        entidad.ArchivoLogo = FileManager.CopyImagesMatriz(Globals.RutaImagenesLugaresPago + "\\" + ISO, tempImage01, Globals.RutaImagenesTempLugaresPago, ISO, model.LugarPagoID.ToString(), "01");
                    else
                        entidad.ArchivoLogo = string.Empty;
                    */
                    // 1664
                    if (!string.IsNullOrEmpty(tempImage01))
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.LugarPagoID.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                        var carpetaPais = Globals.UrlLugaresPago + "/" + ISO;
                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);

                        entidad.ArchivoLogo = newfilename;
                    }
                    else
                    {
                        entidad.ArchivoLogo = string.Empty;
                    }

                    sv.InsertLugarPago(entidad);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempLugaresPago, tempImage01);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito tu lugar de pago.",
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

        //public JsonResult Actualizar(HttpPostedFileBase flArchivoInstructivo, AdministrarLugaresPagoModel model)
        [HttpPost]
        public JsonResult Actualizar(AdministrarLugaresPagoModel model)
        {
            try
            {
                Mapper.CreateMap<AdministrarLugaresPagoModel, BELugarPago>()
                   .ForMember(t => t.LugarPagoID, f => f.MapFrom(c => c.LugarPagoID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   //.ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                   .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                   .ForMember(t => t.UrlSitio, f => f.MapFrom(c => c.UrlSitio))
                   .ForMember(t => t.ArchivoLogo, f => f.MapFrom(c => c.ArchivoLogo))
                   .ForMember(t => t.ArchivoLogoAnterior, f => f.MapFrom(c => c.ArchivoLogoAnterior))
                   .ForMember(t => t.ArchivoInstructivo, f => f.MapFrom(c => c.ArchivoInstructivo));

                BELugarPago entidad = Mapper.Map<AdministrarLugaresPagoModel, BELugarPago>(model);

                //string finalPath = string.Empty;
                //string fileName = string.Empty;
                //if (flArchivoInstructivo != null)
                //{
                //    fileName = Path.GetFileName(flArchivoInstructivo.FileName);
                //    string pathBanner = Server.MapPath("~/Content/FileConsultoras");
                //    if (!Directory.Exists(pathBanner))
                //        Directory.CreateDirectory(pathBanner);
                //    finalPath = Path.Combine(pathBanner, fileName);
                //    flArchivoInstructivo.SaveAs(finalPath);
                //}

                //entidad.ArchivoInstructivo = fileName;

                if (entidad.ArchivoInstructivo == null)
                    entidad.ArchivoInstructivo = string.Empty;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    string tempImage01 = model.ArchivoLogo ?? string.Empty;
                    string tempImagenLogoAnterior01 = model.ArchivoLogoAnterior ?? string.Empty;
                    string ISO = Util.GetPaisISO(model.PaisID);

                    // 1664
                    if (!string.IsNullOrEmpty(tempImage01))
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.LugarPagoID.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        var carpetaPais = Globals.UrlLugaresPago + "/" + ISO;
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);

                        if (tempImagenLogoAnterior01 != string.Empty)
                        {
                            ConfigS3.DeleteFileS3(carpetaPais, tempImagenLogoAnterior01);
                        }

                        entidad.ArchivoLogo = newfilename;
                    }
                    else
                    {
                        entidad.ArchivoLogo = string.Empty;
                    }

                    /*
                    if (tempImage01 != tempImagenLogoAnterior01)
                    {
                        //if (!model.ImagenProducto01.ToString().Trim().Equals("prod_grilla_vacio.png"))
                        entidad.ArchivoLogo = FileManager.CopyImagesMatriz(Globals.RutaImagenesLugaresPago + "\\" + ISO, tempImage01, Globals.RutaImagenesTempLugaresPago, ISO, model.LugarPagoID.ToString(), "01");
                        FileManager.DeleteImage(Globals.RutaImagenesLugaresPago + "\\" + ISO, tempImagenLogoAnterior01);
                    }
                    else if (string.IsNullOrEmpty(tempImage01))
                        entidad.ArchivoLogo = string.Empty;
                    */
                    sv.UpdateLugarPago(entidad);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempLugaresPago, tempImage01);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu lugar de pago.",
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

        public JsonResult Eliminar(int LugarPagoID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteLugarPago(UserData().PaisID, LugarPagoID);
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
