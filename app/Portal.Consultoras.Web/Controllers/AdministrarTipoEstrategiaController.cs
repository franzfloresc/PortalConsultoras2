using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarTipoEstrategiaController : BaseController
    {
        public ActionResult Index(TipoEstrategiaModel model)
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarTipoEstrategia/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                model.listaPaises = DropDowListPaises();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string PaisID, string Consulta)
        {
            if (ModelState.IsValid)
            {
                var lst = Consulta == "1" ? GetTipoEstrategias() : new List<BETipoEstrategia>();
                lst = lst ?? new List<BETipoEstrategia>();

                string carpetapais = Globals.UrlMatriz + "/" + UserData().CodigoISO;

                if (lst.Count > 0)
                {
                    lst.Update(x => x.ImagenEstrategia = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenEstrategia, carpetapais));
                    lst.Update(x => x.ImagenOfertaIndependiente = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenOfertaIndependiente, carpetapais));
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BETipoEstrategia> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "TipoEstrategiaID":
                            items = lst.OrderBy(x => x.TipoEstrategiaID);
                            break;
                        case "DescripcionEstrategia":
                            items = lst.OrderBy(x => x.DescripcionEstrategia);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "TipoEstrategiaID":
                            items = lst.OrderByDescending(x => x.TipoEstrategiaID);
                            break;
                        case "DescripcionEstrategia":
                            items = lst.OrderByDescending(x => x.DescripcionEstrategia);
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
                    rows = from a in items
                           select new
                           {
                               id = a.TipoEstrategiaID,
                               cell = new string[]
                               {
                                   a.TipoEstrategiaID.ToString(),
                                   a.Codigo,
                                   a.DescripcionEstrategia,
                                   a.DescripcionOferta,
                                   a.Orden.ToString(),
                                   a.ImagenEstrategia,
                                   a.OfertaID,
                                   a.FlagActivo.ToString(),
                                   a.FlagNueva.ToString(),
                                   a.FlagRecoProduc.ToString(),
                                   a.FlagRecoPerfil.ToString(),
                                   string.IsNullOrEmpty( a.CodigoPrograma) ? string.Empty: a.CodigoPrograma,
                                   a.FlagMostrarImg.ToString(),
                                   a.MostrarImgOfertaIndependiente.ToInt().ToString(),
                                   a.ImagenOfertaIndependiente,
                                   a.FlagValidarImagen.ToString(),
                                   a.PesoMaximoImagen.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarTipoEstrategia");
        }

        public ActionResult ConsultarOfertas(string sidx, string sord, int page, int rows, string id)
        {
            if (ModelState.IsValid)
            {
                List<BEOferta> lst;
                BEOferta entidad = new BEOferta
                {
                    PaisID = UserData().PaisID,
                    TipoEstrategiaID = Convert.ToInt32(id)
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetOfertas(entidad).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEOferta> items = lst;

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
                               id = a.OfertaID,
                               cell = new string[]
                               {
                                   a.OfertaID.ToString(),
                                   a.CodigoOferta,
                                   a.DescripcionOferta
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarTipoEstrategia");
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

        [HttpPost]
        public JsonResult RegistrarOferta(string OfertaID, string PaisID, string CodigoOferta, string DescripcionOferta, string CodigoPrograma = null)
        {
            string operacion = "registró";
            try
            {
                BEOferta entidad = new BEOferta
                {
                    OfertaID = Convert.ToInt32(OfertaID),
                    PaisID = UserData().PaisID,
                    CodigoOferta = CodigoOferta,
                    DescripcionOferta = DescripcionOferta,
                    UsuarioRegistro = UserData().CodigoUsuario,
                    UsuarioModificacion = UserData().CodigoUsuario,
                    CodigoPrograma = CodigoPrograma
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsertarOferta(entidad);
                }

                if (OfertaID != "0")
                {
                    operacion = "modificó";
                }

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito la oferta.", operacion),
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult EliminarOferta(string OfertaID)
        {
            string operacion = "eliminó";
            try
            {
                BEOferta entidad = new BEOferta
                {
                    OfertaID = Convert.ToInt32(OfertaID),
                    PaisID = UserData().PaisID
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.DeleteOferta(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito la oferta.", operacion),
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult Registrar(string TipoEstrategiaID, string DescripcionEstrategia,
                        string ImagenEstrategia, string Orden,
                        string FlagActivo, string OfertaID, string imagenAnterior,
                        string FlagNueva, string FlagRecoProduc, string FlagRecoPerfil,
                        string CodigoPrograma, string FlagMostrarImg,
                        string FlagValidarImagen,
                        string PesoMaximoImagen,
                        bool MostrarImgOfertaIndependiente = false, string ImagenOfertaIndependiente = "",
                        string ImagenOfertaIndependienteAnterior = "", string Codigo = "")
        {
            string operacion = "registró";
            try
            {
                BETipoEstrategia entidad = new BETipoEstrategia
                {
                    PaisID = UserData().PaisID,
                    TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID),
                    DescripcionEstrategia = DescripcionEstrategia,
                    ImagenEstrategia = ImagenEstrategia,
                    Orden = Convert.ToInt32(Orden),
                    FlagActivo = Convert.ToInt32(FlagActivo),
                    OfertaID = OfertaID,
                    UsuarioRegistro = UserData().CodigoUsuario,
                    UsuarioModificacion = UserData().CodigoUsuario,
                    FlagNueva = Convert.ToInt32(FlagNueva),
                    FlagRecoPerfil = Convert.ToInt32(FlagRecoPerfil),
                    FlagRecoProduc = Convert.ToInt32(FlagRecoProduc),
                    CodigoPrograma = CodigoPrograma,
                    FlagMostrarImg = Convert.ToInt32(FlagMostrarImg),
                    MostrarImgOfertaIndependiente = MostrarImgOfertaIndependiente,
                    ImagenOfertaIndependiente = ImagenOfertaIndependiente,
                    Codigo = Codigo,
                    FlagValidarImagen = Convert.ToInt32(FlagValidarImagen),
                    PesoMaximoImagen = Convert.ToInt32(PesoMaximoImagen)
                };

                if (ImagenEstrategia != "" && imagenAnterior != ImagenEstrategia)
                {
                    var path = Path.Combine(Globals.RutaTemporales, ImagenEstrategia);
                    var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                    var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = UserData().CodigoISO + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                    if (imagenAnterior != "") ConfigS3.DeleteFileS3(carpetaPais, imagenAnterior);
                    ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                    entidad.ImagenEstrategia = newfilename;
                }

                if (ImagenOfertaIndependiente != "" && ImagenOfertaIndependienteAnterior != ImagenOfertaIndependiente)
                {
                    var path = Path.Combine(Globals.RutaTemporales, ImagenOfertaIndependiente);
                    var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                    var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = UserData().CodigoISO + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                    if (ImagenOfertaIndependienteAnterior != "") ConfigS3.DeleteFileS3(carpetaPais, ImagenOfertaIndependienteAnterior);
                    ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                    entidad.ImagenOfertaIndependiente = newfilename;
                }

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.TipoEstrategiaID = sv.InsertarTipoEstrategia(entidad);
                }

                if (TipoEstrategiaID != "0")
                {
                    administrarEstrategiaProvider.EditarTipoEstrategia(entidad,userData.CodigoISO);
                    operacion = "actualizó";
                }
                else
                {
                    administrarEstrategiaProvider.RegistrarTipoEstrategia(entidad, userData.CodigoISO);
                }

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito el tipo de estrategia.", operacion),
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
        public JsonResult Eliminar(string PaisID, string TipoEstrategiaID)
        {
            string operacion = "eliminó";
            try
            {
                var entidad = new BETipoEstrategia
                {
                    PaisID = UserData().PaisID,
                    TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID)
                };
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.EliminarTipoEstrategia(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito el Tipo de Estrategia.", operacion),
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
        public ActionResult ImageTipoOfertaUpload(string qqfile)
        {
            try
            {
                Stream inputStream = Request.InputStream;
                byte[] fileBytes = ReadFully(inputStream);
                string ffFileName = qqfile;
                var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                System.IO.File.WriteAllBytes(path, fileBytes);
                if (!System.IO.File.Exists(Globals.RutaTemporales))
                    Directory.CreateDirectory(Globals.RutaTemporales);

                var failImage = false;
                var image = Image.FromFile(path);
                if (image.Width > 62)
                {
                    failImage = true;
                }
                if (image.Height > 62)
                {
                    failImage = true;
                }

                if (failImage)
                {
                    image.Dispose();
                    System.IO.File.Delete(path);
                    return Json(new { success = false, message = "El tamaño de imagen excede el máximo permitido. (Ancho: 62px - Alto: 62px)." }, "text/html");
                }
                image.Dispose();
                return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
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
    }
}
