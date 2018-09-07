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
                model.PaisNombre = userData.NombrePais;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

                var carpetaPais = Globals.UrlOfertasNuevas + "/" + userData.CodigoISO;
                if (lst != null && lst.Count > 0)
                {
                    lst.Update(x => x.ImagenProducto01 = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto01));
                    lst.Update(x => x.ImagenProducto02 = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto02));
                    lst.Update(x => x.ImagenProducto03 = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto03));
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

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
                                           a.ganahasta.ToString("#0.00")
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
                int result;
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

        public JsonResult ValidarUnidadesPermitidas(int vPaisID, string vCodigoCampania, string vCUV, int vUnidadesActual)
        {
            try
            {
                string mensaje = string.Empty;
                int result;
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

        public JsonResult GetDescripcionPackByCUV(int vPaisID, string vCodigoCampania, string vCUV)
        {
            try
            {
                BEOfertaNueva result;
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

        public IEnumerable<CampaniaModel> DropDownCampanias(int paisId)
        {
            IList<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        private IEnumerable<PaisModel> CargarDropDowListPaises()
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

        public JsonResult ObtenerISOPais(int paisID)
        {
            string iso = Util.GetPaisISO(paisID);

            return Json(new
            {
                ISO = iso
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UpdEstadoPacksOfertasNuevas(int vCambioEstado)
        {
            try
            {
                int result;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.UpdEstadoPacksOfertasNuevas(userData.PaisID, userData.CodigoConsultora, vCambioEstado);
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

        public ActionResult InsertOfertasNuevas(OfertaNuevaModel model)
        {
            try
            {
                BEOfertaNueva entidad = Mapper.Map<OfertaNuevaModel, BEOfertaNueva>(model);

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    string tempImage01 = model.ImagenProducto01 ?? string.Empty;
                    string tempImage02 = model.ImagenProducto02 ?? string.Empty;
                    string tempImage03 = model.ImagenProducto03 ?? string.Empty;
                    int paisId = userData.PaisID;
                    string iso = Util.GetPaisISO(paisId);
                    var carpetaPais = Globals.UrlOfertasNuevas + "/" + iso;

                    if (!string.IsNullOrEmpty(tempImage01))
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CUV + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto01 = newfilename;
                    }
                    else
                        entidad.ImagenProducto01 = string.Empty;

                    if (!string.IsNullOrEmpty(tempImage02))
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CUV + "_" + time + "_" + "02" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage02);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto02 = newfilename;
                    }
                    else
                        entidad.ImagenProducto02 = string.Empty;

                    if (!string.IsNullOrEmpty(tempImage03))
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CUV + "_" + time + "_" + "03" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage03);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto03 = newfilename;
                    }
                    else
                        entidad.ImagenProducto03 = string.Empty;

                    entidad.PaisID = paisId;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Nueva;
                    entidad.ConfiguracionOfertaID = Constantes.TipoOferta.Nueva;
                    svc.InsertOfertasNuevas(entidad);
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

        public ActionResult UpdateOfertasNuevas(OfertaNuevaModel model)
        {
            try
            {
                BEOfertaNueva entidad = Mapper.Map<OfertaNuevaModel, BEOfertaNueva>(model);

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    string tempImage01 = model.ImagenProducto01 ?? string.Empty;
                    string tempImage02 = model.ImagenProducto02 ?? string.Empty;
                    string tempImage03 = model.ImagenProducto03 ?? string.Empty;
                    string tempImagenProductoAnterior01 = model.ImagenProductoAnterior01 ?? string.Empty;
                    string tempImagenProductoAnterior02 = model.ImagenProductoAnterior02 ?? string.Empty;
                    string tempImagenProductoAnterior03 = model.ImagenProductoAnterior03 ?? string.Empty;
                    int paisId = userData.PaisID;
                    string iso = Util.GetPaisISO(paisId);
                    var carpetaPais = Globals.UrlOfertasNuevas + "/" + iso;

                    if (tempImage01 != tempImagenProductoAnterior01)
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CUV + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage01);
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenProductoAnterior01);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto01 = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage01))
                        entidad.ImagenProducto01 = string.Empty;

                    if (tempImage02 != tempImagenProductoAnterior02)
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CUV + "_" + time + "_" + "02" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage02);
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenProductoAnterior02);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto02 = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage02))
                        entidad.ImagenProducto02 = string.Empty;

                    if (tempImage03 != tempImagenProductoAnterior03)
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = iso + "_" + model.CUV + "_" + time + "_" + "03" + "_" + FileManager.RandomString() + ".png";
                        var path = Path.Combine(Globals.RutaTemporales, tempImage03);
                        ConfigS3.DeleteFileS3(carpetaPais, tempImagenProductoAnterior03);
                        ConfigS3.SetFileS3(path, carpetaPais, newfilename);
                        entidad.ImagenProducto03 = newfilename;
                    }
                    else if (string.IsNullOrEmpty(tempImage03))
                        entidad.ImagenProducto03 = string.Empty;

                    entidad.PaisID = paisId;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;

                    svc.UpdOfertasNuevas(entidad);
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

        public ActionResult DeleteOfertaNueva(OfertaNuevaModel model)
        {
            try
            {
                BEOfertaNueva entidad = Mapper.Map<OfertaNuevaModel, BEOfertaNueva>(model);

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    int paisId = userData.PaisID;

                    entidad.PaisID = paisId;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;

                    svc.DelOfertasNuevas(entidad, Constantes.TipoOferta.Nueva);
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

        public JsonResult UpdEstadoPacksOfertasNueva()
        {
            try
            {
                int result;
                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    result = svc.UpdEstadoPacksOfertasNueva(userData.PaisID, Convert.ToInt32(userData.ConsultoraID), userData.CodigoConsultora, userData.CampaniaID);
                }

                if (result == 0)
                    return Json(new { result = false, mensaje = "Ocurrió un error al actualizar el numero de acceso al sistema" }, JsonRequestBehavior.AllowGet);



                return Json(new { result = true, mensaje = string.Empty }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new { result = false, mensaje = ex.Message }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { result = false, mensaje = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}