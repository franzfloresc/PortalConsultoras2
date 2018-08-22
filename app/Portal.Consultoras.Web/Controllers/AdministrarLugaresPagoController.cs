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
using System.Web.Mvc;

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

                var administrarLugaresPagoModel = new AdministrarLugaresPagoModel()
                {
                    listaPaises = DropDowListPaises(),
                };
                return View(administrarLugaresPagoModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new AdministrarLugaresPagoModel());
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vpaisID)
        {
            if (ModelState.IsValid)
            {
                List<BELugarPago> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectLugarPago(vpaisID).ToList();
                }

                var carpetaPais = Globals.UrlLugaresPago + "/" + userData.CodigoISO;
                if (lst.Count > 0) { lst.Update(x => x.ArchivoLogo = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ArchivoLogo)); }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize).OrderBy(x => x.Posicion);
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
                               id = a.LugarPagoID.ToString(),
                               cell = new string[]
                               {
                                   a.LugarPagoID.ToString(),
                                   a.PaisID.ToString(),
                                   a.ArchivoLogo,
                                   a.Nombre,
                                   a.UrlSitio,
                                   string.Empty,
                                   a.ArchivoInstructivo,
                                   a.UrlSitio,
                                   a.ArchivoInstructivo,
                                   a.TextoPago,
                                   a.Posicion.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarLugaresPago");
        }

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

        [HttpPost]
        public JsonResult Insertar(AdministrarLugaresPagoModel model)
        {
            try
            {
                BELugarPago entidad = Mapper.Map<AdministrarLugaresPagoModel, BELugarPago>(model);

                if (model.PaisID == 0)
                {
                    entidad.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                    model.PaisID = Convert.ToInt32(Request.Form["PaisID"].ToString().Substring(1));
                }

                if (entidad.ArchivoInstructivo == null)
                    entidad.ArchivoInstructivo = string.Empty;


                string tempImage01 = model.ArchivoLogo ?? string.Empty;
                string iso = Util.GetPaisISO(model.PaisID);
                if (!string.IsNullOrEmpty(tempImage01))
                {
                    string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = iso + "_" + model.LugarPagoID.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                    var carpetaPais = Globals.UrlLugaresPago + "/" + iso;
                    var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                    ConfigS3.SetFileS3(path, carpetaPais, newfilename);

                    entidad.ArchivoLogo = newfilename;
                }
                else
                {
                    entidad.ArchivoLogo = string.Empty;
                }

                int lintPosicion;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lintPosicion = sv.InsertLugarPago(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito tu lugar de pago.",
                    extra = "",
                    posicion = lintPosicion,
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
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
        public JsonResult Actualizar(AdministrarLugaresPagoModel model)
        {
            try
            {
                BELugarPago entidad = Mapper.Map<AdministrarLugaresPagoModel, BELugarPago>(model);

                if (entidad.ArchivoInstructivo == null)
                    entidad.ArchivoInstructivo = string.Empty;

                string tempImage01 = model.ArchivoLogo ?? string.Empty;
                string tempImagenLogoAnterior01 = model.ArchivoLogoAnterior ?? string.Empty;
                string iso = Util.GetPaisISO(model.PaisID);

                if (!string.IsNullOrEmpty(tempImage01))
                {
                    string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = iso + "_" + model.LugarPagoID.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";

                    var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                    var carpetaPais = Globals.UrlLugaresPago + "/" + iso;
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

                int lintPosicion;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lintPosicion = sv.UpdateLugarPago(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu lugar de pago.",
                    extra = "",
                    posicion = lintPosicion,
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
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

        public JsonResult Eliminar(int LugarPagoID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteLugarPago(userData.PaisID, LugarPagoID);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
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
    }
}
