using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.MagickNet;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
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
        #region Visualización de Pedidos Liquidación

        public ActionResult OfertasLiquidacion()
        {
            if (userData.CodigoISO == "VE")
                return RedirectToAction("Index", "Bienvenida");
            try
            {
                ViewBag.CampaniaID = userData.CampaniaID.ToString();
                ViewBag.ISO = userData.CodigoISO.ToString();
                ViewBag.Simbolo = userData.Simbolo.ToString().Trim();
                BEConfiguracionCampania oBEConfiguracionCampania = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionCampania = sv.GetEstadoPedido(userData.PaisID, userData.CampaniaID, userData.ConsultoraID, userData.ZonaID, userData.RegionID);
                }
                if (oBEConfiguracionCampania != null)
                    ValidarStatusCampania(oBEConfiguracionCampania);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View("OfertasLiquidacion");
        }

        public string GetDescripcionMarca(int MarcaID)
        {
            string result = string.Empty;

            switch (MarcaID)
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

        private void ValidarStatusCampania(BEConfiguracionCampania oBEConfiguracionCampania)
        {
            UsuarioModel usuario = userData;
            usuario.ZonaValida = oBEConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = oBEConfiguracionCampania.FechaInicioFacturacion;

            usuario.FechaFinCampania = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(oBEConfiguracionCampania.DiasDuracionCronograma - 1);

            usuario.HoraInicioReserva = oBEConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = oBEConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = oBEConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = oBEConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = oBEConfiguracionCampania.DiasAntes;
            usuario.NombreCorto = oBEConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = oBEConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = oBEConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = oBEConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = oBEConfiguracionCampania.HoraCierreZonaNormal;

            if (DateTime.Now.AddHours(oBEConfiguracionCampania.ZonaHoraria) < oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraFin;
            }
            SetUserData(usuario);
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
                ViewBag.Simbolo = userData.Simbolo.ToString().Trim();

                if (lst != null && lst.Count > 0)
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
                        item.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, item.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO);                                                
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
                int Cantidad = sv.ObtenerMaximoItemsaMostrarLiquidacion(userData.PaisID);
                lst = sv.GetOfertaProductosPortal(userData.PaisID, Constantes.ConfiguracionOferta.Liquidacion, 1, userData.CampaniaID).Take(Cantidad).ToList();
            }

            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
            }

            return Mapper.Map<IList<BEOfertaProducto>, List<OfertaProductoModel>>(lst);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            var mensaje = "";
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
                }

                UpdPedidoWebMontosPROL();

                    BEIndicadorPedidoAutentico indPedidoAutentico = new BEIndicadorPedidoAutentico();
                    indPedidoAutentico.PedidoID = entidad.PedidoID;
                    indPedidoAutentico.CampaniaID = entidad.CampaniaID;
                    indPedidoAutentico.PedidoDetalleID = entidad.PedidoDetalleID;
                    indPedidoAutentico.IndicadorIPUsuario = GetIPCliente();
                    indPedidoAutentico.IndicadorFingerprint = "";
                    indPedidoAutentico.IndicadorToken = (Session["TokenPedidoAutentico"] != null) ? Session["TokenPedidoAutentico"].ToString() : "";

                    InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);

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
            int Stock = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Stock = sv.GetStockOfertaProductoLiquidacion(userData.PaisID, userData.CampaniaID, CUV);
            }

            return Json(new
            {
                Stock = Stock
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
                    int Stock = 0;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        Stock = sv.GetStockOfertaProductoLiquidacion(userData.PaisID, userData.CampaniaID, Lista[i].CUV);
                    }

                    if (Lista[i].Stock > Stock)
                        txtBuil.Append("- El stock para el CUV <b>" + Lista[i].CUV + "</b> es <b>" + Stock + "</b> unidades deberá validar la cantidad nuevamente.\n");
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
            int UnidadesPermitidas = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                UnidadesPermitidas = sv.GetUnidadesPermitidasByCuv(userData.PaisID, userData.CampaniaID, CUV);
            }

            return Json(new
            {
                UnidadesPermitidas = UnidadesPermitidas
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV, string Cantidad, string PrecioUnidad)
        {
            bool resul = false;
            string mensaje = ValidarMontoMaximo(Convert.ToDecimal(PrecioUnidad), Convert.ToInt32(Cantidad), out resul);

            int UnidadesPermitidas = 0;
            int Saldo = 0;
            int CantidadPedida = 0;
            var entidad = new BEOfertaProducto();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.CUV = CUV;
            entidad.ConsultoraID = Convert.ToInt32(userData.ConsultoraID);

            if (mensaje == "" || resul)
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    UnidadesPermitidas = sv.GetUnidadesPermitidasByCuv(userData.PaisID, userData.CampaniaID, CUV);
                    Saldo = sv.ValidarUnidadesPermitidasEnPedido(userData.PaisID, userData.CampaniaID, CUV, userData.ConsultoraID);
                    CantidadPedida = sv.CantidadPedidoByConsultora(entidad);
                }
            }

            return Json(new
            {
                UnidadesPermitidas = UnidadesPermitidas,
                Saldo = Saldo,
                CantidadPedida = CantidadPedida,
                message = mensaje,
                result = resul
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCantidadMaximaPorPais(int paisID)
        {
            int Cantidad = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Cantidad = sv.ObtenerMaximoItemsaMostrarLiquidacion(paisID);
            }

            return Json(new
            {
                Cantidad = Cantidad
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
                ExpValidacionNemotecnico = GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico)
            };
            return View(cronogramaModel);
        }

        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (userData.RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(userData.PaisID));
                }

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

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisID)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisID, Constantes.ConfiguracionOferta.Liquidacion).ToList();
                lst = lstConfiguracion;
            }

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ConfiguracionOfertaModel> lstConfig = DropDowListConfiguracion(PaisID);
            string habilitarNemotecnico = ObtenerValorTablaLogica(PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.BusquedaNemotecnicoOfertaLiquidacion);

            return Json(new
            {
                lista = lst,
                lstConfig = lstConfig,
                habilitarNemotecnico = habilitarNemotecnico == "1"
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult ObtenerOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            int Orden = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Orden = sv.GetOrdenPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID);
            }

            return Json(new
            {
                Orden = Orden
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ValidarPriorizacion(int paisID, string codigoOferta, int CampaniaID, int Orden)
        {
            int FlagExiste = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                FlagExiste = sv.ValidarPriorizacion(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = FlagExiste
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

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
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
                string ISO = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;
                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + ISO));
                lst.Update(x => x.ISOPais = ISO);
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
                                   a.TipoOferta.ToString(),
                                   a.CodigoProducto.ToString(),
                                   a.CodigoCampania.ToString(),
                                   a.CUV.ToString(),
                                   a.Descripcion.ToString(),
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.Orden.ToString(),
                                   a.Stock.ToString(),
                                   a.StockInicial.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.ImagenProducto.ToString(),
                                   a.CampaniaID.ToString() ,
                                   a.Stock.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaProductoID.ToString(),
                                   a.CodigoTipoOferta.ToString().Trim(),
                                   a.ISOPais.ToString(),
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.CodigoProducto.ToString()
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

                    var listaImagenesResize = ObtenerListaImagenesResize(rutaImagenCompleta);
                    if (listaImagenesResize != null && listaImagenesResize.Count > 0)
                        mensajeErrorImagenResize = MagickNetLibrary.GuardarImagenesResize(listaImagenesResize);

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

                    var listaImagenesResize = ObtenerListaImagenesResize(rutaImagenCompleta);
                    if (listaImagenesResize != null && listaImagenesResize.Count > 0)
                        mensajeErrorImagenResize = MagickNetLibrary.GuardarImagenesResize(listaImagenesResize);

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
                    entidad.UsuarioModificacion = userData.CodigoConsultora.ToString();
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
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEOfertaProducto> lstStock = new List<BEOfertaProducto>();

                if (flStock != null)
                {
                    string fileName = Path.GetFileName(flStock.FileName);
                    string pathBanner = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    finalPath = Path.Combine(pathBanner, fileName);
                    flStock.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                if (IsNumeric(values[1].ToString().Trim()) && IsNumeric(values[3].ToString().Trim()))
                                {
                                    BEOfertaProducto ent = new BEOfertaProducto();
                                    ent.ISOPais = values[0].ToString().Trim();
                                    ent.CampaniaID = int.Parse(values[1].ToString());
                                    ent.CUV = values[2].ToString().Trim();
                                    ent.Stock = int.Parse(values[3].ToString().Trim());
                                    if (ent.Stock >= 0)
                                        lstStock.Add(ent);
                                }
                            }
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
                                int paisID = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisID > 0)
                                {
                                    try
                                    {
                                        registros += sv.UpdOfertaProductoStockMasivo(paisID, lstStockTemporal.ToArray());

                                        #region Log de Cargas de Stock
                                        using (PedidoServiceClient srv = new PedidoServiceClient())
                                        {
                                            BEStockCargaLog ent = new BEStockCargaLog();
                                            ent.CantidadRegistros = registros;
                                            ent.PaisID = paisID;
                                            ent.TipoOfertaSisID = Constantes.ConfiguracionOferta.Liquidacion;
                                            ent.UsuarioRegistro = userData.CodigoConsultora;
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
                    entidad.UsuarioModificacion = userData.CodigoConsultora.ToString();
                    entidad.UsuarioRegistro = userData.CodigoConsultora.ToString();
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

        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;

            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
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
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Tipo Oferta", "TipoOferta");
            dic.Add("Código SAP", "CodigoProducto");
            dic.Add("Campaña", "CodigoCampania");
            dic.Add("CUV", "CUV");
            dic.Add("Descripción", "Descripcion");
            dic.Add("Precio Oferta", "PrecioOferta");
            dic.Add("Priorización", "Orden");
            dic.Add("Stock", "Stock");
            dic.Add("Stock Inicial", "StockInicial");
            dic.Add("UnidadesPermitidas", "UnidadesPermitidas");
            Util.ExportToExcel("ProductosLiquidacion", lst, dic);
            return View();
        }

        [HttpGet]
        public ActionResult ConsultarTallaColor(string sidx, string sord, int page, int rows, string CampaniaID, string CUV)
        {
            if (ModelState.IsValid)
            {
                List<BEOfertaProducto> lst;

                var entidad = new BEOfertaProducto();
                entidad.PaisID = userData.PaisID;
                entidad.CampaniaID = Convert.ToInt32((CampaniaID != "") ? CampaniaID : "0");
                entidad.CUV = (CUV != "") ? CUV : "0";

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetTallaColorLiquidacion(entidad).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
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
                                   a.CUV.ToString(),
                                   a.DescripcionCUV.ToString(),
                                   a.PrecioUnitario.ToString(),
                                   a.Tipo.ToString(),
                                   a.DescripcionTipo.ToString(),
                                   a.DescripcionTallaColor.ToString(),
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
                var entidad = new BEOfertaProducto();
                entidad.ID = Convert.ToInt32(Id);
                entidad.CUV = Cuv;
                entidad.CUVPadre = CUVPadre;
                entidad.Tipo = Tipo;
                entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                entidad.PaisID = userData.PaisID;
                entidad.DescripcionTallaColor = Descripcion;
                entidad.UsuarioRegistro = userData.CodigoUsuario;
                entidad.UsuarioModificacion = userData.CodigoUsuario;
                entidad.DescripcionCUV = DescripcionCUV;

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
                var entidad = new BEOfertaProducto();
                entidad.ID = Convert.ToInt32(Id);
                entidad.PaisID = userData.PaisID;

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

                var entidad = new BEOfertaProducto();
                entidad.PaisID = userData.PaisID;
                entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                entidad.CUV = CUV;

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
                    message = ex.Message.ToString(),
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
                    entidad.UsuarioModificacion = userData.CodigoConsultora.ToString();
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

        #region CargaMasivaImagenes

        public JsonResult CargaMasivaImagenes(int campaniaId)
        {
            try
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                var lista = new List<BECargaMasivaImagenes>();

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    lista = ps.GetListaImagenesOfertaLiquidacionByCampania(userData.PaisID, campaniaId).ToList();
                }
                //lista = lista.Take(5).ToList();
                var cantidadImagenesGeneradas = 0;
                var cuvNoGenerados = "";
                var cuvNoExistentes = "";

                foreach (var item in lista)
                {
                    var rutaImagenCompleta = ConfigS3.GetUrlFileS3(carpetaPais, item.RutaImagen);
                    var mensajeError = "";
                    var listaImagenesResize = ObtenerListaImagenesResize(rutaImagenCompleta);
                    if (listaImagenesResize != null && listaImagenesResize.Count > 0)
                        mensajeError = MagickNetLibrary.GuardarImagenesResize(listaImagenesResize);
                    else
                        cuvNoExistentes += item.Cuv + ",";

                    if (mensajeError == "")
                        cantidadImagenesGeneradas++;
                    else
                        cuvNoGenerados += item.Cuv + ",";
                }

                var mensaje = "Se generaron las imagenes SMALL y MEDIUM de todas las imagenes.";
                if (cuvNoGenerados != "")
                {
                    mensaje += " Excepto los siguientes Cuvs: " + cuvNoGenerados;
                }
                if (cuvNoExistentes != "")
                {
                    mensaje += " Excepto los siguientes Cuvs (imagen orignal no encontrada o ya existen): " + cuvNoExistentes;
                }

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    extra = ""
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
    }
}
