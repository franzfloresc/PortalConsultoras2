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
    public class BannerPedidoController : BaseController
    {
        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "BannerPedido/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                IEnumerable<CampaniaModel> lstCampania = DropDowListCampanias(userData.PaisID);
                var administrarIncentivosModel = new AdministrarBannerPedidoModel()
                {
                    listaPaises = DropDowListPaises(),
                    listaCampania = lstCampania,
                    listaPoscionBannerPedido = DropDowListPosicionBannerPedido()
                };
                return View(administrarIncentivosModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(new AdministrarIncentivosModel());
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

        private IEnumerable<PosicionBannerPedidoModel> DropDowListPosicionBannerPedido()
        {
            List<PosicionBannerPedidoModel> lst = new List<PosicionBannerPedidoModel>();

            var oPosicionBannerPedidoModel = new PosicionBannerPedidoModel
            {
                PosicionBannerPedidoId = 1,
                PosicionBannerPedido = "Banner 1"
            };
            lst.Add(oPosicionBannerPedidoModel);

            var oPosicionBannerPedidoModel4 = new PosicionBannerPedidoModel
            {
                PosicionBannerPedidoId = 4,
                PosicionBannerPedido = "Banner 4"
            };
            lst.Add(oPosicionBannerPedidoModel4);

            return lst;

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
                List<BEBannerPedido> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectBannerPedido(vpaisID, vCampaniaID).ToList();
                }

                
                if (lst != null && lst.Count > 0)
                {
                    var carpetaPais = Globals.UrlBanner + "/" + userData.CodigoISO;
                    lst.Update(x => x.ArchivoPortada = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ArchivoPortada));
                }                    

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEBannerPedido> items = lst;

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
                        case "ArchivoPortada":
                            items = lst.OrderBy(x => x.ArchivoPortada);
                            break;
                        case "Archivo":
                            items = lst.OrderBy(x => x.Archivo);
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
                        case "ArchivoPortada":
                            items = lst.OrderByDescending(x => x.ArchivoPortada);
                            break;
                        case "ArchivoPDF":
                            items = lst.OrderByDescending(x => x.Archivo);
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
                               id = a.BannerPedidoID.ToString(),
                               cell = new string[]
                               {
                                   a.BannerPedidoID.ToString(),
                                   a.PaisID.ToString(),
                                   a.CampaniaIDInicio.ToString(),
                                   a.CampaniaIDFin.ToString(),
                                   a.ArchivoPortada,
                                   a.NombreCortoInicio,
                                   a.NombreCortoFin,
                                   string.Empty,
                                   a.Url,
                                   a.Archivo,
                                   a.Posicion.ToString(),
                                   a.TipoUrl,
                                   string.Empty,
                                   a.Url,
                                   a.Archivo
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "BannerPedido");
        }

        [HttpPost]
        public ActionResult Mantener(HttpPostedFileBase flArchivoPDF, AdministrarBannerPedidoModel model)
        {
            var result = model.BannerPedidoID == 0 ? Insertar(flArchivoPDF, model) : Actualizar(flArchivoPDF, model);
            if (Request.IsAjaxRequest())
            {
                return result;
            }
            return Content(JsonConvert.SerializeObject(result.Data), "text/html");
        }

        [HttpPost]
        public JsonResult Insertar(HttpPostedFileBase flArchivoPDF, AdministrarBannerPedidoModel model)
        {
            try
            {
                List<BEBannerPedido> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectBannerPedido(userData.PaisID, model.CampaniaIDInicio).ToList();
                }
                if (lst.Count > 0)
                {
                    var lista = from a in lst
                                where a.CampaniaIDInicio == model.CampaniaIDInicio && a.Posicion == model.PosicionBannerPedido
                                select a;

                    foreach (BEBannerPedido listado in lista)
                    {
                        if (listado.CampaniaIDInicio > 0)
                        {
                            return Json(new
                            {
                                success = false,
                                message = "No se puedo registrar el banner de pedido, porque ya existe un banner en la posición " + listado.Posicion,
                                extra = ""
                            });
                        }
                    }


                }

                BEBannerPedido entidad = Mapper.Map<AdministrarBannerPedidoModel, BEBannerPedido>(model);

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

                    var carpetaPais = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                    ConfigS3.SetFileS3(finalPath, carpetaPais, fileName);
                }

                entidad.Archivo = fileName;

                if (entidad.Url == null)
                    entidad.Url = string.Empty;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    string tempImage01 = model.ArchivoPortada ?? string.Empty;
                    string iso = Util.GetPaisISO(model.PaisID);

                    string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = iso + "_" + model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                    var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                    var carpetaPais = Globals.UrlBanner + "/" + iso;
                    ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                    entidad.ArchivoPortada = newfilename;
                    entidad.UsuarioCreacion = userData.CodigoUsuario;
                    sv.InsertBannerPedido(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito tu banner de pedido.",
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

        [HttpPost]
        public JsonResult Actualizar(HttpPostedFileBase flArchivoPDF, AdministrarBannerPedidoModel model)
        {
            try
            {
                List<BEBannerPedido> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectBannerPedido(userData.PaisID, model.CampaniaIDInicio).ToList();
                }
                if (lst.Count > 0)
                {
                    var lista1 = from a in lst
                                 where a.CampaniaIDInicio == model.CampaniaIDInicio && a.Posicion == model.PosicionBannerPedido && a.BannerPedidoID == model.BannerPedidoID
                                 select a;



                    if (!lista1.Any())
                    {
                        var lista = (from a in lst
                                     where a.CampaniaIDInicio == model.CampaniaIDInicio && a.Posicion == model.PosicionBannerPedido
                                     select a).ToList();

                        if (lista.Any())
                        {
                            foreach (BEBannerPedido listado in lista)
                            {
                                if (listado.CampaniaIDInicio > 0)
                                {
                                    return Json(new
                                    {
                                        success = false,
                                        message = "No se puedo actualizar el banner de pedido, porque ya existe un banner en la posición " + listado.Posicion,
                                        extra = ""
                                    });
                                }
                            }
                        }
                    }

                }

                BEBannerPedido entidad = Mapper.Map<AdministrarBannerPedidoModel, BEBannerPedido>(model);

                switch (model.grupoUrlPDF.ToLower())
                {
                    case "url":
                        entidad.Archivo = string.Empty;
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

                            var carpetaPais = Globals.UrlFileConsultoras + "/" + userData.CodigoISO;
                            ConfigS3.SetFileS3(finalPath, carpetaPais, fileName);

                            entidad.Archivo = fileName;
                        }
                        entidad.Url = string.Empty;
                        break;
                    case "ninguno":
                        entidad.Archivo = string.Empty;
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
                        var carpetaPais = Globals.UrlBanner + "/" + userData.CodigoISO;
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenLogoAnterior01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);

                        entidad.ArchivoPortada = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage01))
                        entidad.ArchivoPortada = string.Empty;

                    entidad.UsuarioModificacion = userData.CodigoUsuario;
                    sv.UpdateBannerPedido(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó con éxito tu banner de pedido.",
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

        public JsonResult Eliminar(int BannerPedidoID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteBannerPedido(userData.PaisID, BannerPedidoID);
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
