using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common.Reader;
using Portal.Consultoras.Web.Infraestructure.Reader;

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

                model.DropDownListTipoAccion = new List<BETipoAccion>() { new BETipoAccion { TipoAccion = 0, TipoAccionNombre = "URL Destino" },
                                                                          new BETipoAccion { TipoAccion = 1, TipoAccionNombre = "Agregar CUV al Pedido" },
                                                                          new BETipoAccion { TipoAccion = 2, TipoAccionNombre = "Curso" }};

                model.DropDownListPaginaNueva = new List<BEPaginaNueva>() { new BEPaginaNueva { PaginaNueva = 0, PaginaNuevaNombre = "NO" },
                                                                                new BEPaginaNueva { PaginaNueva = 1, PaginaNuevaNombre = "SI" }};

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }

        [HttpPost]
        public string InsertarActualizar(BannerModel model)
        {
            string message;
            string httpPath = string.Empty;
            try
            {
                BEBanner obeBanner = new BEBanner();

                if (model.Accion == "Insertar")
                {
                    var img = Image.FromFile(Globals.RutaTemporales + @"\" + System.Net.WebUtility.UrlDecode(model.ImagenActualizar));
                    if (img.Width > model.Ancho || img.Height > model.Alto)
                        return string.Format("El archivo adjunto no tiene las dimensiones correctas. Verifique que sea un archivo con " +
                                                       "una dimensión máxima de hasta {0} x {1}", model.Ancho, model.Alto);
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
                        var img = Image.FromFile(Globals.RutaTemporales + @"\" + System.Net.WebUtility.UrlDecode(model.ImagenActualizar));
                        if (img.Width > model.Ancho || img.Height > model.Alto)
                            return string.Format("El archivo adjunto no tiene las dimensiones correctas. Verifique que sea un archivo con " +
                                                           "una dimensión máxima de hasta {0} x {1}", model.Ancho, model.Alto);

                        img.Dispose();

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
                obeBanner.URL = model.URL ?? string.Empty;
                obeBanner.FlagGrupoConsultora = model.FlagGrupoConsultora;
                obeBanner.UdpSoloBanner = true;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Ocurrió un error inesperado al Registrar el Banner, Por favor intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Ocurrió un error inesperado al Registrar el Banner, Por favor intente nuevamente.";
            }

            return message;
        }

        [HttpPost]
        public string InsertarGrupoBanner(HttpPostedFileBase flConsultoras, BannerModel model)
        {
            string message;
            try
            {
                bool isCorrect = true;
                List<BEGrupoConsultora> lstGrupoConsultora = new List<BEGrupoConsultora>();

                if (flConsultoras != null)
                {
                    string fileName = Path.GetFileName(flConsultoras.FileName) ?? "";
                    string pathBanner = Server.MapPath("~/Content/FileConsultoras");
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    var finalPath = Path.Combine(pathBanner, fileName);
                    flConsultoras.SaveAs(finalPath);

                    BEGrupoConsultora obeGrupoConsultora = new BEGrupoConsultora();
                    lstGrupoConsultora = Util.ReadXmlFile(finalPath, obeGrupoConsultora, false, ref isCorrect);
                }

                List<BEPais> lstPais;
                using (ZonificacionServiceClient svc = new ZonificacionServiceClient())
                {
                    lstPais = svc.SelectPaises().OrderBy(x => x.PaisID).ToList();
                }
                foreach (BEPais itemPais in lstPais)
                {
                    lstGrupoConsultora.Where(x => x.PaisCodigo == itemPais.CodigoISO).Each(y => y.PaisID = itemPais.PaisID);
                }
                lstGrupoConsultora.RemoveAll(x => x.PaisID == 0);

                var obeGrupo = new BEGrupoBanner
                {
                    CampaniaID = model.CampaniaID,
                    GrupoBannerID = model.GrupoBannerID,
                    TiempoRotacion = model.TiempoRotacion,
                    Consultoras = lstGrupoConsultora.ToArray()
                };
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.SaveGrupoBanner(obeGrupo);
                }

                message = "Se registró correctamente.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente.";
            }

            return message;
        }

        [HttpPost]
        public JsonResult InsertarPaisPorBanner(List<BEBanner> lstBanner)
        {
            try
            {
                lstBanner.ForEach(item =>
                {
                    item.Archivo = System.Net.WebUtility.UrlDecode(item.Archivo);
                    item.UdpSoloBanner = false;
                    item.URL = item.URL ?? string.Empty;
                    item.Archivo = item.Archivo ?? string.Empty;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente."
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

                    BEGrid grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<BEGrupoBanner> items = lst;

                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                                a.Nombre,
                                a.Nombre,
                                a.Dimension,
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

                    var carpetaPais = Globals.UrlBanner;
                    if (lst.Count > 0) lst.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(carpetaPais, x.Archivo, Globals.RutaImagenesBanners));

                    BEGrid grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<BEBanner> items = lst;

                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

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

            List<string> colNames = new List<string>
            {
                "BannerID",
                "GrupoBannerID",
                "Titulo",
                "Archivo",
                "ArchivoRutaCompleto",
                "Url",
                "TipoContenido",
                "PaginaNueva",
                "TituloComentario",
                "TextoComentario",
                "TipoAccion",
                "CuvPedido",
                "CantCuvPedido"
            };

            List<Model> colModel = new List<Model>
            {
                new Model
                {
                    name = "BannerID",
                    index = "BannerID",
                    width = 150,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model
                {
                    name = "GrupoBannerID",
                    index = "GrupoBannerID",
                    width = 150,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model {name = "Titulo", index = "Titulo", width = 150, key = true, sortable = false},
                new Model
                {
                    name = "Archivo",
                    index = "Archivo",
                    width = 150,
                    key = false,
                    sortable = false,
                    formatter = "formatearArchivo"
                },
                new Model
                {
                    name = "ArchivoRutaCompleto",
                    index = "ArchivoRutaCompleto",
                    width = 150,
                    key = true,
                    sortable = true,
                    hidden = true
                },
                new Model {name = "Url", index = "Url", width = 150, key = true, sortable = false, hidden = true},
                new Model
                {
                    name = "TipoContenido",
                    index = "TipoContenido",
                    width = 150,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model
                {
                    name = "PaginaNueva",
                    index = "PaginaNueva",
                    width = 150,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model
                {
                    name = "TituloComentario",
                    index = "TituloComentario",
                    width = 0,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model
                {
                    name = "TextoComentario",
                    index = "TextoComentario",
                    width = 0,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model
                {
                    name = "TipoAccion",
                    index = "TipoAccion",
                    width = 0,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model
                {
                    name = "CuvPedido",
                    index = "CuvPedido",
                    width = 0,
                    key = true,
                    sortable = false,
                    hidden = true
                },
                new Model
                {
                    name = "CantCuvPedido",
                    index = "CantCuvPedido",
                    width = 0,
                    key = true,
                    sortable = false,
                    hidden = true
                }
            };

            using (ZonificacionServiceClient svc = new ZonificacionServiceClient())
            {
                lstPais = svc.SelectPaises().OrderBy(x => x.PaisID).ToList();
            }
            foreach (BEPais item in lstPais)
            {
                colNames.Add(item.CodigoISO);
                colModel.Add(new Model { name = item.CodigoISO, index = item.CodigoISO, width = 20, key = false, sortable = false, align = "center", formatter = "CustomCheckBox" });
            }

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

            bool issuccess;
            List<BEBannerInfo> lstFinalInfo = new List<BEBannerInfo>();
            try
            {
                int segmentoBanner;
                if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                {
                    segmentoBanner = userData.SegmentoID;
                }
                else
                {
                    segmentoBanner = userData.SegmentoInternoID ?? userData.SegmentoID;
                }

                List<BEBannerInfo> lstBannerInfoTemp;
                using (ContenidoServiceClient svc1 = new ContenidoServiceClient())
                {
                    lstBannerInfoTemp = svc1.SelectBannerByConsultoraBienvenida(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva).ToList();
                }

                string zonaIdStr = "," + userData.ZonaID.ToString().Trim() + ",";
                lstBannerInfoTemp.Where(p => p.ConfiguracionZona != string.Empty).Update(p => p.ConfiguracionZona = "," + p.ConfiguracionZona + ",");

                lstBannerInfoTemp = lstBannerInfoTemp.Where(p => p.ConfiguracionZona == string.Empty || p.ConfiguracionZona.Contains(zonaIdStr)).ToList();
                List<BEBannerInfo> lstBannerInfo = lstBannerInfoTemp.Where(p => p.Segmento == -1 || p.Segmento == segmentoBanner).ToList();

                foreach (BEBannerInfo item in lstBannerInfo)
                {
                    if (item.GrupoBannerID == 151)
                        item.GrupoBannerID = -5;
                    else if (item.GrupoBannerID == 152)
                        item.GrupoBannerID = -6;
                    else if (item.GrupoBannerID == 153)
                        item.GrupoBannerID = -7;
                }

                #region Select -5,-6,-7
                List<BEBannerInfo> banTempInter = lstBannerInfo.Where(p => p.GrupoBannerID > -8 && p.GrupoBannerID < -4).ToList();

                if (banTempInter.Count > 0)
                {
                    lstBannerInfo.RemoveAll(p => p.GrupoBannerID > -8 && p.GrupoBannerID < -4);

                    List<BEBannerInfo> interTemp1Sb2 = banTempInter.Where(p => p.GrupoBannerID == -5).ToList();
                    List<BEBannerInfo> interTemp2Sb2 = banTempInter.Where(p => p.GrupoBannerID == -6).ToList();
                    List<BEBannerInfo> interTemp3Sb2 = banTempInter.Where(p => p.GrupoBannerID == -7).ToList();

                    if (interTemp1Sb2.Any())
                    {
                        lstBannerInfo.AddRange(interTemp1Sb2);
                    }

                    if (interTemp2Sb2.Any())
                    {
                        lstBannerInfo.AddRange(interTemp2Sb2);
                    }

                    if (interTemp3Sb2.Any())
                    {
                        lstBannerInfo.AddRange(interTemp3Sb2);
                    }
                }
                #endregion

                #region Ordenamiento
                if (lstBannerInfo.Count > 0)
                {
                    lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID == 150).OrderBy(x => x.Orden).ToList());
                    lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID == -5).OrderBy(x => x.Orden).ToList());
                    lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID == -6).OrderBy(x => x.Orden).ToList());
                    lstFinalInfo.AddRange(lstBannerInfo.Where(x => x.GrupoBannerID == -7).OrderBy(x => x.Orden).ToList());
                }
                #endregion

                issuccess = true;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                issuccess = false;
            }

            if (lstFinalInfo.Any())
                lstFinalInfo.ForEach(x => x.Archivo = ConfigS3.GetUrlFileS3(Globals.UrlBanner, x.Archivo, Globals.RutaImagenesBanners));

            var lstFinalModel = Mapper.Map<List<BannerInfoModel>>(lstFinalInfo);

            lstFinalModel.ForEach(item =>
            {
                item.Clase = "";
                if (item.Titulo.ToLower() == "c" + userData.CampaniaNro + "_revistadigital_" + userData.CodigoISO.ToLower())
                {
                    item.Codigo = Constantes.BannerCodigo.RevistaDigital;
                    if (!(revistaDigital.TieneRevistaDigital()))
                    {
                        var valBool = ValidarPermiso("", Constantes.ConfiguracionPais.RevistaDigitalSuscripcion);
                        if (valBool)
                        {
                            if (revistaDigital.NoVolverMostrar)
                            {
                                if (revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.NoPopUp
                                    || revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Desactivo
                                    || revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.SinRegistroDB)
                                {
                                    item.Clase = "oculto";
                                }
                            }
                            else
                            {
                                item.Clase = "oculto";

                            }
                        }
                    }
                }

            });

            lstFinalModel = lstFinalModel.Where(m => m.Clase != "oculto").ToList();

            return Json(new
            {
                success = issuccess,
                data = lstFinalModel
            });
        }

        [HttpPost]
        public ActionResult ImageMatrizUpload(string qqfile)
        {
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    if (postedFile != null)
                    {
                        var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                        var path = Path.Combine(Globals.RutaTemporales, fileName);
                        if (!System.IO.File.Exists(Globals.RutaTemporales))
                            Directory.CreateDirectory(Globals.RutaTemporales);
                        postedFile.SaveAs(path);
                        path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                    }

                    return Json(new { success = true, name = qqfile }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    return Json(new { success = true, name = ffFileName }, "text/html");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
            List<string> lstCell = new List<string>
            {
                obe.BannerID.ToString(),
                obe.GrupoBannerID.ToString(),
                obe.Titulo,
                obe.Archivo.Substring(obe.Archivo.LastIndexOf("/") + 1),
                obe.Archivo,
                obe.URL,
                obe.TipoContenido.ToString(),
                obe.PaginaNueva.ToString(),
                obe.TituloComentario ?? string.Empty,
                obe.TextoComentario ?? string.Empty,
                obe.TipoAccion.ToString(),
                obe.CuvPedido ?? string.Empty,
                obe.CantCuvPedido.ToString()
            };

            foreach (BEPais obePais in lstPais)
            {
                if (obe.Paises != null)
                {
                    List<int> lstIdPais = obe.Paises.ToList();
                    if (obe.Paises != null && lstIdPais.Exists(x => x == obePais.PaisID))
                    {
                        lstCell.Add("1|" + obePais.PaisID.ToString());
                    }
                    else
                    {
                        lstCell.Add("0|" + obePais.PaisID.ToString());
                    }
                }
                else
                {
                    lstCell.Add("0|" + obePais.PaisID.ToString());
                }
            }

            if (obe.GrupoBannerID != 2 && obe.GrupoBannerID != 3 && obe.GrupoBannerID != 4 && obe.GrupoBannerID != 5 && obe.GrupoBannerID != 11 && obe.GrupoBannerID != 12 && obe.GrupoBannerID != 13 && obe.GrupoBannerID != 14 && obe.GrupoBannerID != 151 && obe.GrupoBannerID != 16 && obe.GrupoBannerID != 17 && obe.GrupoBannerID != 18 && obe.GrupoBannerID != 19 && obe.GrupoBannerID != 20 && obe.GrupoBannerID != 21 && obe.GrupoBannerID != 22)
            {
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
            int cantidadValidacion;
            using (SACServiceClient sv = new SACServiceClient())
            {
                var listCantidad = sv.GetTablaLogicaDatos(userData.PaisID, 21).ToList();
                cantidadValidacion = Convert.ToInt32((from item in listCantidad where item.TablaLogicaDatosID == 2101 select item.Codigo).First());
            }

            if (cantidadValidacion == 0)
                return true;

            int cantidadEnvios;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                cantidadEnvios = sv.ValidarEnvioCatalogo(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID, cantidadValidacion);
            }

            return cantidadEnvios >= cantidadValidacion;
        }

        public string DevolverCadenaParametros()
        {
            var txtBuil = new StringBuilder();
            txtBuil.Append("?");

            List<ServiceContenido.BEParametro> list;

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                list = sv.GetParametrosBanners().ToList();
            }

            foreach (ServiceContenido.BEParametro item in list)
            {
                txtBuil.Append(item.Abreviatura + "=" + DevolverValorParametro(item.ParametroId) + "&");
            }

            var cadena = txtBuil.ToString();
            cadena = cadena.Substring(0, cadena.Length - 1);

            return cadena;
        }

        private string DevolverValorParametro(int parametroId)
        {
            switch (parametroId)
            {
                case 1:
                    return userData.NombrePais.Trim();
                case 2:
                    return userData.CampaniaID.ToString().Trim();
                case 3:
                    return userData.CodigoConsultora.Trim();
                case 4:
                    return userData.CodigoZona.Trim();
                case 5:
                    return userData.NombreConsultora.Trim();
                case 6:
                    return userData.EMail.Trim();
                case 7:
                    return userData.Telefono.Trim();
                case 8:
                    return userData.Segmento.Trim();
                case 9:
                    return userData.Nivel.Trim();
                case 10:
                    return Util.Edad(userData.FechaNacimiento).ToString().Trim();
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
            bool issuccess;
            List<BEBannerInfo> lstBannerInfo = null;

            try
            {
                string codigoConsultora = userData.CodigoConsultora;

                using (ContenidoServiceClient svc1 = new ContenidoServiceClient())
                {
                    lstBannerInfo = svc1.SelectBannerByConsultora(vPaisID, vCampaniaID, codigoConsultora, userData.ConsultoraNueva == Constantes.EstadoActividadConsultora.Ingreso_Nueva).ToList();
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

                if (lstBannerInfo.Count > 0)
                {
                    lstBannerInfo.Update(x => x.Archivo = ConfigS3.GetUrlFileS3(Globals.UrlBanner, x.Archivo, Globals.RutaImagenesBanners));
                }

                issuccess = true;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                issuccess = false;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                    svc.UpdOrdenNumberBanner(userData.PaisID, banners.ToArray());
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult CargarArbolRegionesZonas(int? pais)
        {
            if (pais.GetValueOrDefault() == 0)
                return Json(null, JsonRequestBehavior.AllowGet);

            IList<BEZonificacionJerarquia> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.GetZonificacionJerarquia(pais.GetValueOrDefault());
            }
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

        public JsonResult ObtenerPaisesBanSegZona(int BannerId, int CampaniaId)
        {
            IEnumerable<PaisModel> lst = DropDowListPaisesByBannerId(BannerId, CampaniaId);
            return Json(new
            {
                listapaises = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerSegmentoBanner(int PaisId)
        {
            IEnumerable<BESegmentoBanner> lst;

            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (PaisId == 14)
                {
                    lst = sv.GetSegmentoBanner(PaisId);
                }
                else
                {
                    lst = sv.GetSegmentoInternoBanner(PaisId);
                }
            }

            return Json(new
            {
                listasegmento = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerSegmentoZona(int BannerId, int CampaniaId, int PaisId)
        {
            BEBannerSegmentoZona obeBannerSegmentoZona;

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                obeBannerSegmentoZona = sv.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId);
            }

            if (obeBannerSegmentoZona == null)
            {
                obeBannerSegmentoZona = new BEBannerSegmentoZona
                {
                    Segmento = -1,
                    ConfiguracionZona = string.Empty,
                    TipoAcceso = -1
                };
            }

            return Json(new
            {
                obeBannerSegmentoZona.Segmento,
                obeBannerSegmentoZona.ConfiguracionZona,
                obeBannerSegmentoZona.TipoAcceso
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<PaisModel> DropDowListPaisesByBannerId(int bannerId, int campaniaId)
        {
            List<BEBannerSegmentoZona> lst;
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lst = sv.GetBannerPaisesAsignados(campaniaId, bannerId).ToList();
            }

            return Mapper.Map<IList<BEBannerSegmentoZona>, IEnumerable<PaisModel>>(lst);
        }

        [HttpPost]
        public async Task<JsonResult> UpdBannerPaisSegmentoZona(HttpPostedFileBase csvConsultoras, BEBannerSegmentoZona segmentoZona)
        {
            segmentoZona.CodigosConsultora = await GetCodes(csvConsultoras); 
            var mensaje = UpdateBannerPaisSegmentoZonaInternal(segmentoZona);

            return Json(new
            {
                Mensaje = mensaje
            });
        }

        public void EliminarCacheBanner(int campaniaId)
        {
            try
            {
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    svc.DeleteCacheBanner(campaniaId);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
            }
        }

        public JsonResult ObtenerBannerSegmentoSeccion(int CampaniaId, int BannerId, int PaisId)
        {
            BEBannerSegmentoZona banner;

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                banner = sv.GetBannerSegmentoSeccion(CampaniaId, BannerId, PaisId);
            }

            return Json(new
            {
                Banner = banner
            }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Private Methods
        private string UpdateBannerPaisSegmentoZonaInternal(BEBannerSegmentoZona segmentoZona)
        {
            string mensaje;
            try
            {
                using (var sv = new ContenidoServiceClient())
                {
                    sv.UpdBannerPaisSegmentoZona(segmentoZona);
                }

                mensaje = "La información se guardó con éxito.";
            }
            catch (Exception ex)
            {
                mensaje = "Ocurrió un error: " + ex.Message;
            }

            return mensaje;
        }

        private async Task<string> GetCodes(HttpPostedFileBase postFile)
        {
            if (postFile == null)
            {
                return null;
            }
            IStreamReader reader = new DefaultStreamReader();

            return await reader.Read(postFile.InputStream, new ColumnCsvTransform()); 
        }
        #endregion

    }

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