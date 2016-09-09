using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceSAC;
using System.IO;
using System.Drawing;
using System.ServiceModel;
using System.Configuration;//R2133

namespace Portal.Consultoras.Web.Controllers
{
    public class BannerController : BaseController
    {
        #region Action

        public ActionResult Index(BannerModel model)
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Banner/Index"))
                    return RedirectToAction("Index", "Bienvenida");
                model.DropDownListCampania = CargarCampania();
                model.DropDownListCampania.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });
                model.DropDownListTipoContenido = new List<BETipoContenido>() { new BETipoContenido { TipoContenido = 0, TipoContenidoNombre = "URL" }, 
                                                                                new BETipoContenido { TipoContenido = 1, TipoContenidoNombre = "Mensaje" }};
                //new BETipoContenido { TipoContenido = 2, TipoContenidoNombre = "Curso" }};

                model.DropDownListTipoAccion = new List<BETipoAccion>() { new BETipoAccion { TipoAccion = 0, TipoAccionNombre = "URL Destino" }, 
                                                                          new BETipoAccion { TipoAccion = 1, TipoAccionNombre = "Agregar CUV al Pedido" },
                                                                          new BETipoAccion { TipoAccion = 2, TipoAccionNombre = "Curso" }};

                model.DropDownListPaginaNueva = new List<BEPaginaNueva>() { new BEPaginaNueva { PaginaNueva = 0, PaginaNuevaNombre = "NO" }, 
                                                                                new BEPaginaNueva { PaginaNueva = 1, PaginaNuevaNombre = "SI" }};

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
        }

        [HttpPost]
        public string InsertarActualizar(BannerModel model)
        {
            string message = string.Empty;
            string finalPath = string.Empty, httpPath = string.Empty;
            try
            {
                BEBanner obeBanner = new BEBanner();
                string FileName = string.Empty;

                if (model.Accion == "Insertar")
                {
                    // var img = Image.FromFile(Globals.RutaImagenesTempBanners + @"\" + model.ImagenActualizar);
                    // 1664
                    var img = Image.FromFile(Globals.RutaTemporales + @"\" + System.Net.WebUtility.UrlDecode(model.ImagenActualizar));
                    if (img.Width > model.Ancho || img.Height > model.Alto)
                        return message = string.Format("El archivo adjunto no tiene las dimensiones correctas. Verifique que sea un archivo con " +
                                                       "una dimensión máxima de hasta {0} x {1}", model.Ancho, model.Alto);
                    /*
                    FileName = FileManager.CopyImagesBanner(Globals.RutaImagenesBanners, Globals.RutaImagenesTempBanners, model.ImagenActualizar);
                    httpPath = Url.Content("~/Content/Banners") + "/" + FileName;
                    FileManager.DeleteImagesInFolder(Globals.RutaImagenesTempBanners);
                    */
                    img.Dispose();

                    string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = model.ImagenActualizar.Substring(0, System.Net.WebUtility.UrlDecode(model.ImagenActualizar).Length - 4) + "_" + time + ".png";
                    httpPath = Path.Combine(Globals.RutaTemporales, System.Net.WebUtility.UrlDecode(model.ImagenActualizar));
                    var carpetaPais = Globals.UrlBanner;
                    ConfigS3.SetFileS3(httpPath, carpetaPais, newfilename);
                    httpPath = newfilename;
                }
                else
                {
                    if (model.ImagenActualizar != null)
                    {
                        // var img = Image.FromFile(Globals.RutaImagenesTempBanners + @"\" + model.ImagenActualizar);
                        // 1664
                        var img = Image.FromFile(Globals.RutaTemporales + @"\" + System.Net.WebUtility.UrlDecode(model.ImagenActualizar));
                        if (img.Width > model.Ancho || img.Height > model.Alto)
                            return message = string.Format("El archivo adjunto no tiene las dimensiones correctas. Verifique que sea un archivo con " +
                                                           "una dimensión máxima de hasta {0} x {1}", model.Ancho, model.Alto);
                        /*
                        FileName = FileManager.CopyImagesBanner(Globals.RutaImagenesBanners, Globals.RutaImagenesTempBanners, model.ImagenActualizar);
                        httpPath = Url.Content("~/Content/Banners") + "/" + FileName;
                        */
                        img.Dispose();
                        // FileManager.DeleteImagesInFolder(Globals.RutaImagenesTempBanners);

                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = model.ImagenActualizar.Substring(0, System.Net.WebUtility.UrlDecode(model.ImagenActualizar).Length - 4) + "_" + time + ".png";
                        httpPath = Path.Combine(Globals.RutaTemporales, System.Net.WebUtility.UrlDecode(model.ImagenActualizar));
                        var carpetaPais = Globals.UrlBanner;
                        ConfigS3.SetFileS3(httpPath, carpetaPais, newfilename);
                        httpPath = newfilename;
                    }
                }

                obeBanner.CampaniaID = model.CampaniaID;
                obeBanner.BannerID = model.BannerID;
                obeBanner.GrupoBannerID = model.GrupoBannerID;
                obeBanner.Orden = model.Orden;
                obeBanner.Titulo = model.Titulo;
                obeBanner.Archivo = httpPath.Length > 0 ? httpPath : System.Net.WebUtility.UrlDecode(model.Archivo);
                obeBanner.URL = model.URL == null ? string.Empty : model.URL;
                obeBanner.FlagGrupoConsultora = model.FlagGrupoConsultora;
                obeBanner.UdpSoloBanner = true; // solo actualizar el banner y no los paises
                obeBanner.TipoContenido = model.TipoContenido;
                obeBanner.PaginaNueva = model.PaginaNueva;
                obeBanner.TituloComentario = model.TituloComentario;
                obeBanner.TextoComentario = model.TextoComentario;
                obeBanner.TipoAccion = model.TipoAccion;
                obeBanner.CuvPedido = model.CUV;
                obeBanner.CantCuvPedido = model.cantidadPedido;

                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.SaveBanner(obeBanner);
                }

                message = "Se guardó correctamente.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Ocurrió un error inesperado al Registrar el Banner, Por favor intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Ocurrió un error inesperado al Registrar el Banner, Por favor intente nuevamente.";
            }

            return message;
        }

        [HttpPost]
        public string InsertarGrupoBanner(HttpPostedFileBase flConsultoras, BannerModel model)
        {
            string message = string.Empty;
            try
            {
                string finalPath = string.Empty;
                bool IsCorrect = true;
                List<BEGrupoConsultora> lstGrupoConsultora = new List<BEGrupoConsultora>(); ;

                if (flConsultoras != null)
                {
                    string fileName = Path.GetFileName(flConsultoras.FileName);
                    string pathBanner = Server.MapPath("~/Content/FileConsultoras");
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    finalPath = Path.Combine(pathBanner, fileName);
                    flConsultoras.SaveAs(finalPath);

                    //Leer excel file
                    BEGrupoConsultora obeGrupoConsultora = new BEGrupoConsultora();
                    lstGrupoConsultora = Util.ReadXmlFile(finalPath, obeGrupoConsultora, false, ref IsCorrect);
                }

                //Obtener los paises
                List<BEPais> lstPais = new List<BEPais>();
                using (ZonificacionServiceClient svc = new ZonificacionServiceClient())
                {
                    lstPais = svc.SelectPaises().OrderBy(x => x.PaisID).ToList();
                }
                //Setear el IdPais para los que coincidan
                foreach (BEPais itemPais in lstPais)
                {
                    lstGrupoConsultora.Where(x => x.PaisCodigo == itemPais.CodigoISO).Each(y => y.PaisID = itemPais.PaisID);
                }
                //Los que no coinciden los eliminamos
                lstGrupoConsultora.RemoveAll(x => x.PaisID == 0);

                BEGrupoBanner obeGrupo = new BEGrupoBanner();
                obeGrupo.CampaniaID = model.CampaniaID;
                obeGrupo.GrupoBannerID = model.GrupoBannerID;
                obeGrupo.TiempoRotacion = model.TiempoRotacion;
                obeGrupo.Consultoras = lstGrupoConsultora != null ? lstGrupoConsultora.ToArray() : null;
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.SaveGrupoBanner(obeGrupo);
                }

                message = "Se registró correctamente.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
            }

            return message;
        }

        [HttpPost]
        public JsonResult InsertarPaisPorBanner(List<BEBanner> lstBanner)
        {
            try
            {

                // 1664
                lstBanner.ForEach(item =>
                {
                    item.Archivo = System.Net.WebUtility.UrlDecode(item.Archivo);
                    item.UdpSoloBanner = false; // Actualizar los paises de cada banner
                    item.URL = item.URL == null ? string.Empty : item.URL;
                    item.Archivo = item.Archivo == null ? string.Empty : item.Archivo;
                });

                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.SaveListBanner(lstBanner.ToArray());
                }

                return Json(new
                {
                    success = true,
                    message = "Se registró correctamente."
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente."
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente."
                });
            }
        }

        [HttpPost]
        public JsonResult EliminarBanner(BannerModel model)
        {
            try
            {
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.DeleteBanner(model.CampaniaID, model.BannerID);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó correctamente."
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente."
                });
            }
        }

        public ActionResult ConsultarGruposPorCampania(string sidx, string sord, int page, int rows, int CampaniaId)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<BEGrupoBanner> lst;
                    using (ContenidoServiceClient svc = new ContenidoServiceClient())
                    {
                        lst = svc.SelectGrupoBanner(CampaniaId).ToList();
                    }

                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
                    BEPager pag = new BEPager();
                    IEnumerable<BEGrupoBanner> items = lst;

                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    pag = Util.PaginadorGenerico(grid, lst);

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.GrupoBannerID,
                                   cell = new string[] 
                               {
                                   a.GrupoBannerID.ToString(),
                                   a.TiempoRotacion.ToString(),
                                   a.Nombre.ToString(),
                                   a.Nombre.ToString(),
                                   a.Dimension.ToString(),
                                   a.Ancho.ToString(),
                                   a.Alto.ToString()
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

        public ActionResult ConsultaBannerPorGrupoCampania(string sidx, string sord, int page, int rows, int CampaniaId, int GrupoBannerId)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<BEBanner> lst;
                    using (ContenidoServiceClient svc = new ContenidoServiceClient())
                    {
                        lst = svc.SelectBanner(CampaniaId).ToList().FindAll(x => x.GrupoBannerID == GrupoBannerId);
                    }

                    List<BEPais> lstPais;
                    using (ZonificacionServiceClient svc = new ZonificacionServiceClient())
                    {
                        lstPais = svc.SelectPaises().OrderBy(x => x.PaisID).ToList();
                    }


                    // 1664
                    var carpetaPais = Globals.UrlBanner;
                    if (lst != null)
                        if (lst.Count > 0) lst.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(carpetaPais, x.Archivo, Globals.RutaImagenesBanners));

                    List<string> lstCell = new List<string>();

                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
                    BEPager pag = new BEPager();
                    IEnumerable<BEBanner> items = lst;

                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    pag = Util.PaginadorGenerico(grid, lst);

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.BannerID,
                                   cell = CrearCellArray(a, lstPais)
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

        // Estructura para crear el ColModel dinamicamente de la Grilla
        struct Model
        {
            public string name;
            public string index;
            public int width;
            public bool key;
            public bool sortable;
            public bool hidden;
            public object formatter;
            public string align;
        };

        [HttpPost]
        public JsonResult ObtenerCabeceraYFilaConfiguracionSubGrilla(string GrupoBannerId)
        {
            List<BEPais> lstPais;

            //Columnas por defecto
            List<string> colNames = new List<string>();
            colNames.Add("BannerID");
            colNames.Add("GrupoBannerID");
            colNames.Add("Titulo");
            colNames.Add("Archivo");
            colNames.Add("ArchivoRutaCompleto");
            colNames.Add("Url");
            colNames.Add("TipoContenido");
            colNames.Add("PaginaNueva");
            colNames.Add("TituloComentario");
            colNames.Add("TextoComentario");
            colNames.Add("TipoAccion");
            colNames.Add("CuvPedido");
            colNames.Add("CantCuvPedido");
            //Model por defecto                       
            List<Model> colModel = new List<Model>();
            colModel.Add(new Model { name = "BannerID", index = "BannerID", width = 150, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "GrupoBannerID", index = "GrupoBannerID", width = 150, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "Titulo", index = "Titulo", width = 150, key = true, sortable = false });
            // colModel.Add(new Model { name = "Archivo", index = "Archivo", width = 150, key = false, sortable = false });
            // 1664
            colModel.Add(new Model { name = "Archivo", index = "Archivo", width = 150, key = false, sortable = false, formatter = "formatearArchivo" });
            colModel.Add(new Model { name = "ArchivoRutaCompleto", index = "ArchivoRutaCompleto", width = 150, key = true, sortable = true, hidden = true });
            colModel.Add(new Model { name = "Url", index = "Url", width = 150, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "TipoContenido", index = "TipoContenido", width = 150, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "PaginaNueva", index = "PaginaNueva", width = 150, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "TituloComentario", index = "TituloComentario", width = 0, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "TextoComentario", index = "TextoComentario", width = 0, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "TipoAccion", index = "TipoAccion", width = 0, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "CuvPedido", index = "CuvPedido", width = 0, key = true, sortable = false, hidden = true });
            colModel.Add(new Model { name = "CantCuvPedido", index = "CantCuvPedido", width = 0, key = true, sortable = false, hidden = true });

            //Configurar Columnas y model
            using (ZonificacionServiceClient svc = new ZonificacionServiceClient())
            {
                lstPais = svc.SelectPaises().OrderBy(x => x.PaisID).ToList();
            }
            foreach (BEPais item in lstPais)
            {
                colNames.Add(item.CodigoISO);
                colModel.Add(new Model { name = item.CodigoISO, index = item.CodigoISO, width = 20, key = false, sortable = false, align = "center", formatter = "CustomCheckBox" });
            }

            //Ultima Columna y Model por defecto
            colNames.Add("Grp.Cons");
            colNames.Add("Nva.Cons");
            colNames.Add("Opciones");
            colModel.Add(new Model { name = "FlagGrupoConsultora", index = "FlagGrupoConsultora", width = 70, key = false, sortable = false, align = "center", formatter = "CustomCheckFlag" });
            colModel.Add(new Model { name = "FlagConsultoraNueva", index = "FlagConsultoraNueva", width = 70, key = false, sortable = false, align = "center", formatter = "CustomCheckFlagNva" });
            colModel.Add(new Model { name = "Opciones", index = "Opciones", width = 60, key = false, sortable = false, align = "center", formatter = "ShowBannerOptions" });

            return Json(new
            {
                _colNames = colNames.ToArray(),
                _colModel = colModel.ToArray()
            });
        }

        //RQ_BS - R2133
        [HttpPost]
        public JsonResult ObtenerBannerPaginaPrincipal()
        {
            /*
             * 1: SeccionPrincipal
             * 2: Seccion Intermedia 1
             * 3: Seccion Intermedia 2
             * 4: Seccion Intermedia 3
             * 5: Seccion Intermedia 4
             * 6: Seccion Baja 1
             * 7: Seccion Baja 2
             * 8: Seccion Baja 3
             * 9: Seccion Baja 4
             */

            bool issuccess = true;
            List<BEBannerInfo> lstBannerInfo = null;
            List<BEBannerInfo> lstBannerInfoTemp = null;
            List<BEBannerInfo> lstFinalInfo = new List<BEBannerInfo>();
            try
            {

                /*RE2544 - CS*/
                int SegmentoID;
                if (UserData().CodigoISO == "VE")
                {
                    SegmentoID = UserData().SegmentoID;
                }
                else
                {
                    SegmentoID = (UserData().SegmentoInternoID == null) ? UserData().SegmentoID : (int)UserData().SegmentoInternoID;
                }
                int PaisId = UserData().PaisID, CampaniaId = UserData().CampaniaID, ZonaId = UserData().ZonaID,
                    /*Se comenta la linea por problemas con el tipo de consultora de EsJoven que no muestra ningun Banner. Se cambia la logica a pedido de Belcorp.*/
                    //SegmentoBanner = UserData().EsJoven == 1 ? 99 : SegmentoID;/*RE2544 - CS*/ //R2161 
                SegmentoBanner = SegmentoID; //Correctivo 2544 (CSR) - Error Banners Inferiores.

                string CodigoConsultora = UserData().CodigoConsultora;
                bool ConsultoraNueva = UserData().ConsultoraNueva == 2 ? true : false;
                List<BETablaLogicaDatos> list_segmentos = new List<BETablaLogicaDatos>();

                using (ContenidoServiceClient svc1 = new ContenidoServiceClient())
                {
                    lstBannerInfoTemp = svc1.SelectBannerByConsultoraBienvenida(PaisId, CampaniaId, CodigoConsultora, ConsultoraNueva).ToList();
                }

                //ListadoTodos
                List<BEBannerInfo> lstBannerInfoPorZona = new List<BEBannerInfo>();
                lstBannerInfoPorZona = lstBannerInfoTemp.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(ZonaId.ToString())).ToList();
                lstBannerInfo = new List<BEBannerInfo>();
                lstBannerInfo = lstBannerInfoPorZona.Where(p => p.Segmento == -1 || p.Segmento == SegmentoBanner).ToList();

                //actualiza los ID de los banners para que se puedan mostrar en la pagina de bienvenida
                foreach (BEBannerInfo item in lstBannerInfo)
                {
                    //if (item.GrupoBannerID == 2 || item.GrupoBannerID == 3 || item.GrupoBannerID == 4 || item.GrupoBannerID == 5 || item.GrupoBannerID == 11)
                    //    item.GrupoBannerID = 2;
                    //if (item.GrupoBannerID == 12 || item.GrupoBannerID == 13)
                    //    item.GrupoBannerID = 3;
                    //if (item.GrupoBannerID == 14 || item.GrupoBannerID == 15 || item.GrupoBannerID == 16 || item.GrupoBannerID == 17 || item.GrupoBannerID == 18 || item.GrupoBannerID == 19 || item.GrupoBannerID == 20 || item.GrupoBannerID == 21)
                    //    item.GrupoBannerID = 4;
                    //if (item.GrupoBannerID == 22 || item.GrupoBannerID == 23 || item.GrupoBannerID == 26)
                    //    item.GrupoBannerID = 5;
                    if (item.GrupoBannerID == 151 || item.GrupoBannerID == 152 || item.GrupoBannerID == 153)
                        item.GrupoBannerID = -5;
                }

                //----------------------------------
                List<BEBannerInfo> ban_temp_inter = new List<BEBannerInfo>();
                ban_temp_inter = lstBannerInfo.Where(p => p.GrupoBannerID > -6 && p.GrupoBannerID < -4).ToList();

                if (ban_temp_inter.Count > 0)
                {
                    lstBannerInfo.RemoveAll(p => p.GrupoBannerID > -6 && p.GrupoBannerID < -4);

                    List<BEBannerInfo> inter_temp_1 = new List<BEBannerInfo>();
                    //List<BEBannerInfo> inter_temp_2 = new List<BEBannerInfo>();
                    //List<BEBannerInfo> inter_temp_3 = new List<BEBannerInfo>();
                    //List<BEBannerInfo> inter_temp_4 = new List<BEBannerInfo>();

                    //R2161 - Inicio
                    inter_temp_1 = ban_temp_inter.Where(p => p.GrupoBannerID == -5).OrderByDescending(p => p.ConfiguracionZona).OrderByDescending(p => p.Segmento).ToList();
                    //inter_temp_1 = ban_temp_inter.Where(p => p.GrupoBannerID == -5).OrderByDescending(p => p.ConfiguracionZona).OrderByDescending(p => p.Segmento).Take(1).ToList();
                    //inter_temp_2 = ban_temp_inter.Where(p => p.GrupoBannerID == 3).OrderByDescending(p => p.ConfiguracionZona).OrderByDescending(p => p.Segmento).Take(1).ToList();
                    //inter_temp_3 = ban_temp_inter.Where(p => p.GrupoBannerID == 4).OrderByDescending(p => p.ConfiguracionZona).OrderByDescending(p => p.Segmento).Take(1).ToList();
                    //inter_temp_4 = ban_temp_inter.Where(p => p.GrupoBannerID == 5).OrderByDescending(p => p.ConfiguracionZona).OrderByDescending(p => p.Segmento).Take(1).ToList();
                    //R2161 - Fin

                    if (inter_temp_1.Count > 0)
                    {
                        lstBannerInfo.AddRange(inter_temp_1);
                    }

                    //if (inter_temp_2.Count > 0)
                    //{
                    //    lstBannerInfo.AddRange(inter_temp_2);
                    //}

                    //if (inter_temp_3.Count > 0)
                    //{
                    //    lstBannerInfo.AddRange(inter_temp_3);
                    //}

                    //if (inter_temp_4.Count > 0)
                    //{
                    //    lstBannerInfo.AddRange(inter_temp_4);
                    //}
                }

                //----------------------------------

                #region Mejoras
                //Ordenamiento
                if (lstBannerInfo.Count > 0)
                {
                    // Ordena y agrega los banner Principales
                    lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID == 150).OrderBy(x => x.Orden));
                    // Agrega los banner Intermedios
                    //lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID != 1 && x.GrupoBannerID != 6 &&
                    //     x.GrupoBannerID != 7 && x.GrupoBannerID != 8 && x.GrupoBannerID != 9 && x.GrupoBannerID != 24 && x.GrupoBannerID != 25));
                    // Ordena y agrega los banner Bajos
                    lstBannerInfo = lstBannerInfo.Where(x => x.GrupoBannerID == -5).OrderBy(x => x.Orden).ToList();
                    
                    //lstBannerInfo.Where((x, i) => i == 0).Update(x => x.GrupoBannerID = 6);
                    //lstBannerInfo.Where((x, i) => i == 1).Update(x => x.GrupoBannerID = 8);
                    //lstBannerInfo.Where((x, i) => i == 2).Update(x => x.GrupoBannerID = 7);
                    //lstBannerInfo.Where((x, i) => i == 3).Update(x => x.GrupoBannerID = 9);

                    lstFinalInfo.AddRange(lstBannerInfo);
                }
                #endregion

                issuccess = true;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
            }

            // 1664
            var carpetaPais = Globals.UrlBanner;
            if (lstFinalInfo != null)
                if (lstFinalInfo.Count > 0) lstFinalInfo.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(carpetaPais, x.Archivo, Globals.RutaImagenesBanners));

            return Json(new
            {
                success = issuccess,
                data = lstFinalInfo
            });
        }

        //R2133
        public JsonResult ObtenerBannerPaginaPrincipalBK()
        {
            /*
             * 1: SeccionPrincipal
             * 2: Seccion Intermedia 1
             * 3: Seccion Intermedia 2
             * 4: Seccion Intermedia 3
             * 5: Seccion Intermedia 4
             * 6: Seccion Baja 1
             * 7: Seccion Baja 2
             * 8: Seccion Baja 3
             * 9: Seccion Baja 4
             */
            bool issuccess = true;
            List<BEBannerInfo> lstBannerInfo = null;
            List<BEBannerInfo> lstFinalInfo = new List<BEBannerInfo>();
            try
            {
                int PaisId = UserData().PaisID, CampaniaId = UserData().CampaniaID;
                string CodigoConsultora = UserData().CodigoConsultora;
                bool ConsultoraNueva = UserData().ConsultoraNueva == 2 ? true : false;
                //BEUsuario beusuario = new BEUsuario();
                List<BETablaLogicaDatos> list_segmentos = new List<BETablaLogicaDatos>();
                int segmento_nueva, segmento_top;

                using (ContenidoServiceClient svc1 = new ContenidoServiceClient())
                {
                    lstBannerInfo = svc1.SelectBannerByConsultoraBienvenida(PaisId, CampaniaId, CodigoConsultora, ConsultoraNueva).ToList();
                }

                //using (UsuarioServiceClient sv = new UsuarioServiceClient())
                //{
                //    beusuario = sv.Select(UserData().PaisID, UserData().CodigoUsuario);
                //}

                using (SACServiceClient sv = new SACServiceClient())
                {
                    list_segmentos = sv.GetTablaLogicaDatos(UserData().PaisID, 20).ToList();
                    segmento_nueva = Convert.ToInt32((from item in list_segmentos where item.TablaLogicaDatosID == 2001 select item.Codigo).First());
                    segmento_top = Convert.ToInt32((from item in list_segmentos where item.TablaLogicaDatosID == 2002 select item.Codigo).First());
                }


                //Estableciendo las reglas para el Banner 1
                #region Reglas para Banner 1
                if (UserData().PasePedidoWeb == 0)
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 3 && item.GrupoBannerID != 4 && item.GrupoBannerID != 5 && item.GrupoBannerID != 11
                                     select item).ToList();
                }
                else if (UserData().TipoOferta2 == 0)
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 2 && item.GrupoBannerID != 4 && item.GrupoBannerID != 5 && item.GrupoBannerID != 11
                                     select item).ToList();
                }
                else if (UserData().EMail == "")
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 2 && item.GrupoBannerID != 3 && item.GrupoBannerID != 5 && item.GrupoBannerID != 11
                                     select item).ToList();
                }
                // valida que envia catalogo
                else if (!ValidarEnviarEmail())
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 2 && item.GrupoBannerID != 3 && item.GrupoBannerID != 4 && item.GrupoBannerID != 11
                                     select item).ToList();
                }
                else
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 2 && item.GrupoBannerID != 3 && item.GrupoBannerID != 4 && item.GrupoBannerID != 5
                                     select item).ToList();
                }
                #endregion
                #region Reglas para Banner 2
                if (UserData().SegmentoID == segmento_nueva)
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 13
                                     select item).ToList();
                }
                else
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 12
                                     select item).ToList();
                }
                #endregion
                #region Reglas para Banner 3
                if (UserData().SegmentoID != segmento_nueva)
                {
                    if (UserData().IndicadorDupla == 0)
                    {
                        lstBannerInfo = (from item in lstBannerInfo
                                         where item.GrupoBannerID != 15 && item.GrupoBannerID != 16 && item.GrupoBannerID != 17 && item.GrupoBannerID != 18 && item.GrupoBannerID != 19 && item.GrupoBannerID != 20 && item.GrupoBannerID != 21
                                         select item).ToList();
                    }
                    else if (UserData().CompraKitDupla == 0)
                    {
                        lstBannerInfo = (from item in lstBannerInfo
                                         where item.GrupoBannerID != 14 && item.GrupoBannerID != 15 && item.GrupoBannerID != 17 && item.GrupoBannerID != 18 && item.GrupoBannerID != 19 && item.GrupoBannerID != 20 && item.GrupoBannerID != 21
                                         select item).ToList();
                    }
                    else if (UserData().CompraOfertaDupla == 0)
                    {
                        lstBannerInfo = (from item in lstBannerInfo
                                         where item.GrupoBannerID != 14 && item.GrupoBannerID != 15 && item.GrupoBannerID != 16 && item.GrupoBannerID != 18 && item.GrupoBannerID != 19 && item.GrupoBannerID != 20 && item.GrupoBannerID != 21
                                         select item).ToList();
                    }
                    else
                    {
                        lstBannerInfo = (from item in lstBannerInfo
                                         where item.GrupoBannerID != 14 && item.GrupoBannerID != 15 && item.GrupoBannerID != 16 && item.GrupoBannerID != 17 && item.GrupoBannerID != 19 && item.GrupoBannerID != 20 && item.GrupoBannerID != 21
                                         select item).ToList();
                    }
                }
                else
                {
                    if (UserData().CompraOfertaEspecial == 0)
                    {
                        lstBannerInfo = (from item in lstBannerInfo
                                         where item.GrupoBannerID != 14 && item.GrupoBannerID != 15 && item.GrupoBannerID != 16 && item.GrupoBannerID != 17 && item.GrupoBannerID != 18 && item.GrupoBannerID != 20 && item.GrupoBannerID != 21
                                         select item).ToList();
                    }
                    else if (UserData().IndicadorMeta == 0)
                    {
                        lstBannerInfo = (from item in lstBannerInfo
                                         where item.GrupoBannerID != 14 && item.GrupoBannerID != 15 && item.GrupoBannerID != 16 && item.GrupoBannerID != 17 && item.GrupoBannerID != 18 && item.GrupoBannerID != 19 && item.GrupoBannerID != 21
                                         select item).ToList();
                    }
                    else
                    {
                        lstBannerInfo = (from item in lstBannerInfo
                                         where item.GrupoBannerID != 14 && item.GrupoBannerID != 15 && item.GrupoBannerID != 16 && item.GrupoBannerID != 17 && item.GrupoBannerID != 18 && item.GrupoBannerID != 19 && item.GrupoBannerID != 20
                                         select item).ToList();
                    }

                }
                #endregion
                #region Reglas para Banner 4
                if (UserData().EsJoven == 1 && UserData().SegmentoID != segmento_top)//1530
                {
                    //lstBannerInfo = (from item in lstBannerInfo
                    //                 where item.GrupoBannerID != 23
                    //                 select item).ToList();
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 22 && item.GrupoBannerID != 23
                                     select item).ToList();
                }
                if (UserData().EsJoven == 1 && UserData().SegmentoID == segmento_top)//1530
                {
                    //lstBannerInfo = (from item in lstBannerInfo
                    //                 where item.GrupoBannerID != 22
                    //                 select item).ToList();
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 22 && item.GrupoBannerID != 23
                                     select item).ToList();
                }

                if (UserData().EsJoven != 1 && UserData().SegmentoID != segmento_top)//1530
                {

                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 23 && item.GrupoBannerID != 26
                                     select item).ToList();
                }

                if (UserData().EsJoven != 1 && UserData().SegmentoID == segmento_top)//1530
                {

                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID != 22 && item.GrupoBannerID != 26
                                     select item).ToList();
                }
                #endregion

                //actualiza los ID de los banners para que se puedan mostrar en la pagina de bienvenida
                foreach (BEBannerInfo item in lstBannerInfo)
                {
                    if (item.GrupoBannerID == 2 || item.GrupoBannerID == 3 || item.GrupoBannerID == 4 || item.GrupoBannerID == 5 || item.GrupoBannerID == 11)
                        item.GrupoBannerID = 2;
                    if (item.GrupoBannerID == 12 || item.GrupoBannerID == 13)
                        item.GrupoBannerID = 3;
                    if (item.GrupoBannerID == 14 || item.GrupoBannerID == 15 || item.GrupoBannerID == 16 || item.GrupoBannerID == 17 || item.GrupoBannerID == 18 || item.GrupoBannerID == 19 || item.GrupoBannerID == 20 || item.GrupoBannerID == 21)
                        item.GrupoBannerID = 4;
                    if (item.GrupoBannerID == 22 || item.GrupoBannerID == 23 || item.GrupoBannerID == 26)
                        item.GrupoBannerID = 5;
                }
                //Incluye los parametros a todos los banners
                //string nroDocumento;
                //using (UsuarioServiceClient sv = new UsuarioServiceClient())
                //{
                //    nroDocumento = sv.GetNroDocumentoConsultora(UserData().PaisID, UserData().CodigoConsultora);
                //}

                //string[] parametros = new string[] { UserData().CodigoISO, UserData().CodigoConsultora, "", nroDocumento, UserData().NombreConsultora, "", UserData().EMail, UserData().Celular, UserData().Telefono, UserData().CodigoZona};

                //foreach (BEBannerInfo item in lstBannerInfo)
                //{
                //    if (item.GrupoBannerID == 2 || item.GrupoBannerID == 3 || item.GrupoBannerID == 4 || item.GrupoBannerID == 5)
                //    {
                //        if (item.TipoContenido == 0)
                //        {
                //            if (item.URL != "" && item.URL != null)
                //            {
                //                item.URL = item.URL + DevolverCadenaParametros();
                //            }
                //        }
                //    }
                //    else
                //    {
                //        if (item.URL != "" && item.URL != null)
                //        {
                //            item.URL = item.URL + DevolverCadenaParametros();
                //        }
                //    }
                //}

                #region Mejoras
                //Ordenamiento
                if (lstBannerInfo.Count > 0)
                {
                    // Ordena y agrega los banner Principales
                    lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID == 1).OrderBy(x => x.Orden));
                    // Agrega los banner Intermedios
                    lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID != 1 && x.GrupoBannerID != 6 &&
                         x.GrupoBannerID != 7 && x.GrupoBannerID != 8 && x.GrupoBannerID != 9 && x.GrupoBannerID != 24 && x.GrupoBannerID != 25));
                    // Ordena y agrega los banner Bajos
                    lstBannerInfo = lstBannerInfo.Where(x => x.GrupoBannerID == 6 || x.GrupoBannerID == 7 ||
                                            x.GrupoBannerID == 8 || x.GrupoBannerID == 9 || x.GrupoBannerID == 24 || x.GrupoBannerID == 25).OrderBy(x => x.Orden).ToList();
                    lstBannerInfo.Where((x, i) => i == 0).Update(x => x.GrupoBannerID = 6);
                    lstBannerInfo.Where((x, i) => i == 1).Update(x => x.GrupoBannerID = 8);
                    lstBannerInfo.Where((x, i) => i == 2).Update(x => x.GrupoBannerID = 7);
                    lstBannerInfo.Where((x, i) => i == 3).Update(x => x.GrupoBannerID = 9);

                    lstFinalInfo.AddRange(lstBannerInfo);
                }
                #endregion

                issuccess = true;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
            }

            // 1664
            var carpetaPais = Globals.UrlBanner;
            if (lstFinalInfo != null)
                if (lstFinalInfo.Count > 0) lstFinalInfo.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(carpetaPais, x.Archivo, Globals.RutaImagenesBanners));

            return Json(new
            {
                success = issuccess,
                data = lstFinalInfo
            });
        }

        [HttpPost]
        public ActionResult ImageMatrizUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                // 1664
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                    return Json(new { success = true, name = qqfile }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    // string ffFileName = Request.Headers["X-File-Name"];
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    return Json(new { success = true, name = ffFileName }, "text/html");
                }

                //if (String.IsNullOrEmpty(Request["qqfile"]))
                //{
                //    HttpPostedFileBase postedFile = Request.Files[0];
                //    var fileName = Path.GetFileName(postedFile.FileName);
                //    var path = Path.Combine(Globals.RutaImagenesTempBanners, fileName);
                //    if (!System.IO.File.Exists(Globals.RutaImagenesTempBanners))
                //        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempBanners);
                //    postedFile.SaveAs(path);
                //    path = Url.Content(Path.Combine(Globals.RutaImagenesTempBanners, fileName));
                //    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                //}
                //else
                //{
                //    Stream inputStream = Request.InputStream;
                //    byte[] fileBytes = ReadFully(inputStream);
                //    // string ffFileName = Request.Headers["X-File-Name"];
                //    string ffFileName = qqfile;
                //    var path = Path.Combine(Globals.RutaImagenesTempBanners, ffFileName);
                //    if (!System.IO.File.Exists(Globals.RutaImagenesTempBanners))
                //        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempBanners);
                //    System.IO.File.WriteAllBytes(path, fileBytes);
                //    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                //}
            }
            catch (Exception)
            {
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }
        #endregion

        #region Metodos

        public List<BECampania> CargarCampania()
        {
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                BECampania[] becampania = servicezona.SelectCampanias(11);
                return becampania.ToList();
            }
        }

        public string[] CrearCellArray(BEBanner obe, List<BEPais> lstPais)
        {
            List<string> lstCell = new List<string>();
            lstCell.Add(obe.BannerID.ToString());
            lstCell.Add(obe.GrupoBannerID.ToString());
            lstCell.Add(obe.Titulo.ToString());
            lstCell.Add(obe.Archivo.ToString().Substring(obe.Archivo.LastIndexOf("/") + 1));
            lstCell.Add(obe.Archivo.ToString());
            lstCell.Add(obe.URL.ToString());
            lstCell.Add(obe.TipoContenido.ToString());
            lstCell.Add(obe.PaginaNueva.ToString());
            lstCell.Add(obe.TituloComentario ?? string.Empty);
            lstCell.Add(obe.TextoComentario ?? string.Empty);
            lstCell.Add(obe.TipoAccion.ToString());
            lstCell.Add(obe.CuvPedido ?? string.Empty);
            lstCell.Add(obe.CantCuvPedido.ToString());

            foreach (BEPais obePais in lstPais)
            {
                if (obe.Paises != null)
                {
                    List<int> lstIdPais = obe.Paises.ToList();
                    if (obe.Paises != null && lstIdPais.Exists(x => x == obePais.PaisID))
                    {
                        lstCell.Add("1|" + obePais.PaisID.ToString()); //Si existe el Pais en el Array => 1: Checked
                    }
                    else
                    {
                        lstCell.Add("0|" + obePais.PaisID.ToString()); //Si no existe el Pais en el Array => 0: Unchecked
                    }
                }
                else
                {
                    lstCell.Add("0|" + obePais.PaisID.ToString()); //Si no existe el Pais en el Array => 0: Unchecked
                }
            }

            if (obe.GrupoBannerID != 2 && obe.GrupoBannerID != 3 && obe.GrupoBannerID != 4 && obe.GrupoBannerID != 5 && obe.GrupoBannerID != 11 && obe.GrupoBannerID != 12 && obe.GrupoBannerID != 13 && obe.GrupoBannerID != 14 && obe.GrupoBannerID != 151 && obe.GrupoBannerID != 16 && obe.GrupoBannerID != 17 && obe.GrupoBannerID != 18 && obe.GrupoBannerID != 19 && obe.GrupoBannerID != 20 && obe.GrupoBannerID != 21 && obe.GrupoBannerID != 22)
            {
                //Valor de la ultima columna
                lstCell.Add(obe.FlagGrupoConsultora.ToString().ToLower());
                lstCell.Add(obe.FlagConsultoraNueva.ToString().ToLower());
            }

            return lstCell.ToArray();
        }

        public static byte[] ReadFully(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        public Boolean ValidarEnviarEmail()
        {
            List<BETablaLogicaDatos> list_Cantidad = new List<BETablaLogicaDatos>();
            int cantidad_validacion;
            int cantidad_envios;
            using (SACServiceClient sv = new SACServiceClient())
            {
                list_Cantidad = sv.GetTablaLogicaDatos(UserData().PaisID, 21).ToList();
                cantidad_validacion = Convert.ToInt32((from item in list_Cantidad where item.TablaLogicaDatosID == 2101 select item.Codigo).First());
            }

            if (cantidad_validacion == 0)
                return true;
            else
            {
                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    cantidad_envios = sv.ValidarEnvioCatalogo(UserData().PaisID, UserData().CodigoConsultora, UserData().CampaniaID, cantidad_validacion);
                }
                if (cantidad_envios >= cantidad_validacion)
                    return true;
                else
                    return false;
            }
        }

        public string DevolverCadenaParametros()
        {
            string Cadena = "?";
            List<ServiceContenido.BEParametro> list = new List<ServiceContenido.BEParametro>();

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                list = sv.GetParametrosBanners().ToList();
            }

            foreach (ServiceContenido.BEParametro item in list)
            {
                Cadena = Cadena + item.Abreviatura + "=" + DevolverValorParametro(item.ParametroId) + "&";
            }

            Cadena = Cadena.Substring(0, Cadena.Length - 1);

            return Cadena;
        }

        private string DevolverValorParametro(int ParametroId)
        {
            switch (ParametroId)
            {
                case 1:
                    return UserData().NombrePais.Trim();
                case 2:
                    return UserData().CampaniaID.ToString().Trim();
                case 3:
                    return UserData().CodigoConsultora.Trim();
                case 4:
                    return UserData().CodigoZona.Trim();
                case 5:
                    return UserData().NombreConsultora.Trim();
                case 6:
                    return UserData().EMail.Trim();
                case 7:
                    return UserData().Telefono.Trim();
                case 8:
                    return UserData().Segmento.Trim();
                case 9:
                    return UserData().Nivel.Trim();
                case 10:
                    return Util.Edad(UserData().FechaNacimiento).ToString().Trim();
                default:
                    return "";
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises().ToList();
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public JsonResult ObtenerPaises()
        {
            IEnumerable<PaisModel> lst = DropDowListPaises();
            return Json(new
            {
                listapaises = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerBannerPrevio(string vTipoBanner, int vPaisID, int vCampaniaID)
        {
            /*
            * 1: Seccion Principal
            * 2: Seccion Intermedia 1
            * 3: Seccion Intermedia 2
            * 4: Seccion Intermedia 3
            * 5: Seccion Intermedia 4
            * 6: Seccion Baja 1
            * 7: Seccion Baja 2
            * 8: Seccion Baja 3
            * 9: Seccion Baja 4
            * vTipoBanner = P => Principal
            * vTipoBanner = I => Intermedio
            * vTipoBanner = B => Baja
            */
            bool issuccess = true;
            List<BEBannerInfo> lstBannerInfo = null;

            try
            {
                string CodigoConsultora = UserData().CodigoConsultora;
                bool ConsultoraNueva = UserData().ConsultoraNueva == 2 ? true : false;

                using (ContenidoServiceClient svc1 = new ContenidoServiceClient())
                {
                    lstBannerInfo = svc1.SelectBannerByConsultora(vPaisID, vCampaniaID, CodigoConsultora, ConsultoraNueva).ToList();
                }

                if (vTipoBanner == "P")
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID == 1
                                     select item).ToList();
                }
                else if (vTipoBanner == "P_SB2")
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID == 150
                                     select item).ToList();
                }
                //else if (vTipoBanner == "I")
                //{
                //    lstBannerInfo = (from item in lstBannerInfo
                //                     where item.GrupoBannerID != 1 && item.GrupoBannerID != 6 &&
                //                     item.GrupoBannerID != 7 && item.GrupoBannerID != 8 && item.GrupoBannerID != 9
                //                     select item).ToList();
                //}
                else if (vTipoBanner == "B")
                {
                    lstBannerInfo = (from item in lstBannerInfo
                                     where item.GrupoBannerID == 6 ||
                                     item.GrupoBannerID == 7 || item.GrupoBannerID == 8 || item.GrupoBannerID == 9 ||
                                    item.GrupoBannerID == 24 || item.GrupoBannerID == 25
                                     select item).OrderBy(x => x.Orden).ToList();
                }
                else
                    lstBannerInfo = new List<BEBannerInfo>();

                // 1664 - ObtenerBannerPrevio
                if (lstBannerInfo != null && lstBannerInfo.Count > 0)
                {
                    lstBannerInfo.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(Globals.UrlBanner, x.Archivo, Globals.RutaImagenesBanners));
                }

                issuccess = true;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                issuccess = false;
            }

            return Json(new
            {
                success = issuccess,
                lstBannerInfo = lstBannerInfo
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ActualizarNroOrdenBanner(List<BEBannerOrden> banners)
        {
            try
            {
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.UpdOrdenNumberBanner(UserData().PaisID, banners.ToArray());
                }

                return Json(new
                {
                    success = true,
                    message = "Los registros han sido guardados satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        //RQ_BS - R2133
        public JsonResult CargarArbolRegionesZonas(int? pais)
        {
            if (pais.GetValueOrDefault() == 0)
                return Json(null, JsonRequestBehavior.AllowGet);

            // consultar las regiones y zonas
            IList<BEZonificacionJerarquia> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.GetZonificacionJerarquia(pais.GetValueOrDefault());
            }
            // se crea el arbol de nodos para el control de la vista
            JsTreeModel[] tree = lst.Distinct<BEZonificacionJerarquia>(new BEZonificacionJerarquiaComparer()).Select(
                                    r => new JsTreeModel
                                    {
                                        data = r.RegionNombre,
                                        attr = new JsTreeAttribute
                                        {
                                            id = r.RegionId * 1000,
                                            selected = false
                                        },
                                        children = lst.Where(i => i.RegionId == r.RegionId).Select(
                                                        z => new JsTreeModel
                                                        {
                                                            data = z.ZonaNombre,
                                                            attr = new JsTreeAttribute
                                                            {
                                                                id = z.ZonaId,
                                                                selected = false
                                                            }
                                                        }).ToArray()
                                    }).ToArray();
            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2133
        public JsonResult ObtenerPaisesBanSegZona(int BannerId, int CampaniaId)
        {
            IEnumerable<PaisModel> lst = DropDowListPaisesByBannerId(BannerId, CampaniaId);
            return Json(new
            {
                listapaises = lst
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2133

        public JsonResult ObtenerSegmentoBanner(int PaisId)
        {
            IEnumerable<BESegmentoBanner> lst = null;

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                /*RE2544 - CS(CGI) - 13/05/2015 */
                if (PaisId == 14)
                {
                    lst = sv.GetSegmentoBanner(PaisId);
                }
                else
                {
                    /*RE2544 - CS(CGI) - 13/05/2015 */
                    lst = sv.GetSegmentoInternoBanner(PaisId);
                }
            }

            return Json(new
            {
                listasegmento = lst
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2133
        public JsonResult ObtenerSegmentoZona(int BannerId, int CampaniaId, int PaisId)
        {
            BEBannerSegmentoZona oBEBannerSegmentoZona = null;

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                oBEBannerSegmentoZona = sv.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId);
            }

            if (oBEBannerSegmentoZona == null)
            {
                oBEBannerSegmentoZona = new BEBannerSegmentoZona()
                {
                    Segmento = -1,
                    ConfiguracionZona = string.Empty
                };
            }

            return Json(new
            {
                Segmento = oBEBannerSegmentoZona.Segmento,
                ConfiguracionZona = oBEBannerSegmentoZona.ConfiguracionZona
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2133
        private IEnumerable<PaisModel> DropDowListPaisesByBannerId(int BannerId, int CampaniaId)
        {
            List<BEBannerSegmentoZona> lst;
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lst = sv.GetBannerPaisesAsignados(CampaniaId, BannerId).ToList();
            }
            Mapper.CreateMap<BEBannerSegmentoZona, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisId))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.NombrePais))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombrePais));

            return Mapper.Map<IList<BEBannerSegmentoZona>, IEnumerable<PaisModel>>(lst);
        }

        //RQ_BS - R2133
        /* RE2544 - CS - Agregando nuevo parametro SegmentoInterno */
        public JsonResult UpdBannerPaisSegmentoZona(int BannerId, int CampaniaId, int PaisId, int Segmento, string ConfiguracionZona, string SegmentoInternoId)
        {
            string Mensaje = string.Empty;
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    sv.UpdBannerPaisSegmentoZona(CampaniaId, BannerId, PaisId, Segmento, ConfiguracionZona, SegmentoInternoId);
                }
                Mensaje = "La información se guardó con éxito.";
            }
            catch (Exception ex)
            {
                Mensaje = "Ocurrió un error: " + ex.Message;
            }

            return Json(new
            {
                Mensaje = Mensaje
            }, JsonRequestBehavior.AllowGet);
        }

        //RQ_BS - R2133
        public void EliminarCacheBanner(int CampaniaId)
        {
            try
            {
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.DeleteCacheBanner(CampaniaId);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
            }
        }

        /*CGI(RSA) - REQ 2544 INICIO*/
        public JsonResult ObtenerBannerSegmentoSeccion(int CampaniaId, int BannerId, int PaisId)
        {
            BEBannerSegmentoZona banner = null;

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                banner = sv.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId);
            }

            return Json(new
            {
                Banner = banner
            }, JsonRequestBehavior.AllowGet);
        }
        /*CGI(RSA) - REQ 2544 FIN*/

        #endregion

    }

    //R2133
    public class BEZonificacionJerarquiaComparer : IEqualityComparer<BEZonificacionJerarquia>
    {
        #region IEqualityComparer<Contact> Members

        public bool Equals(BEZonificacionJerarquia x, BEZonificacionJerarquia y)
        {
            return x.RegionId.Equals(y.RegionId);
        }

        public int GetHashCode(BEZonificacionJerarquia obj)
        {
            return obj.RegionId.GetHashCode();
        }

        #endregion
    }
}