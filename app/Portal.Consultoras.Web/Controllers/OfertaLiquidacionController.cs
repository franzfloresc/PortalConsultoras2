using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
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
    public class OfertaLiquidacionController : BaseController
    {
        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();
        protected RenderImgProvider _renderImgProvider;

        public OfertaLiquidacionController()
        {
            _renderImgProvider = new RenderImgProvider();
        }
        
        #region Visualización de Pedidos Liquidación

        public ActionResult OfertasLiquidacion()
        {
            if (userData.CodigoISO == Constantes.CodigosISOPais.Venezuela)
                return RedirectToAction("Index", "Bienvenida");
            try
            {
                ViewBag.CampaniaID = userData.CampaniaID.ToString();
                ViewBag.ISO = userData.CodigoISO;
                BEConfiguracionCampania obeConfiguracionCampania;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    obeConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }
                if (obeConfiguracionCampania != null)
                    ValidarStatusCampania(obeConfiguracionCampania);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View("OfertasLiquidacion");
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
            UsuarioModel usuario = userData;
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
            sessionManager.SetUserData(usuario);
        }

        [HttpGet]
        public JsonResult JsonGetOfertasLiquidacion(int offset, int cantidadregistros, string origen)
        {
            var lst = new List<BEOfertaProducto>();
            var estado = false;
            try
            {
                var cantidad = origen == "OfertaLiquidacion" ? cantidadregistros * 2 : cantidadregistros;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetOfertaProductosPortal2(userData.PaisID, Constantes.ConfiguracionOferta.Liquidacion, 1, userData.CampaniaID, offset, cantidad).ToList();
                }

                if (lst.Count > 0)
                {
                    if (lst.Count > cantidadregistros)
                    {
                        estado = true;
                    }

                    lst = lst.Take(cantidadregistros).ToList();
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    var extensionNombreImagenSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall;
                    var extensionNombreImagenMedium = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium;

                    foreach (var item in lst)
                    {
                        item.ImagenProducto = ConfigCdn.GetUrlFileCdn(carpetaPais, item.ImagenProducto);
                        item.ImagenProductoSmall = string.IsNullOrEmpty(item.ImagenProducto) ? string.Empty : Util.GenerarRutaImagenResize(item.ImagenProducto, extensionNombreImagenSmall);
                        item.ImagenProductoMedium = string.IsNullOrEmpty(item.ImagenProducto) ? string.Empty : Util.GenerarRutaImagenResize(item.ImagenProducto, extensionNombreImagenMedium);
                        item.PrecioString = Util.DecimalToStringFormat(item.PrecioOferta, userData.CodigoISO);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                lista = lst,
                verMas = estado
            }, JsonRequestBehavior.AllowGet);
        }

        public List<OfertaProductoModel> GetListadoOfertasLiquidacion()
        {
            List<BEOfertaProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int cantidad = sv.ObtenerMaximoItemsaMostrarLiquidacion(userData.PaisID);
                lst = sv.GetOfertaProductosPortal(userData.PaisID, Constantes.ConfiguracionOferta.Liquidacion, 1, userData.CampaniaID).Take(cantidad).ToList();
            }

            if (lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto));
            }

            return Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lst);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            string mensaje;
            var noPasa = ReservadoEnHorarioRestringido(out mensaje);
            if (noPasa)
            {
                return Json(new
                {
                    success = false,
                    message = mensaje,
                    extra = ""
                });
            }

            try
            {
                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);

                entidad.PaisID = userData.PaisID;
                entidad.ConsultoraID = userData.ConsultoraID;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                entidad.IPUsuario = userData.IPUsuario;

                entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsPedidoWebDetalleOferta(entidad);

                    sessionManager.SetPedidoWeb(null);
                    sessionManager.SetDetallesPedido(null);
                    sessionManager.SetDetallesPedidoSetAgrupado(null);
                }

                UpdPedidoWebMontosPROL();

                BEIndicadorPedidoAutentico indPedidoAutentico = new BEIndicadorPedidoAutentico
                {
                    PedidoID = entidad.PedidoID,
                    CampaniaID = entidad.CampaniaID,
                    PedidoDetalleID = entidad.PedidoDetalleID,
                    IndicadorIPUsuario = GetIPCliente(),
                    IndicadorFingerprint = "",
                    IndicadorToken = (Session["TokenPedidoAutentico"] != null)
                        ? Session["TokenPedidoAutentico"].ToString()
                        : ""
                };

                InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);

                using (var pedidoServiceClient = new PedidoServiceClient())
                {
                    pedidoServiceClient.InsertPedidoWebSet(userData.PaisID, userData.CampaniaID, userData.PedidoID, model.Cantidad.ToInt(), model.CUV
                        , userData.ConsultoraID, "", string.Format("{0}:1", model.CUV), 0);
                }

                return Json(new
                {
                    success = true,
                    message = "Se agregó la Oferta Web satisfactoriamente.",
                    extra = "",
                    DataBarra = GetDataBarra()
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
        public JsonResult UpdateOfertaWebPortal(PedidoDetalleModel model)
        {
            try
            {
                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.UpdPedidoWebDetalleOferta(entidad);
                }

                UpdPedidoWebMontosPROL();

                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Web satisfactoriamente.",
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

        public JsonResult ObtenerStockActualProducto(string CUV)
        {
            int stock;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                stock = sv.GetStockOfertaProductoLiquidacion(userData.PaisID, userData.CampaniaID, CUV);
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
                        stock = sv.GetStockOfertaProductoLiquidacion(userData.PaisID, userData.CampaniaID, Lista[i].CUV);
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
                unidadesPermitidas = sv.GetUnidadesPermitidasByCuv(userData.PaisID, userData.CampaniaID, CUV);
            }

            return Json(new
            {
                UnidadesPermitidas = unidadesPermitidas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV, string Cantidad, string PrecioUnidad)
        {
            bool resul;
            string mensaje = ValidarMontoMaximo(Convert.ToDecimal(PrecioUnidad), Convert.ToInt32(Cantidad), out resul);

            int unidadesPermitidas = 0;
            int saldo = 0;
            int cantidadPedida = 0;
            var entidad = new BEOfertaProducto
            {
                PaisID = userData.PaisID,
                CampaniaID = userData.CampaniaID,
                CUV = CUV,
                ConsultoraID = Convert.ToInt32(userData.ConsultoraID)
            };

            if (mensaje == "" || resul)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    unidadesPermitidas = sv.GetUnidadesPermitidasByCuv(userData.PaisID, userData.CampaniaID, CUV);
                    saldo = sv.ValidarUnidadesPermitidasEnPedido(userData.PaisID, userData.CampaniaID, CUV, userData.ConsultoraID);
                    cantidadPedida = sv.CantidadPedidoByConsultora(entidad);
                }
            }

            return Json(new
            {
                UnidadesPermitidas = unidadesPermitidas,
                Saldo = saldo,
                CantidadPedida = cantidadPedida,
                message = mensaje,
                result = resul
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCantidadMaximaPorPais(int paisID)
        {
            int cantidad;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                cantidad = sv.ObtenerMaximoItemsaMostrarLiquidacion(paisID);
            }

            return Json(new
            {
                Cantidad = cantidad
            }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Administrador de Ofertas de Liquidación

        public ActionResult AdministrarOfertasLiquidacion()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "OfertaLiquidacion/AdministrarOfertasLiquidacion"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            var cronogramaModel = new OfertaProductoModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstConfiguracionOferta = new List<ConfiguracionOfertaModel>(),
                lstPais = DropDowListPaises(),
                ExpValidacionNemotecnico = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico)
            };
            return View(cronogramaModel);
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

        public JsonResult ObtenerDatosAdministracionCorreo(int paisID)
        {
            List<BEAdministracionOfertaProducto> lst = new List<BEAdministracionOfertaProducto>();

            if (paisID > 0)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetDatosAdmStockMinimoCorreos(paisID).ToList();
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

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisId)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisId, Constantes.ConfiguracionOferta.Liquidacion).ToList();
                lst = lstConfiguracion;
            }

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ConfiguracionOfertaModel> lstConfig = DropDowListConfiguracion(PaisID);
            string habilitarNemotecnico = _tablaLogicaProvider.ObtenerValorTablaLogica(PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.BusquedaNemotecnicoOfertaLiquidacion);

            return Json(new
            {
                lista = lst,
                lstConfig = lstConfig,
                habilitarNemotecnico = habilitarNemotecnico == "1"
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

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int configuracionOfertaId = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
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
                    lst = sv.GetProductosByTipoOferta(PaisID, Constantes.ConfiguracionOferta.Liquidacion, CampaniaID, codigoOferta).ToList();
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
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto));
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
            string mensajeErrorImagenResize = "";
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;

                    #region Imagen Resize 

                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    var rutaImagenCompleta = ConfigS3.GetUrlFileS3(carpetaPais, entidad.ImagenProducto);

                    mensajeErrorImagenResize = _renderImgProvider.ImagenesResizeProceso(rutaImagenCompleta, userData.CodigoISO);
                    
                    #endregion                    

                    sv.InsOfertaProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Liquidación satisfactoriamente." + mensajeErrorImagenResize,
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
        public JsonResult UpdateOfertaWeb(OfertaProductoModel model)
        {
            string mensajeErrorImagenResize = "";
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;

                    #region Imagen Resize 

                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    var rutaImagenCompleta = ConfigS3.GetUrlFileS3(carpetaPais, entidad.ImagenProducto);

                    mensajeErrorImagenResize = _renderImgProvider.ImagenesResizeProceso(rutaImagenCompleta, userData.CodigoISO);

                    #endregion                    

                    sv.UpdOfertaProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Liquidación satisfactoriamente." + mensajeErrorImagenResize,
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
        public JsonResult DeshabilitarOfertaWeb(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    sv.DelOfertaProducto(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito la Oferta de Liquidación satisfactoriamente.",
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
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion);
                        List<BEOfertaProducto> lstPaises = lstStock.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                List<BEOfertaProducto> lstStockTemporal = lstStock.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);
                                int paisId = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisId > 0)
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
                                                TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion,
                                                UsuarioRegistro = userData.CodigoConsultora
                                            };
                                            srv.InsStockCargaLog(ent);
                                        }
                                        #endregion
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
                }
                #endregion

                if (registros > 0)
                    message = "Se realizó la actualización de stock de " + registros + " Productos";
                else
                    message = "No se actualizó el stock de ninguno de los productos que estaban dentro del archivo (CSV), verifique el Tipo de Oferta.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizó el stock solo de " + registros + " registros, debido a que uno o más ISO's ingresados en el archivo aún no están habilitados.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;
                    if (model.FlagRegistro == 0)
                        sv.InsAdministracionStockMinimo(entidad);
                    else
                        sv.UpdAdministracionStockMinimo(entidad);
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
                    sv.ActualizarItemsMostrarLiquidacion(PaisID, Cantidad);
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

        public ActionResult ExportarExcel(int vPaisID, int vCampania, string vCodigoOferta)
        {
            List<BEOfertaProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosByTipoOferta(vPaisID, Constantes.ConfiguracionOferta.Liquidacion, vCampania, vCodigoOferta).ToList();
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
            Util.ExportToExcel("ProductosLiquidacion", lst, dic);
            return View();
        }

        [HttpGet]
        public ActionResult ConsultarTallaColor(string sidx, string sord, int page, int rows, string CampaniaID, string CUV)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaProducto> lst;

                var entidad = new BEOfertaProducto
                {
                    PaisID = userData.PaisID,
                    CampaniaID = Convert.ToInt32((CampaniaID != "") ? CampaniaID : "0"),
                    CUV = (CUV != "") ? CUV : "0"
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetTallaColorLiquidacion(entidad).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEOfertaProducto> items = lst;

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
                               id = a.ID,
                               cell = new string[]
                               {
                                   a.ID.ToString(),
                                   a.CUV,
                                   a.DescripcionCUV,
                                   a.PrecioUnitario.ToString(),
                                   a.Tipo,
                                   a.DescripcionTipo,
                                   a.DescripcionTallaColor,
                                   a.IDAux.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("AdministrarOfertasLiquidacion", "OfertaLiquidacion");
        }

        [HttpPost]
        public JsonResult RegistrarTallaColor(string Id, string Cuv, string CampaniaID, string Tipo, string Descripcion, string CUVPadre, string DescripcionCUV)
        {
            try
            {
                var entidad = new BEOfertaProducto
                {
                    ID = Convert.ToInt32(Id),
                    CUV = Cuv,
                    CUVPadre = CUVPadre,
                    Tipo = Tipo,
                    CampaniaID = Convert.ToInt32(CampaniaID),
                    PaisID = userData.PaisID,
                    DescripcionTallaColor = Descripcion,
                    UsuarioRegistro = userData.CodigoUsuario,
                    UsuarioModificacion = userData.CodigoUsuario,
                    DescripcionCUV = DescripcionCUV
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsertarTallaColorLiquidacion(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito.",
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
        public JsonResult EliminarTallaColor(string Id)
        {
            try
            {
                var entidad = new BEOfertaProducto
                {
                    ID = Convert.ToInt32(Id),
                    PaisID = userData.PaisID
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.EliminarTallaColorLiquidacion(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó con éxito.",
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
        public JsonResult GetOfertaByCUV(string CampaniaID, string CUV)
        {
            try
            {
                List<BEOfertaProducto> lst;

                var entidad = new BEOfertaProducto
                {
                    PaisID = userData.PaisID,
                    CampaniaID = Convert.ToInt32(CampaniaID),
                    CUV = CUV
                };

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.ConsultarLiquidacionByCUV(entidad).ToList();
                }

                return Json(new
                {
                    success = true,
                    data = lst[0]
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        [HttpPost]
        public JsonResult RemoverOfertaLiquidacion(OfertaProductoModel model)
        {
            try
            {
                BEOfertaProducto entidad = Mapper.Map<OfertaProductoModel, BEOfertaProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
                    sv.RemoverOfertaLiquidacion(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó la Oferta de Liquidación satisfactoriamente.",
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
        
    }
}
