using AutoMapper;
using Portal.Consultoras.Common;
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
    public class OfertaNuevaController : BaseController
    {

        public ActionResult OfertaNueva()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaNueva/OfertaNueva"))
                return RedirectToAction("Index", "Bienvenida");
            var model = new OfertaNuevaModel();

            try
            {
                IEnumerable<CampaniaModel> lstCampania = new List<CampaniaModel>();
                model.listaPaises = CargarDropDowListPaises();
                model.listaCampania = lstCampania;
                model.PaisNombre = UserData().NombrePais;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View(model);
        }

        public ActionResult ConsultarOfertasNuevas(string sidx, string sord, int page, int rows, int vpaisID, int vCampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaNueva> lst;
                using (PedidoServiceClient srv = new PedidoServiceClient())
                {
                    lst = srv.GetOfertasNuevasByCampania(vpaisID, vCampaniaID).ToList();
                }

                // 1664
                var carpetaPais = Globals.UrlOfertasNuevas + "/" + UserData().CodigoISO;
                if (lst != null)
                    if (lst.Count > 0)
                    {
                        lst.Update(x => x.ImagenProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto01, Globals.RutaImagenesOfertasNuevas + "/" + UserData().CodigoISO));
                        lst.Update(x => x.ImagenProducto02 = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto02, Globals.RutaImagenesOfertasNuevas + "/" + UserData().CodigoISO));
                        lst.Update(x => x.ImagenProducto03 = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto03, Globals.RutaImagenesOfertasNuevas + "/" + UserData().CodigoISO));
                    }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;

                BEPager pag = new BEPager();
                IEnumerable<BEOfertaNueva> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NumeroPedido":
                            items = lst.OrderBy(x => x.NumeroPedido);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderBy(x => x.CodigoProducto);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderBy(x => x.CodigoCampania);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "PrecioNormal":
                            items = lst.OrderBy(x => x.PrecioNormal);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NumeroPedido":
                            items = lst.OrderByDescending(x => x.NumeroPedido);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderByDescending(x => x.CodigoProducto);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderByDescending(x => x.CodigoCampania);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "PrecioNormal":
                            items = lst.OrderByDescending(x => x.PrecioNormal);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    ISOPais = Util.GetPaisISO(vpaisID),
                    rows = from a in items
                           select new
                           {
                               id = a.OfertaNuevaId,
                               cell = new string[]
                                        {
                                           a.OfertaNuevaId.ToString(),
                                           a.CampaniaID.ToString(),
                                           a.UnidadesPermitidas.ToString(),
                                           a.FlagImagenActiva.ToString(),
                                           Convert.ToInt32(a.FlagHabilitarOferta).ToString(),
                                           a.ImagenProducto01,
                                           a.ImagenProducto02,
                                           a.ImagenProducto03,
                                           a.NumeroPedido,
                                           a.CodigoProducto,
                                           a.CodigoCampania,
                                           a.CUV,
                                           a.Descripcion,
                                           a.PrecioNormal.ToString("#0.00"),
                                           a.PrecioParaTi.ToString("#0.00"),
                                           a.ganahasta.ToString("#0.00")//1731
                                        }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Consultar");
        }

        public JsonResult ObtenterDropDownPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lstcampania = DropDownCampanias(PaisID);

            return Json(new
            {
                lstCampania = lstcampania
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarOfertasNuevas(int vPaisID, string vCodigoCampania, string vCUV)
        {
            try
            {
                string mensaje = string.Empty;
                int result = 0;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.ValidarOfertasNuevas(new BEOfertaNueva()
                    {
                        PaisID = vPaisID,
                        CodigoCampania = vCodigoCampania,
                        CUV = vCUV
                    });
                }

                if (result > 0)
                {
                    mensaje = "Ya existe un registro con la misma Campaña y CUV.\nEspecifique otros valores e inténtelo nuevamente.";
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
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

        public JsonResult ValidarUnidadesPermitidas(int vPaisID, string vCodigoCampania, string vCUV, int vUnidadesActual)
        {
            try
            {
                string mensaje = string.Empty;
                int result = 0;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.ValidarUnidadesPermitidas(new BEOfertaNueva()
                    {
                        PaisID = vPaisID,
                        CodigoCampania = vCodigoCampania,
                        CUV = vCUV,
                        UnidadesPermitidas = vUnidadesActual,
                        TipoOfertaSisID = Constantes.ConfiguracionOferta.Nueva,
                        ConfiguracionOfertaID = Constantes.TipoOferta.Nueva
                    });
                }

                if (result > 0)
                {
                    mensaje = string.Format("Existen {0} pedido(s) registrado(s) bajo el mismo CUV y Campaña. Debe de ingresar una Unid. Permitida mayor o igual a esta cantidad.", result);
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
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

        public JsonResult GetDescripcionPackByCUV(int vPaisID, string vCodigoCampania, string vCUV)
        {
            try
            {
                string mensaje = string.Empty;
                BEOfertaNueva result = null;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.GetDescripcionPackByCUV(vPaisID, vCUV, (string.IsNullOrEmpty(vCodigoCampania) ? 0 : Convert.ToInt32(vCodigoCampania)));
                }

                if (result.MarcaID == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "La Campaña o CUV no pertenecen al tipo de Oferta Nueva.\nEspecifique otros valores e inténtelo nuevamente.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = true,
                    precionormal = result.PrecioNormal.ToString("#0.00"),
                    descripcion = result.Descripcion,
                    campaniaid = result.MarcaID,
                    message = "",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
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

        public IEnumerable<CampaniaModel> DropDownCampanias(int PaisID)
        {
            IList<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
               .ForMember(x => x.CampaniaID, t => t.MapFrom(c => c.CampaniaID))
               .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo))
               .ForMember(x => x.Anio, t => t.MapFrom(c => c.Anio))
               .ForMember(x => x.NombreCorto, t => t.MapFrom(c => c.NombreCorto))
               .ForMember(x => x.PaisID, t => t.MapFrom(c => c.PaisID))
               .ForMember(x => x.Activo, t => t.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        private IEnumerable<PaisModel> CargarDropDowListPaises()
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

        public JsonResult ObtenerISOPais(int paisID)
        {
            string ISO = Util.GetPaisISO(paisID);

            return Json(new
            {
                ISO = ISO
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UpdEstadoPacksOfertasNuevas(int vCambioEstado)
        {
            try
            {
                int result = 0;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.UpdEstadoPacksOfertasNuevas(UserData().PaisID, UserData().CodigoConsultora, vCambioEstado);
                }
                if (result == 0)
                    return Json(new
                    {
                        success = false,
                        message = "Ocurrió un error al actualizar el estado de la Oferta Nueva.",
                        extra = ""
                    });

                return Json(new
                {
                    success = true,
                    message = "",
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

        public ActionResult InsertOfertasNuevas(OfertaNuevaModel model)
        {
            try
            {
                Mapper.CreateMap<OfertaNuevaModel, BEOfertaNueva>()
                        .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                        .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                        .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                        .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                        .ForMember(t => t.NumeroPedido, f => f.MapFrom(c => c.NumeroPedido))
                        .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                        .ForMember(t => t.PrecioNormal, f => f.MapFrom(c => c.PrecioNormal))
                        .ForMember(t => t.PrecioParaTi, f => f.MapFrom(c => c.PrecioParaTi))
                        .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                        .ForMember(t => t.ImagenProducto01, f => f.MapFrom(c => c.ImagenProducto01))
                        .ForMember(t => t.ImagenProducto02, f => f.MapFrom(c => c.ImagenProducto02))
                        .ForMember(t => t.ImagenProducto03, f => f.MapFrom(c => c.ImagenProducto03))
                        .ForMember(t => t.FlagImagenActiva, f => f.MapFrom(c => c.FlagImagenActiva))
                        .ForMember(t => t.FlagHabilitarOferta, f => f.MapFrom(c => c.FlagHabilitarOferta))
                        .ForMember(t => t.UsuarioRegistro, f => f.MapFrom(c => c.UsuarioRegistro))
                        .ForMember(t => t.ganahasta, f => f.MapFrom(c => c.ganahasta));//1731

                BEOfertaNueva entidad = Mapper.Map<OfertaNuevaModel, BEOfertaNueva>(model);

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    string tempImage01 = model.ImagenProducto01 ?? string.Empty;
                    string tempImage02 = model.ImagenProducto02 ?? string.Empty;
                    string tempImage03 = model.ImagenProducto03 ?? string.Empty;
                    int paisID = UserData().PaisID;
                    string ISO = Util.GetPaisISO(paisID);
                    var carpetaPais = Globals.UrlOfertasNuevas + "/" + ISO;

                    if (!string.IsNullOrEmpty(tempImage01))
                    {
                        // entidad.ImagenProducto01 = FileManager.CopyImagesMatriz(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage01, Globals.RutaImagenesTempOfertas, ISO, model.CUV, "01");
                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CUV + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto01 = newfilename;
                    }
                    else
                        entidad.ImagenProducto01 = string.Empty;

                    if (!string.IsNullOrEmpty(tempImage02))
                    {
                        // entidad.ImagenProducto02 = FileManager.CopyImagesMatriz(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage02, Globals.RutaImagenesTempOfertas, ISO, model.CUV, "02");
                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CUV + "_" + time + "_" + "02" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage02);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto02 = newfilename;
                    }
                    else
                        entidad.ImagenProducto02 = string.Empty;

                    if (!string.IsNullOrEmpty(tempImage03))
                    {
                        // entidad.ImagenProducto03 = FileManager.CopyImagesMatriz(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage03, Globals.RutaImagenesTempOfertas, ISO, model.CUV, "03");
                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CUV + "_" + time + "_" + "03" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage03);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto03 = newfilename;
                    }
                    else
                        entidad.ImagenProducto03 = string.Empty;

                    entidad.PaisID = paisID;
                    entidad.UsuarioRegistro = UserData().CodigoConsultora;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Nueva;
                    entidad.ConfiguracionOfertaID = Constantes.TipoOferta.Nueva;
                    svc.InsertOfertasNuevas(entidad);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempOfertas, tempImage01);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempOfertas, tempImage02);
                    // FileManager.DeleteImage(Globals.RutaImagenesTempOfertas, tempImage03);
                }

                return Json(new
                {
                    success = true,
                    message = (model.CampaniaIDFin == 0 ? "Se registró la Oferta Nueva satisfactoriamente." : "Se registraron las Ofertas Nuevas satisfactoriamente para el rango de Campañas."),
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

        public ActionResult UpdateOfertasNuevas(OfertaNuevaModel model)
        {
            try
            {
                Mapper.CreateMap<OfertaNuevaModel, BEOfertaNueva>()
                        .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                        .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                        .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                        .ForMember(t => t.NumeroPedido, f => f.MapFrom(c => c.NumeroPedido))
                        .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                        .ForMember(t => t.PrecioNormal, f => f.MapFrom(c => c.PrecioNormal))
                        .ForMember(t => t.PrecioParaTi, f => f.MapFrom(c => c.PrecioParaTi))
                        .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                        .ForMember(t => t.ImagenProducto01, f => f.MapFrom(c => c.ImagenProducto01))
                        .ForMember(t => t.ImagenProducto02, f => f.MapFrom(c => c.ImagenProducto02))
                        .ForMember(t => t.ImagenProducto03, f => f.MapFrom(c => c.ImagenProducto03))
                        .ForMember(t => t.FlagImagenActiva, f => f.MapFrom(c => c.FlagImagenActiva))
                        .ForMember(t => t.FlagHabilitarOferta, f => f.MapFrom(c => c.FlagHabilitarOferta))
                        .ForMember(t => t.OfertaNuevaId, f => f.MapFrom(c => c.OfertaNuevaId))
                        .ForMember(t => t.UsuarioModificacion, f => f.MapFrom(c => c.UsuarioModificacion))
                        .ForMember(t => t.ganahasta, f => f.MapFrom(c => c.ganahasta));//1731

                BEOfertaNueva entidad = Mapper.Map<OfertaNuevaModel, BEOfertaNueva>(model);

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    string tempImage01 = model.ImagenProducto01 ?? string.Empty;
                    string tempImage02 = model.ImagenProducto02 ?? string.Empty;
                    string tempImage03 = model.ImagenProducto03 ?? string.Empty;
                    string tempImagenProductoAnterior01 = model.ImagenProductoAnterior01 ?? string.Empty;
                    string tempImagenProductoAnterior02 = model.ImagenProductoAnterior02 ?? string.Empty;
                    string tempImagenProductoAnterior03 = model.ImagenProductoAnterior03 ?? string.Empty;
                    int paisID = UserData().PaisID;
                    string ISO = Util.GetPaisISO(paisID);
                    var carpetaPais = Globals.UrlOfertasNuevas + "/" + ISO;

                    if (tempImage01 != tempImagenProductoAnterior01)
                    {
                        //entidad.ImagenProducto01 = FileManager.CopyImagesMatriz(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage01, Globals.RutaImagenesTempOfertas, ISO, model.CUV, "01");
                        //FileManager.DeleteImage(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImagenProductoAnterior01);
                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CUV + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenProductoAnterior01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto01 = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage01))
                        entidad.ImagenProducto01 = string.Empty;

                    if (tempImage02 != tempImagenProductoAnterior02)
                    {
                        //entidad.ImagenProducto02 = FileManager.CopyImagesMatriz(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage02, Globals.RutaImagenesTempOfertas, ISO, model.CUV, "02");
                        //FileManager.DeleteImage(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImagenProductoAnterior02);
                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CUV + "_" + time + "_" + "02" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage02);
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenProductoAnterior02);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto02 = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage02))
                        entidad.ImagenProducto02 = string.Empty;

                    if (tempImage03 != tempImagenProductoAnterior03)
                    {
                        //entidad.ImagenProducto03 = FileManager.CopyImagesMatriz(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage03, Globals.RutaImagenesTempOfertas, ISO, model.CUV, "03");
                        //FileManager.DeleteImage(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImagenProductoAnterior03);
                        // 1664
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + model.CUV + "_" + time + "_" + "03" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage03);
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenProductoAnterior03);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto03 = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage03))
                        entidad.ImagenProducto03 = string.Empty;

                    entidad.PaisID = paisID;
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;

                    svc.UpdOfertasNuevas(entidad);
                    //FileManager.DeleteImage(Globals.RutaImagenesTempOfertas, tempImage01);
                    //FileManager.DeleteImage(Globals.RutaImagenesTempOfertas, tempImage02);
                    //FileManager.DeleteImage(Globals.RutaImagenesTempOfertas, tempImage03);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Nueva satisfactoriamente.",
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

        public ActionResult DeleteOfertaNueva(OfertaNuevaModel model)
        {
            try
            {
                Mapper.CreateMap<OfertaNuevaModel, BEOfertaNueva>()
                        .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                        .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                        .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                        .ForMember(t => t.OfertaNuevaId, f => f.MapFrom(c => c.OfertaNuevaId));

                BEOfertaNueva entidad = Mapper.Map<OfertaNuevaModel, BEOfertaNueva>(model);

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    int paisID = UserData().PaisID;
                    string ISO = Util.GetPaisISO(paisID);

                    entidad.PaisID = paisID;
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;

                    svc.DelOfertasNuevas(entidad, Constantes.TipoOferta.Nueva);

                    //if (result > 0)
                    //    return Json(new
                    //    {
                    //        success = false,
                    //        message = "No se puede deshabilitar la Oferta, debido que se encuentra asociado a uno o más pedidos",
                    //        extra = ""
                    //    });

                    //FileManager.DeleteImage(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage01);
                    //FileManager.DeleteImage(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage02);
                    //FileManager.DeleteImage(Globals.RutaImagenesOfertasNuevas + "\\" + ISO, tempImage03);
                }
                return Json(new
                {
                    success = true,
                    message = "Se deshabilitó la Oferta Nueva satisfactoriamente.",
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

        public JsonResult UpdEstadoPacksOfertasNueva()
        {
            try
            {
                int result = 0;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.UpdEstadoPacksOfertasNueva(UserData().PaisID, Convert.ToInt32(UserData().ConsultoraID), UserData().CodigoConsultora, UserData().CampaniaID);
                }


                if (result == 0)
                    return Json(new { result = false, mensaje = "Ocurrió un error al actualizar el numero de acceso al sistema" }, JsonRequestBehavior.AllowGet);



                return Json(new { result = true, mensaje = string.Empty }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);

                return Json(new { result = false, mensaje = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new { result = false, mensaje = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}