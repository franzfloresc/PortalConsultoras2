using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomHelpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class MatrizComercialController : BaseController
    {
        public ActionResult AdministrarMatrizComercial()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MatrizComercial/AdministrarMatrizComercial"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var model = new MatrizComercialModel()
            {
                lstPais = DropDowListPaises(),
                ExpValidacionNemotecnico = GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico)
            };

            return View(model);
        }

        public ActionResult ConsultarMatrizComercial(string sidx, string sord, int page, int rows, int paisID, string codigoSAP)
        {
            if (ModelState.IsValid)
            {
                List<BEMatrizComercial> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetMatrizComercialByCodigoSAP(paisID, codigoSAP).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                IEnumerable<BEMatrizComercial> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoSAP":
                            items = lst.OrderBy(x => x.CodigoSAP);
                            break;
                        case "DescripcionOriginal":
                            items = lst.OrderBy(x => x.DescripcionOriginal);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoSAP":
                            items = lst.OrderBy(x => x.CodigoSAP);
                            break;
                        case "DescripcionOriginal":
                            items = lst.OrderBy(x => x.DescripcionOriginal);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                string ISO = Util.GetPaisISO(paisID);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    ISOPais = ISO.ToString().Trim(),
                    rows = from a in items
                           select new
                           {
                               id = a.CodigoSAP,
                               cell = new string[]
                               {
                                   a.IdMatrizComercial.ToString(),
                                   a.CodigoSAP.ToString(),
                                   a.DescripcionOriginal.ToString(),
                                   a.Descripcion.ToString()
                                }
                           }
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
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

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private string UploadFoto(string foto, string preFileName, string carpetaPais)
        {
            if (!string.IsNullOrEmpty(foto))
            {
                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                var newfilename = preFileName + time + "_" + FileManager.RandomString() + ".png";
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, foto), carpetaPais, newfilename);
                return newfilename;
            }
            return string.Empty;
        }

        private string ReplaceFoto(string foto, string fotoAnterior, string preFileName, string carpetaPais)
        {
            if (foto != fotoAnterior)
            {
                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                string newfilename = preFileName + time + "_" + FileManager.RandomString() + ".png";
                ConfigS3.DeleteFileS3(carpetaPais, fotoAnterior);
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, foto), carpetaPais, newfilename);
                return newfilename;
            }
            return foto;
        }

        private FileNameFormat GetFileNameFormat(int paisID, string codigoSAP)
        {
            string paisISO = Util.GetPaisISO(paisID);
            return new FileNameFormat
            {
                PreFileName = string.Format("{0}_{1}", paisISO, codigoSAP),
                CarpetaPais = string.Format("{0}/{1}", Globals.UrlMatriz, paisISO)
            };
        }

        [HttpPost]
        public JsonResult InsertMatrizComercial(MatrizComercialModel model)
        {
            try
            {
                BEMatrizComercial entidad = Mapper.Map<MatrizComercialModel, BEMatrizComercial>(model);
                entidad.UsuarioRegistro = userData.CodigoConsultora;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsMatrizComercial(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Matriz de Productos satisfactoriamente.",
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
        public JsonResult UpdateMatrizComercial(MatrizComercialModel model)
        {
            try
            {
                BEMatrizComercial entidad = Mapper.Map<MatrizComercialModel, BEMatrizComercial>(model);
                entidad.UsuarioModificacion = userData.CodigoConsultora;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.UpdMatrizComercial(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Matriz de Productos satisfactoriamente.",
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
        public JsonResult ActualizarMatrizComercial(MatrizComercialModel model)
        {
            try
            {
                var idMatrizComercial = model.IdMatrizComercial;
                var isNewRecord = false;
                if (idMatrizComercial == 0)
                {
                    isNewRecord = true;
                    BEMatrizComercial entidad = Mapper.Map<MatrizComercialModel, BEMatrizComercial>(model);
                    entidad.UsuarioRegistro = userData.CodigoConsultora;

                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        idMatrizComercial = sv.InsMatrizComercial(entidad);
                    }
                }

                var nombreArchivo = Request["qqfile"];
                new UploadHelper().UploadFile(Request, nombreArchivo);

                string nombreArchivoSinExtension = null;
                if (model.NemotecnicoActivo)
                {
                    nombreArchivoSinExtension = nombreArchivo.Substring(0, nombreArchivo.LastIndexOf('.'));
                }

                var formatoArchivo = GetFileNameFormat(model.PaisID, model.CodigoSAP);
                var entity = new BEMatrizComercialImagen
                {
                    IdMatrizComercial = idMatrizComercial,
                    PaisID = model.PaisID,
                    UsuarioRegistro = userData.CodigoConsultora,
                    UsuarioModificacion = userData.CodigoConsultora,
                    NemoTecnico = nombreArchivoSinExtension,
                    DescripcionComercial = model.DescripcionComercial
                };

                bool isNewImage = false;
                if (model.IdMatrizComercialImagen == 0)
                {
                    isNewImage = true;
                    entity.Foto = this.UploadFoto(nombreArchivo, formatoArchivo.PreFileName, formatoArchivo.CarpetaPais);
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        model.IdMatrizComercialImagen = sv.InsMatrizComercialImagen(entity);
                    }
                }
                else
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        entity.IdMatrizComercialImagen = model.IdMatrizComercialImagen;
                        entity.Foto = this.ReplaceFoto(nombreArchivo, model.Foto, formatoArchivo.PreFileName, formatoArchivo.CarpetaPais);
                        sv.UpdMatrizComercialImagen(entity);
                    }
                }

                var urlS3 = ConfigS3.GetUrlS3(formatoArchivo.CarpetaPais);

                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Matriz de Productos satisfactoriamente.",
                    isNewRecord = isNewRecord,
                    isNewImage = isNewImage,
                    idMatrizComercial = idMatrizComercial,
                    idMatrizComercialImagen = model.IdMatrizComercialImagen,
                    codigoSap = model.CodigoSAP,
                    foto = urlS3 + entity.Foto
                }, "text/html");
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
        public JsonResult ActualizarNemotecnicoMatrizComercial(MatrizComercialModel model)
        {
            var entity = new BEMatrizComercialImagen
            {
                IdMatrizComercialImagen = model.IdMatrizComercialImagen,
                PaisID = model.PaisID,
                UsuarioModificacion = userData.CodigoConsultora,
                NemoTecnico = model.Nemotecnico
            };

            using (var sv = new PedidoServiceClient())
            {
                sv.UpdMatrizComercialNemotecnico(entity);
            }

            return Json(new
            {
                entity = model,
                success = true,
                message = "Se actualizó el nemotécnico satisfactoriamente."
            });
        }

        [HttpPost]
        public JsonResult ActualizarDescripcionComercial(MatrizComercialModel model)
        {
            var entity = new BEMatrizComercialImagen
            {
                IdMatrizComercialImagen = model.IdMatrizComercialImagen,
                PaisID = model.PaisID,
                UsuarioModificacion = userData.CodigoConsultora,
                DescripcionComercial = model.DescripcionComercial,
            };

            using (var sv = new PedidoServiceClient())
            {
                sv.UpdMatrizComercialDescripcionComercial(entity);
            }

            return Json(new
            {
                entity = model,
                success = true,
                message = "Se actualizó la descripción comercial satisfactoriamente."
            });
        }

        [HttpPost]
        public string UpdDescripcionProductoMasivo(HttpPostedFileBase flDescProd)
        {
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEMatrizComercial> lstmatriz = new List<BEMatrizComercial>();

                if (flDescProd != null)
                {
                    string extension = Path.GetExtension(flDescProd.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    finalPath = Path.Combine(pathFile, newfileName);
                    flDescProd.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                if (IsNumeric(values[0].ToString().Trim()))
                                {
                                    BEMatrizComercial ent = new BEMatrizComercial();
                                    ent.CodigoSAP = values[0].ToString().Trim();
                                    ent.Descripcion = values[1].ToString().Trim();
                                    if (!string.IsNullOrEmpty(ent.CodigoSAP))
                                        lstmatriz.Add(ent);
                                }
                            }
                        }
                    }
                    if (lstmatriz.Count > 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            int paisID = Util.GetPaisID(UserData().CodigoISO);
                            if (paisID > 0)
                            {
                                try
                                {
                                    registros += sv.UpdMatrizComercialDescripcionMasivo(paisID, lstmatriz.ToArray(), UserData().CodigoConsultora);
                                }
                                catch (FaultException ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                                }
                            }
                        }
                    }
                }
                #endregion

                if (registros > 0)
                {
                    message = "Se realizó la actualización de " + registros + " producto(s)";
                }
                else
                {
                    message = "No se actualizó ninguna descripción de los productos que estaban dentro del archivo (CSV), verifique que el código sea correcto.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Se actualizaron solo las descripciones de " + registros + " producto(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Se actualizaron solo las descripciones de " + registros + " producto(s).";
            }
            return message;
        }

        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;

            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        public JsonResult ObtenerISOPais(int paisID)
        {
            string ISO = Util.GetPaisISO(paisID);
            string habilitarNemotecnico = ObtenerValorTablaLogica(paisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.BusquedaNemotecnicoMatriz);

            return Json(new
            {
                ISO = ISO,
                habilitarNemotecnico = habilitarNemotecnico == "1"
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetImagesByIdMatriz(int paisID, int idMatrizComercial, int pagina)
        {
            List<BEMatrizComercialImagen> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetMatrizComercialImagenByIdMatrizImagen(paisID, idMatrizComercial, pagina, 10).ToList();
            }

            return GetImagesCommonResult(lst, paisID);
        }

        public JsonResult GetImagesByCodigoSAP(int paisID, string codigoSAP, int pagina)
        {
            var lst = new List<BEMatrizComercialImagen>();
            int totalRegistros = 0;
            int idMatrizComercial = 0;
            int rows = 10;
            int pageCount = 0;
            var data = new List<MatrizComercialImagen>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAPPaginado(paisID, codigoSAP, pagina, rows).ToList();
            }

            if (lst.Any())
            {
                var tieneImagenes = lst.First().IdMatrizComercialImagen != 0;
                idMatrizComercial = lst.First().IdMatrizComercial;

                if (tieneImagenes)
                {
                    totalRegistros = lst.First().TotalRegistros;
                    data = MapImages(lst, paisID);
                }

                var grid = new BEGrid()
                {
                    PageSize = rows,
                    CurrentPage = pagina,
                };

                var pag = Util.PaginadorGenerico(grid, totalRegistros);

                pageCount = pag.PageCount;
            }

            return Json(new { imagenes = data, idMatrizComercial = idMatrizComercial, totalRegistros = totalRegistros, totalPaginas = pageCount });
        }

        public JsonResult GetImagesByNemotecnico(int paisID, int idMatrizComercial, string nemoTecnico, int tipoBusqueda, int pagina)
        {
            List<BEMatrizComercialImagen> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenByNemotecnico(paisID, idMatrizComercial, null, null, 0, 0, 0, nemoTecnico, tipoBusqueda, pagina, 10).ToList();
            }

            return GetImagesCommonResult(lst, paisID);
        }

        public JsonResult GetImagesByNemotecnicoSAP(int paisID, string codigoSAP, string nemoTecnico, int tipoBusqueda, int pagina)
        {
            List<BEMatrizComercialImagen> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenByNemotecnico(paisID, 0, null, codigoSAP, 0, 0, 0, nemoTecnico, tipoBusqueda, pagina, 10).ToList();
            }

            return GetImagesCommonResult(lst, paisID);
        }

        private JsonResult GetImagesCommonResult(List<BEMatrizComercialImagen> lst, int paisID)
        {
            int totalRegistros = lst.Any() ? lst[0].TotalRegistros : 0;
            var data = MapImages(lst, paisID);

            return Json(new { imagenes = data, totalRegistros = totalRegistros });
        }

        private List<MatrizComercialImagen> MapImages(List<BEMatrizComercialImagen> lst, int paisID)
        {
            string paisISO = Util.GetPaisISO(paisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisISO;
            var urlS3 = ConfigS3.GetUrlS3(carpetaPais);

            var data = lst.Select(p => new MatrizComercialImagen
            {
                IdMatrizComercialImagen = p.IdMatrizComercialImagen,
                FechaRegistro = p.FechaRegistro.HasValue ? p.FechaRegistro.Value : default(DateTime),
                Foto = urlS3 + p.Foto,
                NemoTecnico = p.NemoTecnico,
                DescripcionComercial = p.DescripcionComercial
            }).ToList();

            return data;
        }
    }
}
