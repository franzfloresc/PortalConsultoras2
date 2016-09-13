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
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarTipoEstrategiaController : BaseController
    {
        //
        // GET: /AdministrarTipoEstrategia/

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
                List<BETipoEstrategia> lst;
                var entidad = new BETipoEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.TipoEstrategiaID = 0;

                if (Consulta == "1")
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        lst = sv.GetTipoEstrategias(entidad).ToList();
                    }
                }
                else
                {
                    lst = new List<BETipoEstrategia>();
                }

                string carpetapais = Globals.UrlMatriz + "/" + UserData().CodigoISO;

                if (lst != null && lst.Count > 0)
                    lst.Update(x => x.ImagenEstrategia = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenEstrategia, carpetapais));

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
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
                                   a.DescripcionEstrategia.ToString(),
                                   a.DescripcionOferta.ToString(),                                   
                                   a.Orden.ToString(),
                                   a.ImagenEstrategia.ToString(),
                                   a.OfertaID.ToString(),
                                   a.FlagActivo.ToString(),
                                   a.FlagNueva.ToString(),
                                   a.FlagRecoProduc.ToString(),
                                   a.FlagRecoPerfil.ToString(),
                                   string.IsNullOrEmpty( a.CodigoPrograma) ? string.Empty: a.CodigoPrograma.ToString(),
                                   a.FlagMostrarImg.ToString()     // SB20-353
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
                List<BEOferta> lst = new List<BEOferta>();
                BEOferta entidad = new BEOferta();
                entidad.PaisID = UserData().PaisID;
                entidad.TipoEstrategiaID = Convert.ToInt32(id);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetOfertas(entidad).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEOferta> items = lst;

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
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
                                   a.CodigoOferta.ToString(),
                                   a.DescripcionOferta.ToString()
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

        [HttpPost]
        public JsonResult RegistrarOferta(string OfertaID, string PaisID, string CodigoOferta, string DescripcionOferta, string CodigoPrograma = null)
        {
            int resultado = 0;
            string operacion = "registró";
            try
            {
                BEOferta entidad = new BEOferta();
                entidad.OfertaID = Convert.ToInt32(OfertaID);
                entidad.PaisID = UserData().PaisID;
                entidad.CodigoOferta = CodigoOferta;
                entidad.DescripcionOferta = DescripcionOferta;
                entidad.UsuarioRegistro = UserData().CodigoUsuario;
                entidad.UsuarioModificacion = UserData().CodigoUsuario;
                entidad.CodigoPrograma = CodigoPrograma;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.InsertarOferta(entidad);
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
            int resultado = 0;
            string operacion = "eliminó";
            try
            {
                BEOferta entidad = new BEOferta();
                entidad.OfertaID = Convert.ToInt32(OfertaID);
                entidad.PaisID = UserData().PaisID;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.DeleteOferta(entidad);
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

        /* SB2-353 - INICIO */
        [HttpPost]
        public JsonResult Registrar(string TipoEstrategiaID, string DescripcionEstrategia,
                        string ImagenEstrategia, string Orden,
                        string FlagActivo,  string OfertaID, string imagenAnterior,
                        string FlagNueva, string FlagRecoProduc, string FlagRecoPerfil,
                        string CodigoPrograma, string FlagMostrarImg)
        {
            int resultado = 0;
            string operacion = "registró";
            try
            {
                BETipoEstrategia entidad = new BETipoEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID);
                entidad.DescripcionEstrategia = DescripcionEstrategia;
                entidad.ImagenEstrategia = ImagenEstrategia;
                entidad.Orden = Convert.ToInt32(Orden);
                entidad.FlagActivo = Convert.ToInt32(FlagActivo);
                entidad.OfertaID = OfertaID;
                entidad.UsuarioRegistro = UserData().CodigoUsuario;
                entidad.UsuarioModificacion = UserData().CodigoUsuario;
                entidad.FlagNueva = Convert.ToInt32(FlagNueva);
                entidad.FlagRecoPerfil = Convert.ToInt32(FlagRecoPerfil);
                entidad.FlagRecoProduc = Convert.ToInt32(FlagRecoProduc);
                entidad.CodigoPrograma = CodigoPrograma;
                entidad.FlagMostrarImg = Convert.ToInt32(FlagMostrarImg);    // SB20-353

                if (ImagenEstrategia != "")
                {
                    if (imagenAnterior != ImagenEstrategia)
                    {
                        var path = Path.Combine(Globals.RutaTemporales, ImagenEstrategia);
                        var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                        var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = UserData().CodigoISO + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                        if (imagenAnterior != "") ConfigS3.DeleteFileS3(carpetaPais, imagenAnterior);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenEstrategia = newfilename;
                    }
                }

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.InsertarTipoEstrategia(entidad);
                }

                if (TipoEstrategiaID != "0")
                {
                    operacion = "actualizó";
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
        /* SB2-353 - FIN */

        [HttpPost]
        public JsonResult Eliminar(string PaisID, string TipoEstrategiaID)
        {
            int resultado = 0;
            string operacion = "eliminó";
            try
            {
                var entidad = new BETipoEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.EliminarTipoEstrategia(entidad);
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
            string FileName = string.Empty;
            try
            {
                // req. 1664 - Unificando todo en una unica carpeta temporal
                Stream inputStream = Request.InputStream;
                byte[] fileBytes = ReadFully(inputStream);
                string ffFileName = qqfile; // qqfile;
                var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                System.IO.File.WriteAllBytes(path, fileBytes);
                if (!System.IO.File.Exists(Globals.RutaTemporales))
                    System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
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
            catch (Exception)
            {
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
