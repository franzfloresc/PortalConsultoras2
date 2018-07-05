using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ShowRoomController : BaseShowRoomController
    {
        public ShowRoomController() : base()
        {

        }

        public ActionResult Intriga()
        {
            if (!ValidarIngresoShowRoom(true))
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var model = ObtenerPrimeraOfertaShowRoom();
            if (model == null) return RedirectToAction("Index", "Bienvenida");

            //model.Simbolo = userData.Simbolo;
            //model.CodigoISO = userData.CodigoISO;
            //model.Suscripcion = (configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel()).Suscripcion;
            //model.EMail = userData.EMail;
            //model.EMailActivo = userData.EMailActivo;
            //model.Celular = userData.Celular;
            //model.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
            //model.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == model.CUV) ? "block" : "none";

            return View(model);
        }

        public ActionResult Index(string query)
        {
            ViewBag.TerminoMostrar = 1;

            try
            {
                var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();
                var mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

                if (mostrarPopupIntriga) return RedirectToAction("Intriga", "ShowRoom");
                if (!ValidarIngresoShowRoom(false)) return RedirectToAction("Index", "Bienvenida");

                if (!string.IsNullOrEmpty(query))
                {
                    if (GetIsMobileDevice())
                    {
                        return RedirectToAction("Index", "ShowRoom", new { area = "Mobile", query });
                    }

                    var srQsv = new ShowRoomQueryStringValidator(query);

                    if (srQsv.CodigoConsultora != userData.CodigoConsultora && srQsv.CodigoIso != userData.CodigoISO
                        || srQsv.CodigoProceso != CodigoProceso)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }

                    if (srQsv.CampanaId == userData.CampaniaID && !_showRoomProvider.GetEventoConsultoraRecibido(userData))
                    {
                        _showRoomProvider.UpdShowRoomEventoConsultoraEmailRecibido(srQsv.CodigoConsultora, srQsv.CampanaId, userData);
                    }
                }

                var showRoomEventoModel = CargarValoresModel();
                //showRoomEventoModel.ListaShowRoomOferta = ValidarUnidadesPermitidas(showRoomEventoModel.ListaShowRoomOferta);
                //showRoomEventoModel.ListaShowRoomOferta = showRoomEventoModel.ListaShowRoomOferta ?? new List<EstrategiaPedidoModel>();
                //if (!showRoomEventoModel.ListaShowRoomOferta.Any()) return RedirectToAction("Index", "Bienvenida");
                if (!showRoomEventoModel.TieneOfertasAMostrar) return RedirectToAction("Index", "Bienvenida");

                //showRoomEventoModel.FiltersBySorting = _tablaLogicaProvider.ObtenerConfiguracion(userData.PaisID,
                //        Constantes.TablaLogica.OrdenamientoShowRoom);
                //var xlistaShowRoom = showRoomEventoModel.ListaShowRoomOferta.Where(x => !x.EsSubCampania).ToList();
                //ViewBag.PrecioMin = xlistaShowRoom.Any() ? xlistaShowRoom.Min(p => p.PrecioOferta) : Convert.ToDecimal(0);
                //ViewBag.PrecioMax = xlistaShowRoom.Any() ? xlistaShowRoom.Max(p => p.PrecioOferta) : Convert.ToDecimal(0);

                ViewBag.CloseBannerCompraPorCompra = userData.CloseBannerCompraPorCompra;
                //ViewBag.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                ViewBag.IconoLLuvia = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

                var dato = _ofertasViewProvider.ObtenerPerdioTitulo(userData.CampaniaID, IsMobile());
                showRoomEventoModel.ProductosPerdio = dato.Estado;
                showRoomEventoModel.PerdioTitulo = dato.Valor1;
                showRoomEventoModel.PerdioSubTitulo = dato.Valor2;
                showRoomEventoModel.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile());
                showRoomEventoModel.TieneCategoria = false;

                return View(showRoomEventoModel);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult CerrarBannerCompraPorCompra()
        {
            try
            {
                userData.CloseBannerCompraPorCompra = true;

                sessionManager.SetUserData(userData);

                return Json(new
                {
                    success = true,
                    message = "Ok"
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error"
                });
            }
        }

        [HttpPost]
        public JsonResult PopupCerrar()
        {
            if (configEstrategiaSR.BeShowRoomConsultora == null)
            {
                return Json(new
                {
                    success = false,
                    message = "BeShowRoomConsultora es null"
                });
            }

            configEstrategiaSR.BeShowRoomConsultora.MostrarPopup = false;
            configEstrategiaSR.BeShowRoomConsultora.MostrarPopupVenta = false;
            return Json(new
            {
                success = true,
                message = "Actualizado correctamente"
            });
        }

        [HttpPost]
        public JsonResult UpdatePopupShowRoom(bool noMostrarPopup)
        {
            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdateShowRoomConsultoraMostrarPopup(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, !noMostrarPopup);
                }

                configEstrategiaSR.CargoEntidadesShowRoom = false;
                return Json(new
                {
                    success = true,
                    message = "Actualizado correctamente",
                    data = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string cuv, string precioUnidad, string cantidad)
        {
            int unidadesPermitidas;
            int saldo;
            int cantidadPedida;

            var entidad = new BEOfertaProducto
            {
                PaisID = userData.PaisID,
                CampaniaID = userData.CampaniaID,
                CUV = cuv,
                ConsultoraID = Convert.ToInt32(userData.ConsultoraID)
            };

            using (var sv = new PedidoServiceClient())
            {
                unidadesPermitidas = sv.GetUnidadesPermitidasByCuvShowRoom(userData.PaisID, userData.CampaniaID, cuv);
                saldo = sv.ValidarUnidadesPermitidasEnPedidoShowRoom(userData.PaisID, userData.CampaniaID, cuv, userData.ConsultoraID);
                cantidadPedida = sv.CantidadPedidoByConsultoraShowRoom(entidad);
            }

            return Json(new
            {
                UnidadesPermitidas = unidadesPermitidas,
                Saldo = saldo,
                CantidadPedida = cantidadPedida,
                message = ""
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerStockActualProducto(string cuv)
        {
            int stock;

            using (var sv = new PedidoServiceClient())
            {
                stock = sv.GetStockOfertaShowRoom(userData.PaisID, userData.CampaniaID, cuv);
            }

            return Json(new
            {
                Stock = stock
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            return InsertarPedidoWebPortal(model, 1);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortalCpc(PedidoDetalleModel model)
        {
            return InsertarPedidoWebPortal(model, 2);
        }

        #region Comprar desde Pagina de Oferta

        public ActionResult DetalleOferta(int id)
        {
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var estrategiaSR = sessionManager.GetEstrategiaSR();
            var modelo = ViewDetalleOferta(id);
            modelo.EstrategiaID = id;

            //var xList = modelo.ListaOfertaShowRoom.Where(x => !x.EsSubCampania).ToList();
            //modelo.ListaOfertaShowRoom = xList;

            //var listaCompraPorCompra = GetProductosCompraPorCompra(userData.EsDiasFacturacion, estrategiaSR.BeShowRoom.EventoID,
            //            estrategiaSR.BeShowRoom.CampaniaID);
            //modelo.ListaShowRoomCompraPorCompra = listaCompraPorCompra;
            //modelo.TieneCompraXcompra = estrategiaSR.BeShowRoom.TieneCompraXcompra;

            ViewBag.ImagenFondoProductPage = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoProductPage, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
            ViewBag.IconoLLuvia = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

            return View("DetalleSet", modelo);
        }

        #endregion

        [HttpPost]
        public JsonResult CargarProductosShowRoom(BusquedaProductoModel model)
        {
            try
            {
                if (!ValidarIngresoShowRoom(false))
                    return ErrorJson(string.Empty);

                //var productosShowRoom = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, false);
                var listaOfertas = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
                var totalOfertas = listaOfertas.Count;

                if (model.ListaFiltro != null && model.ListaFiltro.Count > 0)
                {
                    var filtroCategoria = model.ListaFiltro.FirstOrDefault(p => p.Tipo == Constantes.ShowRoomTipoFiltro.Categoria);
                    if (filtroCategoria != null)
                    {
                        var arrayCategoria = filtroCategoria.Valores.ToArray();
                        listaOfertas = listaOfertas.Where(p => arrayCategoria.Contains(p.CodigoCategoria)).ToList();
                    }

                    var filtroRangoPrecio = model.ListaFiltro.FirstOrDefault(p => p.Tipo == Constantes.ShowRoomTipoFiltro.RangoPrecios);
                    if (filtroRangoPrecio != null)
                    {
                        var valorDesde = filtroRangoPrecio.Valores[0];
                        var valorHasta = filtroRangoPrecio.Valores[1];
                        listaOfertas = listaOfertas.Where(p => p.Precio2 >= Convert.ToDecimal(valorDesde)
                                     && p.Precio2 <= Convert.ToDecimal(valorHasta)).ToList();
                    }
                }

                if (model.Ordenamiento != null && model.Ordenamiento.Tipo == Constantes.ShowRoomTipoOrdenamiento.Precio)
                {
                    switch (model.Ordenamiento.Valor)
                    {
                        //case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido:
                        //    listaOfertas = listaOfertas.OrderBy(p => p.Orden).ToList();
                        //    break;
                        case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor:
                            listaOfertas = listaOfertas.OrderBy(p => p.Precio2).ToList();
                            break;
                        case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor:
                            listaOfertas = listaOfertas.OrderByDescending(p => p.Precio2).ToList();
                            break;
                            //default:
                            //    listaOfertas = listaOfertas.OrderBy(p => p.Orden).ToList();
                            //    break;
                    }
                }

                if (model.Limite > 0)
                    listaOfertas = listaOfertas.Take(model.Limite).ToList();

                //var listaSubCampania = productosShowRoom.Where(x => x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                //listaSubCampania = ValidarUnidadesPermitidas(listaSubCampania);
                var listaSubCampania = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 2);
                //listaSubCampania = ValidarUnidadesPermitidas(listaSubCampania);
                var listaOfertasPerdio = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 3);

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    listaOfertas,
                    listaSubCampania,
                    listaOfertasPerdio,
                    totalOfertas
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.CargarProductosShowRoom);
            }
        }

        [HttpPost]
        public JsonResult CargarProductosShowRoomOferta(BusquedaProductoModel model)
        {
            try
            {
                if (!ValidarIngresoShowRoom(esIntriga: false))
                    return ErrorJson(string.Empty);

                var productosShowRoom = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
                //productosShowRoom = productosShowRoom.Where(x => !x.EsSubCampania).ToList();
                var cantidadTotal = productosShowRoom.Count();

                if (model.Limite > 0 && productosShowRoom.Count > 0)
                {
                    productosShowRoom = productosShowRoom.Take(model.Limite).ToList();
                }

                var index = 0;
                productosShowRoom.Each(x =>
                {
                    x.Posicion = index++;
                    //x.UrlDetalle = Url.Action("DetalleOferta", new { id = x.EstrategiaID });
                });

                return Json(new
                {
                    success = true,
                    //message = "Ok",
                    lista = productosShowRoom,
                    campaniaId = userData.CampaniaID,
                    cantidadTotal = cantidadTotal,
                    //cantidad = cantidadTotal,
                    cantidadAMostrar = productosShowRoom.Count(),
                    codigo = Constantes.ConfiguracionPais.ShowRoom
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.CargarProductosShowRoom);
            }
        }

        [HttpPost]
        public JsonResult GetDataShowRoomIntriga()
        {
            try
            {
                const int SHOWROOM_ESTADO_INACTIVO = 0;
                const string TIPO_APLICACION_DESKTOP = "Desktop";
                var showRoom = configEstrategiaSR.BeShowRoom ?? new ShowRoomEventoModel();

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var personalizacionImagenIntriga = configEstrategiaSR
                    .ListaPersonalizacionConsultora
                    .FirstOrDefault(x => x.TipoAplicacion == TIPO_APLICACION_DESKTOP &&
                        x.Atributo == "PopupImagenIntriga");

                var imagenIntriga = "";
                if (personalizacionImagenIntriga != null)
                {
                    imagenIntriga = personalizacionImagenIntriga.Valor;
                }

                var diasFaltantes = (userData.FechaInicioCampania.AddDays(-showRoom.DiasAntes) - DateTime.Now.AddHours(userData.ZonaHoraria).Date).Days;
                var nombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre)
                    ? userData.NombreConsultora
                    : userData.Sobrenombre;
                var mensajeSaludo = string.Format("{0} prepárate para la", nombreConsultora);
                var mensajeDiasFaltantes = diasFaltantes == 1 ? "FALTA 1 DÍA" : string.Format("FALTAN {0} DÍAS", diasFaltantes);

                return Json(new
                {
                    success = true,
                    EventoId = showRoom.EventoID,
                    EventoNombre = showRoom.Nombre,
                    EventoTema = showRoom.Tema,
                    DiasFaltantes = diasFaltantes,
                    MensajeSaludo = mensajeSaludo,
                    MensajeDiasFaltantes = mensajeDiasFaltantes,
                    UrlImagenIntriga = imagenIntriga ?? string.Empty,
                    codigo = Constantes.ConfiguracionPais.ShowRoom
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
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult PopupIntriga()
        {
            try
            {
                const int SHOWROOM_ESTADO_INACTIVO = 0;
                const string TIPO_APLICACION_DESKTOP = "Desktop";

                if (!_showRoomProvider.PaisTieneShowRoom(userData.CodigoISO))
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomConsultora encontrada"
                    });
                }

                if (!configEstrategiaSR.CargoEntidadesShowRoom)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = ""
                    });
                }

                var showRoom = configEstrategiaSR.BeShowRoom ?? new ShowRoomEventoModel();

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var showRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
                var mostrarPopupIntriga = showRoomConsultora.MostrarPopup;
                var mostrarPopupVenta = showRoomConsultora.MostrarPopupVenta;

                if (!mostrarPopupIntriga && !mostrarPopupVenta)
                {
                    return Json(new
                    {
                        success = false
                    });
                }

                var personalizacionImagenIntriga = configEstrategiaSR
                    .ListaPersonalizacionConsultora
                    .FirstOrDefault(x => x.TipoAplicacion == TIPO_APLICACION_DESKTOP &&
                        x.Atributo == "PopupImagenIntriga");

                var imagenIntriga = "";
                if (personalizacionImagenIntriga != null)
                {
                    imagenIntriga = personalizacionImagenIntriga.Valor;
                }

                var diasFaltantes = (userData.FechaInicioCampania.AddDays(-showRoom.DiasAntes) - DateTime.Now.AddHours(userData.ZonaHoraria).Date).Days;
                var nombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre)
                        ? userData.NombreConsultora
                        : userData.Sobrenombre;
                var mensajeSaludo = string.Format("{0} prepárate para la", nombreConsultora);
                var mensajeDiasFaltantes = diasFaltantes == 1 ? "FALTA 1 DÍA" : string.Format("FALTAN {0} DÍAS", diasFaltantes);
                return Json(new
                {
                    success = true,
                    EventoId = showRoom.EventoID,
                    EventoNombre = showRoom.Nombre,
                    EventoTema = showRoom.Tema,
                    DiasFaltantes = diasFaltantes,
                    MensajeSaludo = mensajeSaludo,
                    MensajeDiasFaltantes = mensajeDiasFaltantes,
                    UrlImagenIntriga = imagenIntriga ?? string.Empty,
                    codigo = Constantes.ConfiguracionPais.ShowRoom
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
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult ProgramarAviso(MisDatosModel model)
        {
            try
            {
                model.EMail = Util.Trim(model.EMail);
                model.Celular = Util.Trim(model.Celular);

                if (string.IsNullOrEmpty(model.EMail))
                {
                    return Json(new
                    {
                        success = false,
                        message = "- El correo no puede ser vacio."
                    });
                }

                if (CorreoPerteneceAOtraConsultora(model))
                {
                    return Json(new
                    {
                        success = false,
                        message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                        extra = ""
                    });
                }


                userData.EMail = Util.Trim(userData.EMail);
                userData.Celular = Util.Trim(userData.EMail);

                if (model.EMail != Util.Trim(userData.EMail) ||
                    model.Celular != Util.Trim(userData.Celular))
                {
                    var usuario = ActualizarCorreoUsuario(model, userData.EMail);
                    ActualizarUserData(usuario);
                }

                if (userData.EMail != model.EMail
                    || userData.EMail == model.EMail && !userData.EMailActivo)
                {
                    EnviarConfirmacionCorreoShowRoom(model);
                }

                ProgramarAvisoShowRoom(model);

                return Json(new
                {
                    success = true,
                    message = "- Sus datos se actualizaron correctamente.\n " +
                                "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.",
                    emailValidado = userData.EMailActivo
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        [HttpGet]
        public JsonResult DesactivarBannerInferior()
        {
            sessionManager.ShowRoom.BannerInferiorConfiguracion.Activo = false;

            return Json(ResultModel<bool>.BuildOk(true), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetCarruselShowRoomExcepto(string CUVExcluido)
        {
            try
            {
                var listaOferta = new List<EstrategiaPersonalizadaProductoModel>();            

                var listaOfertasModel = _ofertaPersonalizadaProvider.ObtenerListaProductoShowRoom(userData, userData.CampaniaID, userData.CodigoConsultora, userData.EsDiasFacturacion, 1);
                listaOferta = listaOfertasModel==null ? new List<EstrategiaPersonalizadaProductoModel>():listaOfertasModel.Where(x => x.CUV2 != CUVExcluido).ToList();

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    data = listaOferta
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.CargarProductosShowRoom);
            }
        }

        #region Metodos Privados

        private JsonResult InsertarPedidoWebPortal(PedidoDetalleModel model, int tipo)
        {
            try
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

                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);

                entidad.PaisID = userData.PaisID;
                entidad.ConsultoraID = userData.ConsultoraID;
                entidad.CampaniaID = userData.CampaniaID;
                if (tipo == 1)
                {
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.TipoEstrategiaID = model.ConfiguracionOfertaID;
                }
                else if (tipo == 2)
                {
                    entidad.TipoOfertaSisID = 0;
                    entidad.OfertaWeb = false;
                    entidad.ConfiguracionOfertaID = 0;
                    entidad.SubTipoOfertaSisID = 0;
                    entidad.EsSugerido = false;
                    entidad.EsKitNueva = false;
                    entidad.EsCompraPorCompra = true;
                }
                entidad.IPUsuario = userData.IPUsuario;

                entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

                using (var sv = new PedidoServiceClient())
                {
                    sv.InsPedidoWebDetalleOferta(entidad);
                }

                sessionManager.SetPedidoWeb(null);
                sessionManager.SetDetallesPedido(null);
                sessionManager.SetDetallesPedidoSetAgrupado(null);

                UpdPedidoWebMontosPROL();

                var indPedidoAutentico = new BEIndicadorPedidoAutentico
                {
                    PedidoID = entidad.PedidoID,
                    CampaniaID = entidad.CampaniaID,
                    PedidoDetalleID = entidad.PedidoDetalleID,
                    IndicadorIPUsuario = GetIPCliente(),
                    IndicadorFingerprint = "",
                    IndicadorToken = Session["TokenPedidoAutentico"] != null
                        ? Session["TokenPedidoAutentico"].ToString()
                        : ""
                };

                InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);


                if (tipo == 1)
                {


                    using (var pedidoServiceClient = new PedidoServiceClient())
                    {
                        pedidoServiceClient.InsertPedidoWebSet(userData.PaisID, userData.CampaniaID, userData.PedidoID, model.Cantidad.ToInt(), model.CUV
                            , userData.ConsultoraID, "", string.Format("{0}:1", model.CUV), 0);
                    }
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

        private bool CorreoPerteneceAOtraConsultora(MisDatosModel model)
        {
            int cantidad;
            using (var svr = new UsuarioServiceClient())
            {
                cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.EMail, userData.CodigoUsuario);
            }
            var correoRegistrado = cantidad > 0;
            return correoRegistrado;
        }

        private ServiceUsuario.BEUsuario ActualizarCorreoUsuario(MisDatosModel model, string correoAnterior)
        {
            var entidad = Mapper.Map<MisDatosModel, ServiceUsuario.BEUsuario>(model);

            entidad.CodigoUsuario = userData.CodigoUsuario;
            entidad.Telefono = userData.Telefono;
            entidad.TelefonoTrabajo = userData.TelefonoTrabajo;
            entidad.Sobrenombre = userData.Sobrenombre;
            entidad.ZonaID = userData.ZonaID;
            entidad.RegionID = userData.RegionID;
            entidad.ConsultoraID = userData.ConsultoraID;
            entidad.PaisID = userData.PaisID;

            using (var sv = new UsuarioServiceClient())
            {
                sv.UpdateDatos(entidad, correoAnterior);
            }

            return entidad;
        }

        private void ActualizarUserData(ServiceUsuario.BEUsuario usuario)
        {
            userData.EMailActivo = usuario.EMail == userData.EMail && userData.EMailActivo;
            userData.EMail = usuario.EMail;
            userData.Celular = usuario.Celular;
            sessionManager.SetUserData(userData);
        }

        private void EnviarConfirmacionCorreoShowRoom(MisDatosModel model)
        {
            const string UTM_NOMBRE_EVENTO = "{{NOMBRE_EVENTO}}";
            var parametros = new[] {
                        userData.CodigoUsuario,
                        userData.PaisID.ToString(),
                        userData.CodigoISO,
                        model.EMail,
                        "UrlReturn,sr"
                    };

            var paramQuerystring = Util.Encrypt(string.Join(";", parametros));

            var esPaisEsika = WebConfig.PaisesEsika.Contains(userData.CodigoISO);

            var cadena = MailUtilities.CuerpoMensajePersonalizado(
                Util.GetUrlHost(HttpContext.Request).ToString(),
                userData.Sobrenombre,
                paramQuerystring,
                esPaisEsika);

            if (model.EnviarParametrosUTMs)
            {
                var nombreEvento = configEstrategiaSR.BeShowRoom != null && configEstrategiaSR.BeShowRoom.Nombre != null ?
                    configEstrategiaSR.BeShowRoom.Nombre.Replace(" ", "") :
                    string.Empty;
                var utms = model.CadenaParametrosUTMs.Replace(UTM_NOMBRE_EVENTO, nombreEvento);
                cadena = cadena.Replace(".aspx?", ".aspx?" + utms + "&");
            }

            Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", model.EMail, "Confirmación de Correo", cadena, true, userData.NombreConsultora);
        }

        private void ProgramarAvisoShowRoom(MisDatosModel model)
        {
            configEstrategiaSR.BeShowRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
            configEstrategiaSR.BeShowRoomConsultora.Suscripcion = true;
            configEstrategiaSR.BeShowRoomConsultora.CorreoEnvioAviso = model.EMail;
            configEstrategiaSR.BeShowRoomConsultora.CampaniaID = userData.CampaniaID;
            configEstrategiaSR.BeShowRoomConsultora.CodigoConsultora = userData.CodigoConsultora;
            _showRoomProvider.ShowRoomProgramarAviso(userData.PaisID, configEstrategiaSR.BeShowRoomConsultora);
        }

        //private List<EstrategiaPedidoModel> ValidarUnidadesPermitidas(List<EstrategiaPedidoModel> listaShowRoomOferta)
        //{
        //    if (listaShowRoomOferta != null)
        //    {
        //        var detalle = new List<BEPedidoWebDetalle>();
        //        if (sessionManager.GetDetallesPedido() != null)
        //            detalle = sessionManager.GetDetallesPedido();
        //        if (detalle.Count > 0)
        //        {
        //            for (var i = 0; i <= listaShowRoomOferta.Count - 1; i++)
        //            {
        //                var item = listaShowRoomOferta[i];
        //                item.UnidadesPermitidasRestantes = item.UnidadesPermitidas;
        //                if (item.EsSubCampania)
        //                {
        //                    int cantidad = detalle.Where(x => x.CUV == item.CUV).Sum(x => x.Cantidad).ToInt();
        //                    item.UnidadesPermitidasRestantes = item.UnidadesPermitidas - cantidad;
        //                }
        //            }
        //        }
        //    }
        //    return listaShowRoomOferta;
        //}

        #endregion

    }
}
