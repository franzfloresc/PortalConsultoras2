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
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AccesorizateController : BaseController
    {
        #region Visualización de Pedidos Liquidación

        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        public ActionResult Productos()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Accesorizate/Productos"))
                    return RedirectToAction("Index", "Bienvenida");
                ViewBag.CampaniaID = UserData().CampaniaID.ToString();
                ViewBag.ISO = UserData().CodigoISO;
                var lista = GetListadoOfertasLiquidacion();
                if (lista != null && lista.Count > 0)
                    lista.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));
                BEConfiguracionCampania obeConfiguracionCampania;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    obeConfiguracionCampania = sv.GetEstadoPedido(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().ZonaID, UserData().RegionID);
                }
                if (obeConfiguracionCampania != null)
                    ValidarStatusCampania(obeConfiguracionCampania);


                ViewBag.ListaOfertasLiquidacion = lista;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View();
        }

        public string GetDescripcionMarca(int marcaId)
        {
            string result = string.Empty;

            switch (marcaId)
            {
                case 1:
                    result = "L'Bel";
                    break;
                case 2:
                    result = "Ésika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 6:
                    result = "Finart";
                    break;
            }

            return result;
        }

        private void ValidarStatusCampania(BEConfiguracionCampania obeConfiguracionCampania)
        {
            UsuarioModel usuario = UserData();
            usuario.ZonaValida = obeConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = obeConfiguracionCampania.FechaInicioFacturacion;

            usuario.FechaFinCampania = obeConfiguracionCampania.FechaInicioFacturacion.AddDays(obeConfiguracionCampania.DiasDuracionCronograma - 1);

            usuario.HoraInicioReserva = obeConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = obeConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = obeConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = obeConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = obeConfiguracionCampania.DiasAntes;
            usuario.NombreCorto = obeConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = obeConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = obeConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = obeConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = obeConfiguracionCampania.HoraCierreZonaNormal;

            if (DateTime.Now.AddHours(obeConfiguracionCampania.ZonaHoraria) < obeConfiguracionCampania.FechaInicioFacturacion.AddDays(-obeConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = obeConfiguracionCampania.FechaInicioFacturacion.AddDays(-obeConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = obeConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = obeConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = obeConfiguracionCampania.HoraFin;
            }
            SetUserData(usuario);
        }

        public List<OfertaProductoModel> GetListadoOfertasLiquidacion()
        {
            List<BEOfertaProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int cantidad = sv.ObtenerMaximoItemsaMostrarZA(UserData().PaisID);
                lst = sv.GetOfertaProductosPortal(UserData().PaisID, Constantes.ConfiguracionOferta.Accesorizate, 1, UserData().CampaniaID).Take(cantidad).ToList();
            }

            if (lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + UserData().CodigoISO));
            }

            return Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lst);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            try
            {
                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = UserData().PaisID;
                    entidad.ConsultoraID = UserData().ConsultoraID;
                    entidad.CampaniaID = UserData().CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Accesorizate;
                    entidad.IPUsuario = UserData().IPUsuario;

                    entidad.CodigoUsuarioCreacion = UserData().CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                    entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

                    sv.InsPedidoWebDetalleOferta(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se agregó la Oferta Web satisfactoriamente.",
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
        public JsonResult UpdateOfertaWebPortal(PedidoDetalleModel model)
        {
            try
            {
                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = UserData().PaisID;
                    entidad.ConsultoraID = UserData().ConsultoraID;
                    entidad.CampaniaID = UserData().CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Accesorizate;

                    entidad.CodigoUsuarioCreacion = UserData().CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.UpdPedidoWebDetalleOferta(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Web satisfactoriamente.",
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

        public JsonResult ObtenerStockActualProducto(string CUV)
        {
            int stock;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                stock = sv.GetStockOfertaProductoLiquidacion(UserData().PaisID, UserData().CampaniaID, CUV);
            }

            return Json(new
            {
                Stock = stock
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerStockActualProductoLista(List<ValidacionStockModel> Lista)
        {
            string msj = string.Empty;

            if (Lista.Count > 0)
            {
                var txtBuil = new StringBuilder();

                for (int i = 0; i < Lista.Count; i++)
                {
                    int stock;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        stock = sv.GetStockOfertaProductoLiquidacion(UserData().PaisID, UserData().CampaniaID, Lista[i].CUV);
                    }

                    if (Lista[i].Stock > stock)
                        txtBuil.Append("- El stock para el CUV <b>" + Lista[i].CUV + "</b> es <b>" + stock + "</b> unidades deberá validar la cantidad nuevamente.\n");
                }
                msj = txtBuil.ToString();
            }
            return Json(new
            {
                Mensaje = msj
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerUnidadesPermitidasProducto(string CUV)
        {
            int unidadesPermitidas;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                unidadesPermitidas = sv.GetUnidadesPermitidasByCuvZA(UserData().PaisID, UserData().CampaniaID, CUV, Constantes.ConfiguracionOferta.Accesorizate);
            }

            return Json(new
            {
                UnidadesPermitidas = unidadesPermitidas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV)
        {
            int unidadesPermitidas;
            int saldo;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                unidadesPermitidas = sv.GetUnidadesPermitidasByCuvZA(UserData().PaisID, UserData().CampaniaID, CUV, Constantes.ConfiguracionOferta.Accesorizate);
                saldo = sv.ValidarUnidadesPermitidasEnPedidoZA(UserData().PaisID, UserData().CampaniaID, CUV, UserData().ConsultoraID, Constantes.ConfiguracionOferta.Accesorizate);
            }

            return Json(new
            {
                UnidadesPermitidas = unidadesPermitidas,
                Saldo = saldo
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCantidadMaximaPorPais(int paisID)
        {
            int cantidad;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                cantidad = sv.ObtenerMaximoItemsaMostrarZA(paisID);
            }

            return Json(new
            {
                Cantidad = cantidad
            }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Administrador de Ofertas de Liquidación

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Accesorizate/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var cronogramaModel = new OfertaProductoModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstConfiguracionOferta = new List<ConfiguracionOfertaModel>(),
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
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

        public JsonResult ObtenerDatosAdministracionCorreo(int paisID)
        {
            List<BEAdministracionOfertaProducto> lst = new List<BEAdministracionOfertaProducto>();

            if (paisID > 0)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetDatosAdmStockMinimoCorreosZA(paisID, Constantes.ConfiguracionOferta.Accesorizate).ToList();
                }
            }

            if (lst.Count > 0)
            {
                return Json(new
                {
                    Correo = lst[0].Correos,
                    Stock = lst[0].StockMinimo
                }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new
                {
                    Correo = string.Empty,
                    Stock = string.Empty
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisID)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisID, Constantes.ConfiguracionOferta.Accesorizate).ToList();
                lst = lstConfiguracion;
            }

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ConfiguracionOfertaModel> lstConfig = DropDowListConfiguracion(PaisID);
            return Json(new
            {
                lista = lst,
                lstConfig = lstConfig
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            List<BEMatrizComercial> lst;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAP(paisID, codigoSAP).ToList();
            }

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
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

        public JsonResult ObtenerOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            int orden;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                orden = sv.GetOrdenPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID);
            }

            return Json(new
            {
                Orden = orden
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarPriorizacion(int paisID, string codigoOferta, int CampaniaID, int Orden)
        {
            int flagExiste;
            int configuracionOfertaId = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                flagExiste = sv.ValidarPriorizacion(paisID, configuracionOfertaId, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = flagExiste
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ConsultarOfertaLiquidacion(string sidx, string sord, int page, int rows, int PaisID, string codigoOferta, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaProducto> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosByTipoOferta(PaisID, Constantes.ConfiguracionOferta.Accesorizate, CampaniaID, codigoOferta).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEOfertaProducto> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "TipoOferta":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderBy(x => x.CodigoProducto);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderBy(x => x.CodigoCampania);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "PrecioOferta":
                            items = lst.OrderBy(x => x.PrecioOferta);
                            break;
                        case "Orden":
                            items = lst.OrderBy(x => x.Orden);
                            break;
                        case "Stock":
                            items = lst.OrderBy(x => x.Stock);
                            break;
                        case "UnidadesPermitidas":
                            items = lst.OrderBy(x => x.UnidadesPermitidas);
                            break;

                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "TipoOferta":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderByDescending(x => x.CodigoProducto);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderByDescending(x => x.CodigoCampania);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "PrecioOferta":
                            items = lst.OrderByDescending(x => x.PrecioOferta);
                            break;
                        case "Orden":
                            items = lst.OrderByDescending(x => x.Orden);
                            break;
                        case "Stock":
                            items = lst.OrderByDescending(x => x.Stock);
                            break;
                        case "UnidadesPermitidas":
                            items = lst.OrderByDescending(x => x.UnidadesPermitidas);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                string iso = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + iso;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + iso));
                lst.Update(x => x.ISOPais = iso);
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.NroOrden,
                               cell = new string[]
                               {
                                   a.TipoOferta,
                                   a.CodigoProducto,
                                   a.CodigoCampania,
                                   a.CUV,
                                   a.Descripcion,
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.Orden.ToString(),
                                   a.Stock.ToString(),
                                   a.StockInicial.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.ImagenProducto,
                                   a.CampaniaID.ToString() ,
                                   a.Stock.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaProductoID.ToString(),
                                   a.CodigoTipoOferta.Trim(),
                                   a.ISOPais,
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult InsertOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Accesorizate;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioRegistro = UserData().CodigoConsultora;
                    sv.InsOfertaProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó el Producto Accesorizate satisfactoriamente.",
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
        public JsonResult UpdateOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Accesorizate;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;
                    sv.UpdOfertaProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó el Producto Accesorizate satisfactoriamente.",
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
        public JsonResult DeshabilitarOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;
                    sv.DelOfertaProducto(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito el Producto Accesorizate satisfactoriamente.",
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
        public string ActualizarStockMasivo(HttpPostedFileBase flStock)
        {
            string message;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV

                List<BEOfertaProducto> lstStock = new List<BEOfertaProducto>();

                if (flStock != null)
                {
                    string fileName = Path.GetFileName(flStock.FileName) ?? "";
                    string pathBanner = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    var finalPath = Path.Combine(pathBanner, fileName);
                    flStock.SaveAs(finalPath);

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            var values = inputLine.Split(',');

                            if (values.Length <= 1) continue;
                            if (!IsNumeric(values[1].Trim()) || !IsNumeric(values[3].Trim())) continue;

                            BEOfertaProducto ent = new BEOfertaProducto
                            {
                                ISOPais = values[0].Trim(),
                                CampaniaID = int.Parse(values[1]),
                                CUV = values[2].Trim(),
                                Stock = int.Parse(values[3].Trim())
                            };
                            if (ent.Stock >= 0)
                                lstStock.Add(ent);
                        }
                    }
                    if (lstStock.Count > 0)
                    {
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.Accesorizate);
                        List<BEOfertaProducto> lstPaises = lstStock.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            int paisId = Util.GetPaisID(lstPaises[i].ISOPais);
                            if (paisId <= 0) continue;

                            List<BEOfertaProducto> lstStockTemporal = lstStock.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);

                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                try
                                {
                                    registros += sv.UpdOfertaProductoStockMasivo(paisId, lstStockTemporal.ToArray());

                                    #region Log de Cargas de Stock
                                    using (PedidoServiceClient srv = new PedidoServiceClient())
                                    {
                                        BEStockCargaLog ent = new BEStockCargaLog
                                        {
                                            CantidadRegistros = registros,
                                            PaisID = paisId,
                                            TipoOfertaSisID = Constantes.ConfiguracionOferta.Accesorizate,
                                            UsuarioRegistro = UserData().CodigoConsultora
                                        };
                                        srv.InsStockCargaLog(ent);
                                    }
                                    #endregion
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
                    message = "Se realizó la actualización de stock de " + registros + " Productos";
                else
                    message = "No se actualizó el stock de ninguno de los productos que estaban dentro del archivo (CSV), verifique el Tipo de Oferta.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Se actualizó el stock solo de " + registros + " registros, debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                message = "Se actualizó el stock solo de " + registros + " registros, debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
            }
            return message;
        }

        [HttpPost]
        public JsonResult AdministrarCorreosOferta(AdministracionOfertaProductoModel model)
        {
            try
            {
                BEAdministracionOfertaProducto entidad = Mapper.Map<AdministracionOfertaProductoModel, BEAdministracionOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = UserData().PaisID;
                    entidad.UsuarioModificacion = UserData().CodigoConsultora;
                    entidad.UsuarioRegistro = UserData().CodigoConsultora;
                    entidad.OfertaAdmID = Constantes.ConfiguracionOferta.Accesorizate;
                    if (model.FlagRegistro == 0)
                        sv.InsAdministracionStockMinimoZA(entidad);
                    else
                        sv.UpdAdministracionStockMinimoZA(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró satisfactoriamente la Administración del Stock Mínimo.",
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

        public static bool IsNumeric(object expression)
        {
            double retNum;
            var isNum = Double.TryParse(Convert.ToString(expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

        [HttpPost]
        public JsonResult ActualizarCantidadMaximaMostrar(int PaisID, int Cantidad)
        {
            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.ActualizarItemsMostrarZA(PaisID, Cantidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó satisfactoriamente el registro.",
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

        public ActionResult ExportarExcel(int vPaisID, int vCampania, string vCodigoOferta)
        {
            List<BEOfertaProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosByTipoOferta(vPaisID, Constantes.ConfiguracionOferta.Accesorizate, vCampania, vCodigoOferta).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Tipo Oferta", "TipoOferta"},
                {"Código SAP", "CodigoProducto"},
                {"Campaña", "CodigoCampania"},
                {"CUV", "CUV"},
                {"Descripción", "Descripcion"},
                {"Precio Oferta", "PrecioOferta"},
                {"Priorización", "Orden"},
                {"Stock", "Stock"},
                {"Stock Inicial", "StockInicial"},
                {"UnidadesPermitidas", "UnidadesPermitidas"}
            };
            Util.ExportToExcel("ProductosAccesorizate", lst, dic);
            return View();
        }


        #endregion
    }
}
