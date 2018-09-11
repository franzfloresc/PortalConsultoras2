using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomHelpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var model = new MatrizComercialModel()
            {
                lstPais = DropDowListPaises(),
                ExpValidacionNemotecnico = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico)
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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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
                            items = lst.OrderByDescending(x => x.CodigoSAP);
                            break;
                        case "DescripcionOriginal":
                            items = lst.OrderByDescending(x => x.DescripcionOriginal);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                string iso = Util.GetPaisISO(paisID);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    ISOPais = iso.Trim(),
                    rows = from a in items
                           select new
                           {
                               id = a.CodigoSAP,
                               cell = new string[]
                               {
                                   a.IdMatrizComercial.ToString(),
                                   a.CodigoSAP,
                                   a.DescripcionOriginal,
                                   a.Descripcion
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
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
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

        private FileNameFormat GetFileNameFormat(int paisId, string codigoSap)
        {
            string paisIso = Util.GetPaisISO(paisId);
            return new FileNameFormat
            {
                PreFileName = string.Format("{0}_{1}", paisIso, codigoSap),
                CarpetaPais = string.Format("{0}/{1}", Globals.UrlMatriz, paisIso)
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
            string message;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV

                List<BEMatrizComercial> lstmatriz = new List<BEMatrizComercial>();

                if (flDescProd != null)
                {
                    string extension = Path.GetExtension(flDescProd.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    var finalPath = Path.Combine(pathFile, newfileName);
                    flDescProd.SaveAs(finalPath);

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            var values = inputLine.Split(',');
                            if (values.Length <= 1) continue;

                            if (!IsNumeric(values[0].Trim())) continue;

                            BEMatrizComercial ent = new BEMatrizComercial
                            {
                                CodigoSAP = values[0].Trim(),
                                Descripcion = values[1].Trim()
                            };
                            if (!string.IsNullOrEmpty(ent.CodigoSAP))
                                lstmatriz.Add(ent);
                        }
                    }
                    if (lstmatriz.Count > 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            int paisId = Util.GetPaisID(userData.CodigoISO);
                            if (paisId > 0)
                            {
                                try
                                {
                                    registros += sv.UpdMatrizComercialDescripcionMasivo(paisId, lstmatriz.ToArray(), userData.CodigoConsultora);
                                }
                                catch (FaultException ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo las descripciones de " + registros + " producto(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo las descripciones de " + registros + " producto(s).";
            }
            return message;
        }

        public static bool IsNumeric(object expression)
        {
            double retNum;
            var isNum = Double.TryParse(Convert.ToString(expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        public JsonResult ObtenerISOPais(int paisID)
        {
            string habilitarNemotecnico = "";
            string iso = "";
            if (paisID > 0)
            {
                iso = Util.Trim(Util.GetPaisISO(paisID));
                if (iso != "")
                {
                    habilitarNemotecnico = _tablaLogicaProvider.ObtenerValorTablaLogica(paisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.BusquedaNemotecnicoMatriz);
                }
            }
            return Json(new
            {
                ISO = iso,
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
            List<BEMatrizComercialImagen> lst;
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

        private List<MatrizComercialImagen> MapImages(List<BEMatrizComercialImagen> lst, int paisId)
        {
            string paisIso = Util.GetPaisISO(paisId);
            var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
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
