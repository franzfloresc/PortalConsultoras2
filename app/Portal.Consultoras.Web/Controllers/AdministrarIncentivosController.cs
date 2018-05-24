using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

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
                lst = UserData().RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(UserData().PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

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

                var carpetaPais = Globals.UrlIncentivos + "/" + UserData().CodigoISO;
                if (lst.Count > 0) { lst.Update(x => x.ArchivoPortada = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ArchivoPortada)); }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEIncentivo> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

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
            var result = model.IncentivoID == 0 ? Insertar(flArchivoPDF, model) : Actualizar(flArchivoPDF, model);
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
                BEIncentivo entidad = Mapper.Map<AdministrarIncentivosModel, BEIncentivo>(model);

                if (model.PaisID == 0)
                {
                    entidad.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                    model.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                }

                string fileName = string.Empty;
                if (flArchivoPDF != null)
                {
                    fileName = Path.GetFileName(flArchivoPDF.FileName) ?? "";

                    string pathBanner = Globals.RutaTemporales;
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    var finalPath = Path.Combine(pathBanner, fileName);
                    flArchivoPDF.SaveAs(finalPath);

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
                    string iso = Util.GetPaisISO(model.PaisID);

                    if (!string.IsNullOrEmpty(tempImage01))
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        var carpetaPais = Globals.UrlIncentivos + "/" + UserData().CodigoISO;
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ArchivoPortada = newfilename;
                    }
                    else
                        entidad.ArchivoPortada = string.Empty;

                    sv.InsertIncentivo(entidad);
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
                BEIncentivo entidad = Mapper.Map<AdministrarIncentivosModel, BEIncentivo>(model);

                switch (model.grupoUrlPDF.ToLower())
                {
                    case "url":
                        entidad.ArchivoPDF = string.Empty;
                        break;
                    case "pdf":
                        if (flArchivoPDF != null)
                        {
                            var fileName = Path.GetFileName(flArchivoPDF.FileName) ?? "";

                            string pathBanner = Globals.RutaTemporales;
                            if (!Directory.Exists(pathBanner))
                                Directory.CreateDirectory(pathBanner);
                            var finalPath = Path.Combine(pathBanner, fileName);
                            flArchivoPDF.SaveAs(finalPath);

                            var carpetaPais = Globals.UrlFileConsultoras + "/" + UserData().CodigoISO;
                            ConfigS3.SetFileS3(finalPath, carpetaPais, fileName);

                            entidad.ArchivoPDF = fileName;
                        }
                        entidad.Url = string.Empty;
                        break;

                }

                using (SACServiceClient sv = new SACServiceClient())
                {
                    string tempImage01 = model.ArchivoPortada ?? string.Empty;
                    string tempImagenLogoAnterior01 = model.ArchivoPortadaAnterior ?? string.Empty;
                    string iso = Util.GetPaisISO(model.PaisID);

                    if (tempImage01 != tempImagenLogoAnterior01)
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        var carpetaPais = Globals.UrlIncentivos + "/" + UserData().CodigoISO;

                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenLogoAnterior01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ArchivoPortada = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage01))
                        entidad.ArchivoPortada = string.Empty;

                    sv.UpdateIncentivo(entidad);
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
