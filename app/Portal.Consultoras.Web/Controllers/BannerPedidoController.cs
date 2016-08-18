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
    public class BannerPedidoController : BaseController
    {

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "BannerPedido/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                IEnumerable<CampaniaModel> lstCampania = DropDowListCampanias(UserData().PaisID);
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

        private IEnumerable<PosicionBannerPedidoModel> DropDowListPosicionBannerPedido()
        {
            List<PosicionBannerPedidoModel> lst = new List<PosicionBannerPedidoModel>();

            //for (int i = 1; i < 5; i++)
            //{
            //    PosicionBannerPedidoModel oPosicionBannerPedidoModel = new PosicionBannerPedidoModel();
            //    oPosicionBannerPedidoModel.PosicionBannerPedidoId = i;
            //    oPosicionBannerPedidoModel.PosicionBannerPedido = "Banner " + i.ToString();
            //    lst.Add(oPosicionBannerPedidoModel);
            //}           
            PosicionBannerPedidoModel oPosicionBannerPedidoModel = new PosicionBannerPedidoModel();
            oPosicionBannerPedidoModel.PosicionBannerPedidoId = 1;
            oPosicionBannerPedidoModel.PosicionBannerPedido = "Banner 1";
            lst.Add(oPosicionBannerPedidoModel);

            PosicionBannerPedidoModel oPosicionBannerPedidoModel4 = new PosicionBannerPedidoModel();
            oPosicionBannerPedidoModel4.PosicionBannerPedidoId = 4;
            oPosicionBannerPedidoModel4.PosicionBannerPedido = "Banner 4";
            lst.Add(oPosicionBannerPedidoModel4);

            return lst;

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

        //operaciones//

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int vpaisID, int vCampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEBannerPedido> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectBannerPedido(vpaisID, vCampaniaID).ToList();
                }

                // 1664
                var carpetaPais = Globals.UrlBanner + "/" + UserData().CodigoISO;
                if (lst != null)
                    if (lst.Count > 0) lst.Update(x => x.ArchivoPortada = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoPortada, Globals.RutaImagenesIncentivos + "/" + UserData().CodigoISO));

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEBannerPedido> items = lst;

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
                        //case "PaisNombre":
                        //    items = lst.OrderByDescending(x => x.PaisNombre);
                        //    break;
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
            JsonResult result;
            result = model.BannerPedidoID == 0 ? Insertar(flArchivoPDF, model) : Actualizar(flArchivoPDF, model);
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
                    lst = sv.SelectBannerPedido(UserData().PaisID, model.CampaniaIDInicio).ToList();
                }
                if (lst != null && lst.Count > 0)
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

                Mapper.CreateMap<AdministrarBannerPedidoModel, BEBannerPedido>()
                   .ForMember(t => t.BannerPedidoID, f => f.MapFrom(c => c.BannerPedidoID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.CampaniaIDInicio, f => f.MapFrom(c => c.CampaniaIDInicio))
                   .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                   .ForMember(t => t.ArchivoPortada, f => f.MapFrom(c => c.ArchivoPortada))
                   .ForMember(t => t.Archivo, f => f.MapFrom(c => c.Archivo))
                   .ForMember(t => t.TipoUrl, f => f.MapFrom(c => c.grupoTipoUrl))
                   .ForMember(t => t.Posicion, f => f.MapFrom(c => c.PosicionBannerPedido))
                   .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

                BEBannerPedido entidad = Mapper.Map<AdministrarBannerPedidoModel, BEBannerPedido>(model);

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
                    string pathBanner = Globals.RutaTemporales; // 1664
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    finalPath = Path.Combine(pathBanner, fileName);
                    flArchivoPDF.SaveAs(finalPath);

                    // 1664
                    var carpetaPais = Globals.UrlFileConsultoras + "/" + UserData().CodigoISO;
                    ConfigS3.SetFileS3(finalPath, carpetaPais, fileName);
                }

                entidad.Archivo = fileName;

                if (entidad.Url == null)
                    entidad.Url = string.Empty;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    string tempImage01 = model.ArchivoPortada ?? string.Empty;
                    string ISO = Util.GetPaisISO(model.PaisID);
                    /*
                    if (!string.IsNullOrEmpty(tempImage01))
                        entidad.ArchivoPortada = FileManager.CopyImagesMatriz(Globals.RutaImagenesIncentivos + "\\" + ISO, tempImage01, Globals.RutaImagenesTempIncentivos, ISO, model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString(), "01");
                    else
                        entidad.ArchivoPortada = string.Empty;
                    */
                    // 1664
                    string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = ISO + "_" + model.CampaniaIDInicio.ToString() + "_" + model.CampaniaIDFin.ToString() + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                    var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                    var carpetaPais = Globals.UrlBanner + "/" + ISO;
                    ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                    entidad.ArchivoPortada = newfilename;
                    entidad.UsuarioCreacion = UserData().CodigoUsuario;
                    sv.InsertBannerPedido(entidad);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempIncentivos, tempImage01);
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
        public JsonResult Actualizar(HttpPostedFileBase flArchivoPDF, AdministrarBannerPedidoModel model)
        {
            try
            {
                List<BEBannerPedido> lst;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.SelectBannerPedido(UserData().PaisID, model.CampaniaIDInicio).ToList();
                }
                if (lst != null && lst.Count > 0)
                {
                    var lista1 = from a in lst
                                 where a.CampaniaIDInicio == model.CampaniaIDInicio && a.Posicion == model.PosicionBannerPedido && a.BannerPedidoID == model.BannerPedidoID
                                 select a;

                   

                    if (lista1.Count() == 0)
                    {
                        var lista = from a in lst
                                    where a.CampaniaIDInicio == model.CampaniaIDInicio && a.Posicion == model.PosicionBannerPedido
                                    select a;

                        if (lista.Count() > 0)
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

                Mapper.CreateMap<AdministrarBannerPedidoModel, BEBannerPedido>()
                   .ForMember(t => t.BannerPedidoID, f => f.MapFrom(c => c.BannerPedidoID))
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.CampaniaIDInicio, f => f.MapFrom(c => c.CampaniaIDInicio))
                   .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                   .ForMember(t => t.ArchivoPortada, f => f.MapFrom(c => c.ArchivoPortada))
                   .ForMember(t => t.ArchivoPortadaAnterior, f => f.MapFrom(c => c.ArchivoPortadaAnterior))
                   .ForMember(t => t.Archivo, f => f.MapFrom(c => c.Archivo))
                   .ForMember(t => t.TipoUrl, f => f.MapFrom(c => c.grupoTipoUrl))
                   .ForMember(t => t.Posicion, f => f.MapFrom(c => c.PosicionBannerPedido))
                   .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

                BEBannerPedido entidad = Mapper.Map<AdministrarBannerPedidoModel, BEBannerPedido>(model);

                string finalPath = string.Empty;
                string fileName = string.Empty;

                switch (model.grupoUrlPDF.ToLower())
                {
                    case "url":
                        // no es pdf
                        entidad.Archivo = string.Empty;
                        break;
                    case "pdf":
                        // si hay pdf se guarda
                        if (flArchivoPDF != null)
                        {
                            fileName = Path.GetFileName(flArchivoPDF.FileName);
                            // string pathBanner = Server.MapPath("~/Content/FileConsultoras");
                            string pathBanner = Globals.RutaTemporales; // 1664
                            if (!Directory.Exists(pathBanner))
                                Directory.CreateDirectory(pathBanner);
                            finalPath = Path.Combine(pathBanner, fileName);
                            flArchivoPDF.SaveAs(finalPath);

                            // 1664
                            var carpetaPais = Globals.UrlFileConsultoras + "/" + UserData().CodigoISO;
                            ConfigS3.SetFileS3(finalPath, carpetaPais, fileName);

                            entidad.Archivo = fileName;
                        }
                        // no es url
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
                        var carpetaPais = Globals.UrlBanner + "/" + UserData().CodigoISO;
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenLogoAnterior01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);

                        entidad.ArchivoPortada = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage01))
                        entidad.ArchivoPortada = string.Empty;

                    entidad.UsuarioModificacion = UserData().CodigoUsuario;
                    sv.UpdateBannerPedido(entidad);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempIncentivos, tempImage01);
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

        public JsonResult Eliminar(int BannerPedidoID)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.DeleteBannerPedido(UserData().PaisID, BannerPedidoID);
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
