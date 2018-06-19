using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ShowRoomController : BaseShowRoomController
    {
        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();
        private static readonly string CodigoProceso = ConfigurationManager.AppSettings["EmailCodigoProceso"];
        private int _ofertaId;
        private bool _blnRecibido;
        private readonly ISessionManager _sessionManager;
        protected Models.Estrategia.ShowRoom.ConfigModel configEstrategiaSR;

        public ShowRoomController()
        {
            _sessionManager = SessionManager.SessionManager.Instance;
            configEstrategiaSR = sessionManager.GetEstrategiaSR() ?? new Models.Estrategia.ShowRoom.ConfigModel();
        }

        public ActionResult Intriga()
        {
            if (!ValidarIngresoShowRoom(true))
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var ofertasShowRoom = ObtenerOfertasShowRoom();

            if (!ofertasShowRoom.Any())
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            ActualizarUrlImagenes(ofertasShowRoom);

            var model = ObtenerPrimeraOfertaShowRoom(ofertasShowRoom);
            model.Simbolo = userData.Simbolo;
            model.CodigoISO = userData.CodigoISO;
            model.Suscripcion = (configEstrategiaSR.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora()).Suscripcion;
            model.EMail = userData.EMail;
            model.EMailActivo = userData.EMailActivo;
            model.Celular = userData.Celular;
            model.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
            model.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == model.CUV) ? "block" : "none";

            InicializarViewbag();

            return View(model);
        }

        private void InicializarViewbag()
        {
            ViewBag.urlImagenPopupIntriga = string.Empty;
            ViewBag.urlTerminosyCondiciones = string.Empty;
            configEstrategiaSR.ListaPersonalizacionConsultora = configEstrategiaSR.ListaPersonalizacionConsultora ?? new List<ShowRoomPersonalizacionModel>();
            var personalizacionesDesktop = configEstrategiaSR.ListaPersonalizacionConsultora.Where(x => x.TipoAplicacion == "Desktop").ToList();
            foreach (var item in personalizacionesDesktop)
            {
                switch (item.Atributo)
                {
                    case Constantes.ShowRoomPersonalizacion.Desktop.BannerImagenIntriga:
                        ViewBag.urlImagenPopupIntriga = item.Valor;
                        break;
                    case Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones:
                        ViewBag.urlTerminosyCondiciones = item.Valor;
                        break;
                }
            }
        }

        public ActionResult Index(string query)
        {
            ViewBag.TerminoMostrar = 1;

            try
            {
                var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

                var mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

                if (mostrarPopupIntriga)
                {
                    return RedirectToAction("Intriga", "ShowRoom");
                }
                if (!ValidarIngresoShowRoom(false))
                    return RedirectToAction("Index", "Bienvenida");

                if (query != null)
                {
                    if (Request.Browser.IsMobileDevice)
                    {
                        return RedirectToAction("Index", "ShowRoom", new { area = "Mobile", query });
                    }

                    var param = Util.Decrypt(query);
                    var lista = param.Split(';');

                    if (lista[2] != userData.CodigoConsultora && lista[1] != userData.CodigoISO)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }

                    if (lista[0] == CodigoProceso)
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            _blnRecibido = Convert.ToBoolean(sv.GetEventoConsultoraRecibido(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID));
                        }

                        if (Convert.ToInt32(lista[3]) == userData.CampaniaID && !_blnRecibido)
                        {
                            var entidad = new BEShowRoomEventoConsultora
                            {
                                CodigoConsultora = lista[2],
                                CampaniaID = Convert.ToInt32(lista[3])
                            };

                            using (var sv = new PedidoServiceClient())
                            {
                                sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, entidad);
                            }
                        }
                    }
                    else
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }
                }

                var showRoomEventoModel = CargarValoresModel();
                showRoomEventoModel.ListaShowRoomOferta = ValidarUnidadesPermitidas(showRoomEventoModel.ListaShowRoomOferta);
                showRoomEventoModel.ListaShowRoomOferta = showRoomEventoModel.ListaShowRoomOferta ?? new List<ShowRoomOfertaModel>();
                if (!showRoomEventoModel.ListaShowRoomOferta.Any())
                    return RedirectToAction("Index", "Bienvenida");

                using (var svc = new SACServiceClient())
                {
                    showRoomEventoModel.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
                }

                var xlistaShowRoom = showRoomEventoModel.ListaShowRoomOferta.Where(x => !x.EsSubCampania).ToList();
                ViewBag.PrecioMin = xlistaShowRoom.Any() ? xlistaShowRoom.Min(p => p.PrecioOferta) : Convert.ToDecimal(0);
                ViewBag.PrecioMax = xlistaShowRoom.Any() ? xlistaShowRoom.Max(p => p.PrecioOferta) : Convert.ToDecimal(0);

                ViewBag.CloseBannerCompraPorCompra = userData.CloseBannerCompraPorCompra;

                ViewBag.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                ViewBag.IconoLLuvia = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

                //21-may-2018
                var dato = ObtenerPerdio(userData.CampaniaID);
                showRoomEventoModel.ProductosPerdio = dato.Estado;
                showRoomEventoModel.PerdioTitulo = dato.Valor1;
                showRoomEventoModel.PerdioSubTitulo = dato.Valor2;
                showRoomEventoModel.MensajeProductoBloqueado = MensajeProductoBloqueado();

                return View(showRoomEventoModel);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Personalizado(string query)
        {
            ViewBag.TerminoMostrar = 1;

            try
            {
                if (!(sessionManager.GetEsShowRoom() && userData.CodigoISO == Constantes.CodigosISOPais.Peru))
                {
                    return RedirectToAction("Index");
                }

                var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

                var mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

                if (mostrarPopupIntriga)
                {
                    return RedirectToAction("Intriga", "ShowRoom");
                }
                if (!ValidarIngresoShowRoom(false))
                    return RedirectToAction("Index", "Bienvenida");

                if (query != null)
                {
                    if (Request.Browser.IsMobileDevice)
                    {
                        return RedirectToAction("Index", "ShowRoom", new { area = "Mobile", query });
                    }

                    var param = Util.Decrypt(query);
                    var lista = param.Split(';');

                    if (lista[2] != userData.CodigoConsultora && lista[1] != userData.CodigoISO)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }

                    if (lista[0] == CodigoProceso)
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            _blnRecibido = Convert.ToBoolean(sv.GetEventoConsultoraRecibido(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID));
                        }

                        if (Convert.ToInt32(lista[3]) == userData.CampaniaID && !_blnRecibido)
                        {
                            var entidad = new BEShowRoomEventoConsultora
                            {
                                CodigoConsultora = lista[2],
                                CampaniaID = Convert.ToInt32(lista[3])
                            };

                            using (var sv = new PedidoServiceClient())
                            {
                                sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, entidad);
                            }
                        }
                    }
                    else
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }
                }

                var showRoomEventoModel = CargarValoresModel();
                showRoomEventoModel.ListaShowRoomOferta = ValidarUnidadesPermitidas(showRoomEventoModel.ListaShowRoomOferta);
                showRoomEventoModel.ListaShowRoomOferta = showRoomEventoModel.ListaShowRoomOferta ?? new List<ShowRoomOfertaModel>();
                if (!showRoomEventoModel.ListaShowRoomOferta.Any())
                    return RedirectToAction("Index", "Bienvenida");

                using (var svc = new SACServiceClient())
                {
                    showRoomEventoModel.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
                }

                var xlistaShowRoom = showRoomEventoModel.ListaShowRoomOferta.Where(x => !x.EsSubCampania).ToList();
                ViewBag.PrecioMin = xlistaShowRoom.Any() ? xlistaShowRoom.Min(p => p.PrecioOferta) : Convert.ToDecimal(0);
                ViewBag.PrecioMax = xlistaShowRoom.Any() ? xlistaShowRoom.Max(p => p.PrecioOferta) : Convert.ToDecimal(0);

                ViewBag.CloseBannerCompraPorCompra = userData.CloseBannerCompraPorCompra;

                ViewBag.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                ViewBag.IconoLLuvia = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

                return View(showRoomEventoModel);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult AdministrarShowRoom()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ShowRoom/AdministrarShowRoom"))
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
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
        }

        public JsonResult ObtenterCampaniasPorPais(int paisId)
        {
            var lst = DropDowListCampanias(paisId);

            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerParametroPersonalizacion(int paisId)
        {
            List<BETablaLogicaDatos> datos;
            using (var svc = new SACServiceClient())
            {
                datos = svc.GetTablaLogicaDatos(paisId, Constantes.TablaLogica.Plan20).ToList();
            }

            var campaniaMinimaPersonalizacion = "";
            if (datos.Any())
            {
                var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == Constantes.TablaLogicaDato.PersonalizacionShowroom);
                if (par != null)
                {
                    campaniaMinimaPersonalizacion = par.Codigo;
                }
            }

            return Json(new
            {
                campaniaMinimaPersonalizacion
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ConsultarShowRoom(string sidx, string sord, int page, int rows, int paisId, int campaniaId)
        {
            try
            {
                BEShowRoomEvento showRoomEvento;
                var listaShowRoomEvento = new List<BEShowRoomEvento>();

                using (var sv = new PedidoServiceClient())
                {
                    showRoomEvento = sv.GetShowRoomEventoByCampaniaID(userData.PaisID, campaniaId);
                }

                if (showRoomEvento != null)
                {
                    var iso = Util.GetPaisISO(paisId);
                    var carpetaPais = Globals.UrlMatriz + "/" + iso;

                    showRoomEvento.Imagen1 = string.IsNullOrEmpty(showRoomEvento.Imagen1)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.Imagen1, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    showRoomEvento.Imagen2 = string.IsNullOrEmpty(showRoomEvento.Imagen2)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.Imagen2, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    showRoomEvento.ImagenCabeceraProducto = string.IsNullOrEmpty(showRoomEvento.ImagenCabeceraProducto)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.ImagenCabeceraProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    showRoomEvento.ImagenVentaSetPopup = string.IsNullOrEmpty(showRoomEvento.ImagenVentaSetPopup)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.ImagenVentaSetPopup, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    showRoomEvento.ImagenVentaTagLateral = string.IsNullOrEmpty(showRoomEvento.ImagenVentaTagLateral)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.ImagenVentaTagLateral, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    showRoomEvento.ImagenPestaniaShowRoom = string.IsNullOrEmpty(showRoomEvento.ImagenPestaniaShowRoom)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.ImagenPestaniaShowRoom, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    showRoomEvento.ImagenPreventaDigital = string.IsNullOrEmpty(showRoomEvento.ImagenPreventaDigital)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.ImagenPreventaDigital, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                    listaShowRoomEvento.Add(showRoomEvento);
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEShowRoomEvento> items = listaShowRoomEvento;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "EventoID":
                            items = listaShowRoomEvento.OrderBy(x => x.EventoID);
                            break;
                        case "Nombre":
                            items = listaShowRoomEvento.OrderBy(x => x.Nombre);
                            break;
                        case "Tema":
                            items = listaShowRoomEvento.OrderBy(x => x.Tema);
                            break;
                        case "DiasAntes":
                            items = listaShowRoomEvento.OrderBy(x => x.DiasAntes);
                            break;
                        case "DiasDespues":
                            items = listaShowRoomEvento.OrderBy(x => x.DiasDespues);
                            break;
                        case "NumeroPerfiles":
                            items = listaShowRoomEvento.OrderBy(x => x.NumeroPerfiles);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "EventoID":
                            items = listaShowRoomEvento.OrderByDescending(x => x.EventoID);
                            break;
                        case "Nombre":
                            items = listaShowRoomEvento.OrderByDescending(x => x.Nombre);
                            break;
                        case "Tema":
                            items = listaShowRoomEvento.OrderByDescending(x => x.Tema);
                            break;
                        case "DiasAntes":
                            items = listaShowRoomEvento.OrderByDescending(x => x.DiasAntes);
                            break;
                        case "DiasDespues":
                            items = listaShowRoomEvento.OrderByDescending(x => x.DiasDespues);
                            break;
                        case "NumeroPerfiles":
                            items = listaShowRoomEvento.OrderByDescending(x => x.NumeroPerfiles);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, listaShowRoomEvento);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.EventoID,
                               a.Nombre,
                               a.Tema,
                               DiasAntes = a.DiasAntes.ToString(),
                               DiasDespues = a.DiasDespues.ToString(),
                               NumeroPerfiles = a.NumeroPerfiles.ToString(),
                               a.Imagen1,
                               a.Imagen2,
                               a.ImagenCabeceraProducto,
                               a.ImagenVentaSetPopup,
                               a.ImagenVentaTagLateral,
                               a.ImagenPestaniaShowRoom,
                               a.ImagenPreventaDigital,
                               CampaniaID = a.CampaniaID.ToString(),
                               Descuento = a.Descuento.ToString(),
                               a.TextoEstrategia,
                               OfertaEstrategia = a.OfertaEstrategia.ToString(),
                               Estado = a.Estado.ToString(),
                               TieneCategoria = a.TieneCategoria.ToString(),
                               TieneCompraXcompra = a.TieneCompraXcompra.ToString(),
                               TieneSubCampania = a.TieneSubCampania.ToString(),
                               TienePersonalizacion = a.TienePersonalizacion
                           }
                };

                return Json(data, JsonRequestBehavior.AllowGet);
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

        [HttpPost]
        public JsonResult GetShowRoomNiveles()
        {
            try
            {

                var listaShowRoomNivel = configEstrategiaSR.ListaNivel ?? new List<BEShowRoomNivel>();

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaShowRoomNivel
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

        [HttpPost]
        public JsonResult GetShowRoomCategorias(int eventoId)
        {
            try
            {
                List<BEShowRoomCategoria> listaCategorias;

                using (var ps = new PedidoServiceClient())
                {
                    listaCategorias = ps.GetShowRoomCategorias(userData.PaisID, eventoId).ToList();
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaCategorias
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

        [HttpPost]
        public JsonResult GetShowRoomPerfiles(int paisId, int eventoId)
        {
            try
            {
                List<BEShowRoomPerfil> listaShowRoomPerfil;
                using (var sv = new PedidoServiceClient())
                {
                    listaShowRoomPerfil = sv.GetShowRoomPerfiles(paisId, eventoId).ToList();
                }

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaShowRoomPerfil
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

        public JsonResult GuardarShowRoom(ShowRoomEventoModel showRoomEventoModel)
        {
            try
            {
                BEShowRoomEvento beShowRoomEvento = Mapper.Map<ShowRoomEventoModel, BEShowRoomEvento>(showRoomEventoModel);

                if (beShowRoomEvento.EventoID == 0)
                {
                    int idEventoNuevo;
                    beShowRoomEvento.UsuarioCreacion = userData.CodigoConsultora;
                    using (var sv = new PedidoServiceClient())
                    {
                        idEventoNuevo = sv.InsertShowRoomEvento(userData.PaisID, beShowRoomEvento);
                    }

                    return Json(new
                    {
                        success = true,
                        message = "ShowRoom Agregado correctamente",
                        data = idEventoNuevo
                    });
                }

                beShowRoomEvento.UsuarioModificacion = userData.CodigoConsultora;
                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdateShowRoomEvento(userData.PaisID, beShowRoomEvento);
                }

                return Json(new
                {
                    success = true,
                    message = "ShowRoom Modificado correctamente",
                    data = beShowRoomEvento.EventoID
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

        [HttpPost]
        public JsonResult DeshabilitarShowRoomEvento(int campaniaId, int eventoId)
        {
            try
            {
                var beShowRoomEvento = new BEShowRoomEvento
                {
                    UsuarioModificacion = userData.CodigoConsultora,
                    CampaniaID = campaniaId,
                    EventoID = eventoId
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.DeshabilitarShowRoomEvento(userData.PaisID, beShowRoomEvento);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito el Evento ShowRoom satisfactoriamente.",
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
        public JsonResult EliminarShowRoomEvento(int campaniaId, int eventoId)
        {
            try
            {
                var beShowRoomEvento = new BEShowRoomEvento
                {
                    CampaniaID = campaniaId,
                    EventoID = eventoId
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarShowRoomEvento(userData.PaisID, beShowRoomEvento);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino el Evento ShowRoom satisfactoriamente.",
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
        public JsonResult GuardarImagenShowRoom(int eventoId, string nombreImagen, string nombreImagenAnterior, int tipo)
        {
            string nombreImagenFinal = "";

            try
            {
                string tempImage01 = nombreImagen ?? "";
                nombreImagen = nombreImagen ?? "";
                nombreImagenAnterior = nombreImagenAnterior ?? "";

                string soloImagen = nombreImagen.Split('.')[0];
                string soloExtension = nombreImagen.Split('.')[1];

                string iso = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + iso;

                bool esNuevo = nombreImagenAnterior == "";

                if (nombreImagen != nombreImagenAnterior)
                {
                    string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() +
                                  DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                    var newfilename = iso + "_" + soloImagen + "_" + time + "_" + "01" + "_" +
                                      FileManager.RandomString() + "." + soloExtension;

                    nombreImagenFinal = newfilename;

                    if (!esNuevo) ConfigS3.DeleteFileS3(carpetaPais, nombreImagenAnterior);
                    ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage01), carpetaPais, newfilename);
                }

                using (var sv = new PedidoServiceClient())
                {
                    sv.GuardarImagenShowRoom(userData.PaisID, eventoId, nombreImagenFinal, tipo,
                        userData.CodigoConsultora);
                }

                return Json(new
                {
                    success = true,
                    message = "Se registro la imagen satisfactoriamente.",
                    extra = nombreImagenFinal
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
        public string CargarMasivaConsultora(HttpPostedFileBase flCargarConsultoras, int hdCargaEventoId, int hdCargaCampaniaId)
        {
            string message;
            int registros = 0;

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                var listaConsultoras = new List<BEShowRoomEventoConsultora>();

                if (flCargarConsultoras != null)
                {
                    string extension = Path.GetExtension(flCargarConsultoras.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    var finalPath = Path.Combine(pathFile, newfileName);
                    flCargarConsultoras.SaveAs(finalPath);

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            var values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                var ent = new BEShowRoomEventoConsultora
                                {
                                    EventoID = hdCargaEventoId,
                                    CampaniaID = hdCargaCampaniaId,
                                    CodigoConsultora = values[0].Trim(),
                                    Segmento = values[1].Trim(),
                                    UsuarioCreacion = userData.CodigoConsultora,
                                    FechaCreacion = DateTime.Now,
                                    FechaModificacion = DateTime.Now
                                };

                                listaConsultoras.Add(ent);
                            }
                        }
                    }

                    if (listaConsultoras.Count > 0)
                    {
                        int paisId = userData.PaisID;
                        if (paisId > 0)
                        {
                            using (var sv = new PedidoServiceClient())
                            {
                                try
                                {
                                    registros += sv.CargarMasivaConsultora(paisId, listaConsultoras.ToArray());
                                }
                                catch (FaultException ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                            }
                        }
                    }
                }
                #endregion

                if (registros > 0)
                {
                    message = "Se realizó la carga de " + registros + " consultora(s)";
                }
                else
                {
                    message = "No se actualizó ninguna carga de las consultoras que estaban dentro del archivo (CSV), verifique que el código sea correcto.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " consultora(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " consultora(s).";
            }

            return message;
        }

        [Obsolete("Migrado PL50-50")]
        [HttpPost]
        public string ActualizarStockMasivo(HttpPostedFileBase flStock, int hdCargaStockEventoId)
        {
            string message;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV

                List<BEShowRoomOferta> lstStock = new List<BEShowRoomOferta>();
                List<BEShowRoomCategoria> listaCategoria = new List<BEShowRoomCategoria>();

                if (flStock != null)
                {
                    string fileName = Path.GetFileName(flStock.FileName);
                    string pathBanner = Server.MapPath("~/Content/FileCargaStock");
                    if (!Directory.Exists(pathBanner))
                        Directory.CreateDirectory(pathBanner);
                    var finalPath = Path.Combine(pathBanner, fileName ?? "");
                    flStock.SaveAs(finalPath);

                    int contador = 0;

                    using (var sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            var values = inputLine.Split('|');

                            if (values.Length <= 1) continue;

                            if (!IsNumeric(values[1].Trim()) || !IsNumeric(values[3].Trim())) continue;

                            var ent = new BEShowRoomOferta
                            {
                                ISOPais = values[0].Trim().Replace("\"", ""),
                                CampaniaID = int.Parse(values[1].Trim().Replace("\"", "")),
                                CUV = values[2].Trim().Replace("\"", ""),
                                Stock = int.Parse(values[3].Trim().Replace("\"", "")),
                                PrecioValorizado = decimal.Parse(values[4].Trim().Replace("\"", "")),
                                UnidadesPermitidas = int.Parse(values[5].Trim().Replace("\"", "")),
                                Descripcion = values[6].Trim().Replace("\"", ""),
                                CodigoCategoria = values[7].Trim().Replace("\"", ""),
                                TipNegocio = values[8].Trim().Replace("\"", ""),
                                EsSubCampania = int.Parse(values[9].Trim().Replace("\"", "")) == 1
                            };

                            if (ent.Stock >= 0)
                                lstStock.Add(ent);
                        }
                    }

                    if (lstStock.Count > 0)
                    {
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom);

                        List<PrecioProducto> lstPrecioProductoProl;
                        var stock1 = lstStock.First();
                        var codigosCuv = string.Join("|", lstStock.Select(x => x.CUV));

                        using (var svc = new WsGestionWeb())
                        {
                            lstPrecioProductoProl = svc.GetPrecioProductosOfertaWeb(stock1.ISOPais, stock1.CampaniaID.ToString(), codigosCuv).ToList();
                        }

                        if (lstPrecioProductoProl.Any())
                        {
                            foreach (var item in lstPrecioProductoProl)
                            {
                                var oStock = lstStock.FirstOrDefault(x => x.CUV == item.cuv);
                                if (oStock != null)
                                {
                                    oStock.PrecioOferta = item.precio_producto;
                                }
                            }
                        }

                        var productoPrecioCero = lstStock.FirstOrDefault(p => p.PrecioOferta == 0);
                        if (productoPrecioCero != null)
                        {
                            string messageErrorPrecioCero = "No se actualizó el stock de ninguno de los productos que estaban dentro del archivo (CSV), porque el producto " +
                                productoPrecioCero.CUV + " tiene precio oferta Cero";

                            LogManager.LogManager.LogErrorWebServicesPortal(new FaultException(), "ERROR: CARGA PRODUCTO SHOWROOM", "CUV: " + productoPrecioCero.CUV + " con precio CERO");

                            return messageErrorPrecioCero;
                        }

                        List<BEShowRoomOferta> lstPaises = lstStock.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        var categorias = lstStock.Select(p => p.CodigoCategoria).Distinct();
                        foreach (var item in categorias)
                        {
                            var beCategoria = new BEShowRoomCategoria
                            {
                                Codigo = item,
                                Descripcion = item,
                                EventoID = hdCargaStockEventoId
                            };
                            listaCategoria.Add(beCategoria);
                        }

                        using (var sv = new PedidoServiceClient())
                        {
                            sv.DeleteInsertShowRoomCategoriaByEvento(userData.PaisID, hdCargaStockEventoId, listaCategoria.ToArray());
                        }

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            List<BEShowRoomOferta> lstStockTemporal = lstStock.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);
                            int paisId = Util.GetPaisID(lstPaises[i].ISOPais);

                            if (paisId > 0)
                            {
                                using (var sv = new PedidoServiceClient())
                                {
                                    try
                                    {
                                        registros += sv.UpdOfertaShowRoomStockMasivo(paisId, lstStockTemporal.ToArray());
                                    }
                                    catch (FaultException ex)
                                    {
                                        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora,
                                            userData.CodigoISO);
                                    }
                                    catch (Exception ex)
                                    {
                                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                                            userData.CodigoISO);
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

        [Obsolete("Migrado PL50-50")]
        [HttpPost]
        public string ActualizarDescripcionSetsMasivo(HttpPostedFileBase flDescripcionSets, int hdCargaDescripcionSetsEventoId, int hdCargaDescripcionSetsCampaniaId)
        {
            string message;
            int registros = 0;

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                var listaDescripcionSets = new List<BEShowRoomOfertaDetalle>();

                if (flDescripcionSets != null)
                {
                    string fileName = Path.GetFileName(flDescripcionSets.FileName);
                    string extension = Path.GetExtension(flDescripcionSets.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    var finalPath = Path.Combine(pathFile, newfileName);
                    flDescripcionSets.SaveAs(finalPath);

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            var values = inputLine.Split('|');
                            if (values.Length > 1)
                            {
                                var ent = new BEShowRoomOfertaDetalle
                                {
                                    CUV = values[0].Trim().Replace("\"", ""),
                                    Posicion = values[1].Replace("\"", "0").ToInt(),
                                    NombreProducto = values[2].Trim().Replace("\"", ""),
                                    Descripcion1 = values[3].Trim().Replace("\"", ""),
                                    Descripcion2 = values[4].Trim().Replace("\"", ""),
                                    Descripcion3 = values[5].Trim().Replace("\"", ""),
                                    MarcaProducto = values[6].Trim().Replace("\"", ""),
                                    FechaCreacion = DateTime.Now,
                                    UsuarioCreacion = userData.CodigoConsultora,
                                    FechaModificacion = DateTime.Now
                                };

                                listaDescripcionSets.Add(ent);
                            }
                        }
                    }

                    if (listaDescripcionSets.Count > 0)
                    {
                        int paisId = userData.PaisID;
                        if (paisId > 0)
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                try
                                {
                                    registros += sv.CargarMasivaDescripcionSets(
                                        paisId, hdCargaDescripcionSetsCampaniaId, userData.CodigoConsultora,
                                        listaDescripcionSets.ToArray(), fileName, newfileName);
                                }
                                catch (FaultException ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                            }
                        }
                    }
                }
                #endregion

                if (registros > 0)
                {
                    message = "Se realizó la carga de " + registros + " set(s)";
                }
                else
                {
                    message = "No se actualizó ninguna carga de las consultoras que estaban dentro del archivo (CSV), verifique que el código sea correcto.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " set(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " set(s).";
            }

            return message;
        }

        [HttpPost]
        public string CargarProductoCpc(HttpPostedFileBase flCargarProductoCpc, int hdCargarProductoCpcEventoId,
            int hdCargarProductoCpcCampaniaId)
        {
            string message;
            int registros = 0;

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                var listaProductoCpc = new List<BEShowRoomCompraPorCompra>();

                if (flCargarProductoCpc != null)
                {
                    string extension = Path.GetExtension(flCargarProductoCpc.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    var finalPath = Path.Combine(pathFile, newfileName);
                    flCargarProductoCpc.SaveAs(finalPath);

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
                    {
                        string inputLine;
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            var values = inputLine.Split('|');
                            if (values.Length > 1)
                            {
                                var ent = new BEShowRoomCompraPorCompra
                                {
                                    CUV = values[0].Trim().Replace("\"", ""),
                                    SAP = values[1].Replace("\"", "0"),
                                    Orden = values[2].Trim().Replace("\"", "").ToInt(),
                                    PrecioValorizado = decimal.Parse(values[3].Trim().Replace("\"", ""))
                                };

                                listaProductoCpc.Add(ent);
                            }
                        }
                    }

                    if (listaProductoCpc.Count > 0)
                    {
                        int paisId = userData.PaisID;
                        if (paisId > 0)
                        {
                            using (var sv = new PedidoServiceClient())
                            {
                                try
                                {
                                    registros += sv.CargarProductoCpc(paisId, hdCargarProductoCpcEventoId,
                                        userData.CodigoConsultora, listaProductoCpc.ToArray());
                                }
                                catch (FaultException ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                                catch (Exception ex)
                                {
                                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora,
                                        userData.CodigoISO);
                                }
                            }
                        }
                    }
                }
                #endregion

                if (registros > 0)
                {
                    message = "Se realizó la carga de " + registros + " producto(s) de Compra por Compra";
                }
                else
                {
                    message = "No se actualizó ninguna carga de las consultoras que estaban dentro del archivo (CSV), verifique que el código sea correcto.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " set(s).";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                message = "Se actualizaron solo la carga de " + registros + " set(s).";
            }

            return message;
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

        [Obsolete("Migrado PL50-50")]
        public ActionResult ConsultarOfertaShowRoom(string sidx, string sord, int page, int rows, int paisId, int campaniaId)
        {
            if (ModelState.IsValid)
            {
                List<BEShowRoomOferta> lst;
                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosShowRoom(paisId, campaniaId).ToList();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BEShowRoomOferta> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
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
                        case "PrecioValorizado":
                            items = lst.OrderBy(x => x.PrecioValorizado);
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
                        case "PrecioValorizado":
                            items = lst.OrderBy(x => x.PrecioValorizado);
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
                string iso = Util.GetPaisISO(paisId);
                var carpetaPais = Globals.UrlMatriz + "/" + iso;

                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + iso));
                lst.Update(x => x.ImagenMini = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.RutaImagenesMatriz + "/" + iso));
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
                               cell = new[]
                               {
                                   a.CodigoTipoOferta.Trim(),
                                   a.CodigoProducto,
                                   a.CUV,
                                   a.Descripcion,
                                   a.PrecioValorizado.ToString("#0.00"),
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.Orden.ToString(),
                                   a.Stock.ToString(),
                                   a.StockInicial.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.CampaniaID.ToString(),
                                   a.OfertaShowRoomID.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.ConfiguracionOfertaID.ToString(),
                                   a.EsSubCampania.ToString(),
                                   a.CodigoCampania,
                                   a.ImagenProducto,
                                   a.ImagenMini
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult ObtenerImagenesByCodigoSAP(int paisId, string codigoSap)
        {
            List<BEMatrizComercial> lst;
            List<BEMatrizComercial> lstFinal = new List<BEMatrizComercial>();

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAP(paisId, codigoSap).ToList();
            }

            var carpetaPais = ObtenerCarpetaPais();
            if (lst.Count > 0)
            {
                lstFinal.Add(new BEMatrizComercial
                {
                    IdMatrizComercial = lst[0].IdMatrizComercial,
                    CodigoSAP = lst[0].CodigoSAP,
                    Descripcion = lst[0].Descripcion,
                    PaisID = lst[0].PaisID
                });

                if (lst[0].FotoProducto != "")
                    lstFinal[0].FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[1].FotoProducto != "")
                    lstFinal[0].FotoProducto02 = ConfigS3.GetUrlFileS3(carpetaPais, lst[1].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[2].FotoProducto != "")
                    lstFinal[0].FotoProducto03 = ConfigS3.GetUrlFileS3(carpetaPais, lst[2].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
            }
            return Json(new
            {
                lista = lstFinal
            }, JsonRequestBehavior.AllowGet);
        }

        [Obsolete("Migrado PL50-50")]
        public JsonResult ValidarPriorizacion(int paisId, string codigoOferta, int campaniaId, int orden)
        {
            int flagExiste;

            using (var sv = new PedidoServiceClient())
            {
                int configuracionOfertaId = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                flagExiste = sv.ValidarPriorizacionShowRoom(paisId, configuracionOfertaId, campaniaId, orden);
            }

            return Json(new
            {
                FlagExiste = flagExiste
            }, JsonRequestBehavior.AllowGet);
        }

        [Obsolete("Migracion de tablas")]
        public JsonResult ObtenerOrdenPriorizacion(int paisId, int configuracionOfertaId, int campaniaId)
        {
            int orden;

            using (var sv = new PedidoServiceClient())
            {
                orden = sv.GetOrdenPriorizacionShowRoom(paisId, configuracionOfertaId, campaniaId);
            }

            return Json(new
            {
                Orden = orden
            }, JsonRequestBehavior.AllowGet);
        }

        [Obsolete("Migrado PL50-50")]
        [HttpPost]
        public JsonResult InsertOrUpdateOfertaShowRoom(ShowRoomOfertaModel model)
        {
            try
            {
                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);
                entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                entidad.UsuarioRegistro = userData.CodigoConsultora;
                entidad.ImagenProducto = GuardarImagenAmazon(model.ImagenProducto, model.ImagenProductoAnterior, userData.PaisID, model.ImagenProducto == model.ImagenMini);
                entidad.ImagenMini = GuardarImagenAmazon(model.ImagenMini, model.ImagenMiniAnterior, userData.PaisID);

                using (var sv = new PedidoServiceClient())
                {
                    sv.InsOrUpdOfertaShowRoom(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se guardó la Oferta ShowRoom satisfactoriamente.",
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

        [Obsolete("Migrado PL50-50")]
        [HttpPost]
        public JsonResult DeshabilitarOfertaShowRoom(ShowRoomOfertaModel model)
        {
            try
            {
                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                entidad.UsuarioModificacion = userData.CodigoConsultora;
                using (var sv = new PedidoServiceClient())
                {
                    sv.DelOfertaShowRoom(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilito la Oferta de Show Room satisfactoriamente.",
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

        [Obsolete("Migrado PL50-50")]
        [HttpPost]
        public JsonResult RemoverOfertaShowRoom(ShowRoomOfertaModel model)
        {
            try
            {
                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                entidad.UsuarioModificacion = userData.CodigoConsultora;
                using (var sv = new PedidoServiceClient())
                {
                    sv.RemoverOfertaShowRoom(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó la Oferta de Show Room satisfactoriamente.",
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

        public string GuardarImagenAmazon(string nombreImagen, string nombreImagenAnterior, int paisId, bool keepFile = false)
        {
            string nombreImagenFinal;
            nombreImagen = nombreImagen ?? "";
            nombreImagenAnterior = nombreImagenAnterior ?? "";

            if (nombreImagen != nombreImagenAnterior)
            {
                string iso = Util.GetPaisISO(paisId);
                string carpetaPais = Globals.UrlMatriz + "/" + iso;

                string soloImagen = nombreImagen.Split('.')[0];
                string soloExtension = nombreImagen.Split('.')[1];
                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                nombreImagenFinal = iso + "_" + soloImagen + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + "." + soloExtension;

                if (nombreImagenAnterior != "") ConfigS3.DeleteFileS3(carpetaPais, nombreImagenAnterior);
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, nombreImagen), carpetaPais, nombreImagenFinal, true, !keepFile, false);
            }
            else nombreImagenFinal = nombreImagen;

            return nombreImagenFinal;
        }

        [Obsolete("Zona de Estrategias")]
        public ActionResult ConsultarOfertaShowRoomDetalle(string sidx, string sord, int page, int rows, int campaniaId, string cuv)
        {
            if (ModelState.IsValid)
            {
                List<BEShowRoomOfertaDetalle> lst;

                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosShowRoomDetalle(userData.PaisID, campaniaId, cuv).ToList();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<BEShowRoomOfertaDetalle> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NombreProducto":
                            items = lst.OrderBy(x => x.NombreProducto);
                            break;
                        case "Descripcion1":
                            items = lst.OrderBy(x => x.Descripcion1);
                            break;
                        case "Descripcion2":
                            items = lst.OrderBy(x => x.Descripcion2);
                            break;
                        case "Descripcion3":
                            items = lst.OrderBy(x => x.Descripcion3);
                            break;
                        case "MarcaProducto":
                            items = lst.OrderBy(x => x.MarcaProducto);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NombreProducto":
                            items = lst.OrderBy(x => x.NombreProducto);
                            break;
                        case "Descripcion1":
                            items = lst.OrderBy(x => x.Descripcion1);
                            break;
                        case "Descripcion2":
                            items = lst.OrderBy(x => x.Descripcion2);
                            break;
                        case "Descripcion3":
                            items = lst.OrderBy(x => x.Descripcion3);
                            break;
                        case "MarcaProducto":
                            items = lst.OrderBy(x => x.MarcaProducto);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                string iso = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + iso;

                lst.Update(x => x.Imagen = ConfigS3.GetUrlFileS3(carpetaPais, x.Imagen, Globals.RutaImagenesMatriz + "/" + iso));

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.OfertaShowRoomDetalleID,
                               cell = new[]
                               {
                                   a.OfertaShowRoomDetalleID.ToString(),
                                   a.CampaniaID.ToString(),
                                   a.CUV,
                                   a.NombreProducto,
                                   a.Descripcion1,
                                   a.Descripcion2,
                                   a.Descripcion3,
                                   a.Imagen,
                                   a.MarcaProducto,
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult ConsultarOfertaShowRoomDetalleNew(string sidx, string sord, int page, int rows, int estrategiaId)
        {
            if (ModelState.IsValid)
            {
                List<ServicePedido.BEEstrategiaProducto> lst;
                var estrategiaX = new EstrategiaPedidoModel() { PaisID = userData.PaisID, EstrategiaID = estrategiaId };

                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetEstrategiaProducto(Mapper.Map<EstrategiaPedidoModel, ServicePedido.BEEstrategia>(estrategiaX)).ToList();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<ServicePedido.BEEstrategiaProducto> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NombreProducto":
                            items = lst.OrderBy(x => x.NombreProducto);
                            break;
                        case "Descripcion1":
                            items = lst.OrderBy(x => x.Descripcion1);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NombreProducto":
                            items = lst.OrderBy(x => x.NombreProducto);
                            break;
                        case "Descripcion1":
                            items = lst.OrderBy(x => x.Descripcion1);
                            break;
                    }
                }
                #endregion

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                string iso = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + iso;

                lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + iso));

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.EstrategiaProductoID,
                               cell = new[]
                                {
                                    a.EstrategiaProductoID.ToString(),
                                    a.EstrategiaID.ToString(),
                                    a.Campania.ToString(),
                                    a.CUV,
                                    a.NombreProducto,
                                    a.Descripcion1,
                                    a.ImagenProducto,
                                    a.IdMarca.ToString(),
                                    a.Precio.ToString(),
                                    a.PrecioValorizado.ToString(),
                                    a.Activo.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [Obsolete("Zona de Estrategias")]
        [HttpPost]
        public JsonResult InsertOfertaShowRoomDetalle(ShowRoomOfertaDetalleModel model)
        {
            try
            {
                BEShowRoomOfertaDetalle entidad = Mapper.Map<ShowRoomOfertaDetalleModel, BEShowRoomOfertaDetalle>(model);

                entidad.UsuarioCreacion = userData.CodigoConsultora;
                entidad.Imagen = GuardarImagenAmazon(model.Imagen, model.ImagenAnterior, userData.PaisID);

                using (var sv = new PedidoServiceClient())
                {
                    sv.InsOfertaShowRoomDetalle(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se insertó el Producto satisfactoriamente.",
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
        public JsonResult InsertOfertaShowRoomDetalleNew(EstrategiaProductoModel model)
        {
            try
            {
                var entidad = Mapper.Map<EstrategiaProductoModel, ServicePedido.BEEstrategiaProducto>(model);

                entidad.PaisID = userData.PaisID;
                entidad.UsuarioModificacion = userData.CodigoConsultora;
                entidad.ImagenProducto = GuardarImagenAmazon(model.ImagenProducto, model.ImagenAnterior, userData.PaisID);

                List<ServicePedido.BEEstrategiaProducto> lstProd;
                var estrategiaX = new EstrategiaPedidoModel() { PaisID = userData.PaisID, EstrategiaID = model.EstrategiaID };

                using (var sv = new PedidoServiceClient())
                {
                    lstProd = sv.GetEstrategiaProducto(Mapper.Map<EstrategiaPedidoModel, ServicePedido.BEEstrategia>(estrategiaX)).ToList();
                }

                var existe = false;
                if (lstProd.Any())
                {
                    var objx = lstProd.Where(x => x.CUV == model.CUV && x.Activo == 1).FirstOrDefault();
                    existe = objx != null;
                }

                if (!existe)
                {
                    var entidadx = new ServicePedido.BEEstrategia { CampaniaID = entidad.Campania, CUV2 = entidad.CUV2 };
                    var respuestaServiceCdr = EstrategiaProductoObtenerServicio(entidadx);

                    if (respuestaServiceCdr.Any())
                    {
                        var objProd = respuestaServiceCdr.Where(x => x.cuv == entidad.CUV).FirstOrDefault();
                        if (objProd != null)
                        {
                            entidad.CodigoEstrategia = objProd.codigo_estrategia;
                            entidad.Grupo = objProd.grupo;
                            entidad.Orden = objProd.orden;
                            entidad.SAP = objProd.codigo_sap;
                            entidad.Cantidad = objProd.cantidad;
                            entidad.Precio = objProd.precio_unitario;
                            entidad.PrecioValorizado = objProd.precio_valorizado;
                            entidad.Digitable = Convert.ToInt16(objProd.digitable);
                            entidad.FactorCuadre = objProd.factor_cuadre;
                            entidad.IdMarca = objProd.idmarca;

                            using (var sv = new PedidoServiceClient())
                            {
                                sv.InsertarEstrategiaProducto(entidad);
                            }

                            return Json(new
                            {
                                success = true,
                                message = "Se insertó el Producto satisfactoriamente.",
                                extra = ""
                            });
                        }
                    }
                }

                return Json(new
                {
                    success = false,
                    message = "No se pudo insertar el Producto, vuelva a intentar.",
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

        private List<RptProductoEstrategia> EstrategiaProductoObtenerServicio(ServicePedido.BEEstrategia entidad)
        {
            var respuestaServiceCdr = new List<RptProductoEstrategia>();
            try
            {
                var codigo = ObtenerValorTablaLogica(userData.PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.Tonos, true);

                if (Convert.ToInt32(codigo) <= entidad.CampaniaID)
                {
                    using (var sv = new WsGestionWeb())
                    {
                        respuestaServiceCdr = sv.GetEstrategiaProducto(entidad.CampaniaID.ToString(), userData.CodigoConsultora, entidad.CUV2, userData.CodigoISO).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                respuestaServiceCdr = new List<RptProductoEstrategia>();
            }
            return respuestaServiceCdr;
        }

        private int TieneVariedad(string codigo, string cuv)
        {
            var tieneVariedad = 0;
            switch (codigo)
            {
                case Constantes.TipoEstrategiaSet.IndividualConTonos:
                    List<ServiceODS.BEProducto> listaHermanosE;
                    using (var svc = new ODSServiceClient())
                    {
                        listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, cuv).ToList();
                    }
                    tieneVariedad = listaHermanosE.Any() ? 1 : 0;
                    break;
                case Constantes.TipoEstrategiaSet.CompuestaVariable:
                    tieneVariedad = 1;
                    break;
            }

            return tieneVariedad;
        }

        [Obsolete("Zona de Estrategias")]
        [HttpPost]
        public JsonResult UpdateOfertaShowRoomDetalle(ShowRoomOfertaDetalleModel model)
        {
            try
            {
                BEShowRoomOfertaDetalle entidad = Mapper.Map<ShowRoomOfertaDetalleModel, BEShowRoomOfertaDetalle>(model);

                entidad.UsuarioModificacion = userData.CodigoConsultora;
                entidad.Imagen = GuardarImagenAmazon(model.Imagen, model.ImagenAnterior, userData.PaisID);


                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdOfertaShowRoomDetalle(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó el Producto satisfactoriamente.",
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
        public JsonResult UpdateOfertaShowRoomDetalleNew(EstrategiaProductoModel model)
        {
            try
            {
                var entidad = Mapper.Map<EstrategiaProductoModel, ServicePedido.BEEstrategiaProducto>(model);

                entidad.PaisID = userData.PaisID;
                entidad.UsuarioModificacion = userData.CodigoConsultora;
                entidad.ImagenProducto = GuardarImagenAmazon(model.ImagenProducto, model.ImagenAnterior, userData.PaisID);

                using (var sv = new PedidoServiceClient())
                {
                    sv.ActualizarEstrategiaProducto(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó el Producto satisfactoriamente.",
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

        [Obsolete("Zona de Estrategias")]
        [HttpPost]
        public JsonResult EliminarOfertaShowRoomDetalle(int ofertaShowRoomDetalleId, int campaniaId, string cuv)
        {
            try
            {
                var beShowRoomOfertaDetalle = new BEShowRoomOfertaDetalle
                {
                    OfertaShowRoomDetalleID = ofertaShowRoomDetalleId,
                    CampaniaID = campaniaId,
                    CUV = cuv
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarOfertaShowRoomDetalle(userData.PaisID, beShowRoomOfertaDetalle);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino el Producto satisfactoriamente.",
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
        public JsonResult EliminarOfertaShowRoomDetalleNew(int estrategiaId, string cuv)
        {
            try
            {
                var entidad = new ServicePedido.BEEstrategiaProducto
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = estrategiaId,
                    CUV = cuv
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarEstrategiaProducto(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino el Producto satisfactoriamente.",
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

        [Obsolete("Zona de Estrategias")]
        [HttpPost]
        public JsonResult EliminarOfertaShowRoomDetalleAll(int campaniaId, string cuv)
        {
            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarOfertaShowRoomDetalleAll(userData.PaisID, campaniaId, cuv);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino todos los Productos del set satisfactoriamente.",
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
        public JsonResult EliminarOfertaShowRoomDetalleAllNew(int estrategiaId)
        {
            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarEstrategiaProductoAll(userData.PaisID, estrategiaId, userData.CodigoConsultora);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino todos los Productos del set satisfactoriamente.",
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

        [Obsolete("Migrado PL50-50")]
        [HttpPost]
        public JsonResult GetShowRoomPerfilOfertaCuvs(int campaniaId, int eventoId, int perfilId)
        {
            try
            {
                List<BEShowRoomPerfilOferta> listaShowRoomPerfilOferta;
                var beShowRoomPerfilOferta = new BEShowRoomPerfilOferta
                {
                    CampaniaID = campaniaId,
                    EventoID = eventoId,
                    PerfilID = perfilId
                };

                using (var sv = new PedidoServiceClient())
                {
                    listaShowRoomPerfilOferta = sv.GetShowRoomPerfilOfertaCuvs(userData.PaisID, beShowRoomPerfilOferta).ToList();
                }

                if (listaShowRoomPerfilOferta.Count <= 0)
                    return Json(new
                    {
                        success = true,
                        message = "OK",
                        data = ""
                    });

                return Json(new
                {
                    success = true,
                    message = "OK",
                    data = listaShowRoomPerfilOferta
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
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

        [HttpPost]
        public JsonResult GuardarPerfilOfertaShowRoom(int perfilId, int eventoId, int campaniaId, string cadenaCuv)
        {
            if (!string.IsNullOrEmpty(cadenaCuv))
                cadenaCuv = cadenaCuv.Substring(0, cadenaCuv.Length - 1);

            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    sv.GuardarPerfilOfertaShowRoom(userData.PaisID, perfilId, eventoId, campaniaId, cadenaCuv);
                }

                return Json(new
                {
                    success = true,
                    message = "Cuvs para el perfil guardado correctamente",
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

        [HttpPost]
        public JsonResult GetShowRoomPersonalizacionNivel(int eventoId, int nivelId)
        {
            try
            {
                var listaPersonalizacionModel = configEstrategiaSR.ListaPersonalizacionConsultora.Where(
                        p => p.TipoPersonalizacion == Constantes.ShowRoomPersonalizacion.TipoPersonalizacion.Evento).ToList();

                List<BEShowRoomPersonalizacionNivel> listaPersonalizacionNivel;

                using (var ps = new PedidoServiceClient())
                {
                    listaPersonalizacionNivel = ps.GetShowRoomPersonalizacionNivel(userData.PaisID, eventoId, nivelId, 0).ToList();
                }

                foreach (var item in listaPersonalizacionModel)
                {
                    var personalizacionnivel =
                        listaPersonalizacionNivel.FirstOrDefault(p => p.NivelId == nivelId && p.EventoID == eventoId &&
                                p.PersonalizacionId == item.PersonalizacionId);

                    if (personalizacionnivel != null)
                    {
                        item.PersonalizacionNivelId = personalizacionnivel.PersonalizacionNivelId;
                        item.Valor = personalizacionnivel.Valor;

                        if (item.TipoAtributo == "IMAGEN")
                        {
                            string iso = Util.GetPaisISO(userData.PaisID);
                            var carpetaPais = Globals.UrlMatriz + "/" + iso;

                            item.Valor = string.IsNullOrEmpty(item.Valor)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, item.Valor, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                        }
                    }
                    else
                    {
                        item.PersonalizacionNivelId = 0;
                        item.Valor = "";
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    listaPersonalizacion = listaPersonalizacionModel,
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

        [HttpPost]
        public JsonResult GuardarPersonalizacionNivelShowRoom(List<ShowRoomPersonalizacionNivelModel> lista)
        {
            try
            {
                var listaFinal = new List<ShowRoomPersonalizacionNivelModel>();
                foreach (var model in lista)
                {
                    model.Valor = Util.Trim(model.Valor);
                    model.ValorAnterior = Util.Trim(model.ValorAnterior);

                    if (model.EsImagen)
                    {
                        string imagenProductoFinal = GuardarImagenAmazon(model.Valor, model.ValorAnterior, userData.PaisID);
                        model.Valor = imagenProductoFinal;
                    }

                    if (model.Valor != model.ValorAnterior)
                    {
                        listaFinal.Add(model);
                    }
                }

                var listaEntidades = Mapper.Map<IList<ShowRoomPersonalizacionNivelModel>, IList<BEShowRoomPersonalizacionNivel>>(listaFinal);

                foreach (var entidad in listaEntidades)
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {

                        if (entidad.PersonalizacionNivelId == 0)
                        {
                            ps.InsertShowRoomPersonalizacionNivel(userData.PaisID, entidad);
                        }
                        else
                        {
                            ps.UpdateShowRoomPersonalizacionNivel(userData.PaisID, entidad);
                        }
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se insertó las personalizaciones satisfactoriamente.",
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
        public JsonResult GetShowRoomPersonalizacionCategoria(int eventoId, int categoriaId)
        {
            try
            {
                BEShowRoomCategoria categoria;
                using (var ps = new PedidoServiceClient())
                {
                    categoria = ps.GetShowRoomCategoriaById(userData.PaisID, categoriaId);
                }

                categoria = categoria ?? new BEShowRoomCategoria();

                var listaPersonalizacionModel = configEstrategiaSR.ListaPersonalizacionConsultora.Where(
                        p => p.TipoPersonalizacion == Constantes.ShowRoomPersonalizacion.TipoPersonalizacion.Categoria).ToList();

                List<BEShowRoomPersonalizacionNivel> listaPersonalizacionCategoria;

                using (var ps = new PedidoServiceClient())
                {
                    listaPersonalizacionCategoria = ps.GetShowRoomPersonalizacionNivel(userData.PaisID, eventoId, 0, categoriaId).ToList();
                }

                foreach (var item in listaPersonalizacionModel)
                {
                    var personalizacionnivel =
                        listaPersonalizacionCategoria.FirstOrDefault(p => p.CategoriaId == categoriaId && p.EventoID == eventoId &&
                                p.PersonalizacionId == item.PersonalizacionId);

                    if (personalizacionnivel != null)
                    {
                        item.PersonalizacionNivelId = personalizacionnivel.PersonalizacionNivelId;
                        item.Valor = personalizacionnivel.Valor;

                        if (item.TipoAtributo == "IMAGEN")
                        {
                            string iso = Util.GetPaisISO(userData.PaisID);
                            var carpetaPais = Globals.UrlMatriz + "/" + iso;

                            item.Valor = string.IsNullOrEmpty(item.Valor)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, item.Valor, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                        }
                    }
                    else
                    {
                        item.PersonalizacionNivelId = 0;
                        item.Valor = "";
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    categoria,
                    listaPersonalizacion = listaPersonalizacionModel,
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
        public JsonResult UpdateShowRoomDescripcionCategoria(ShowRoomCategoriaModel model)
        {
            try
            {
                var entidad = Mapper.Map<ShowRoomCategoriaModel, BEShowRoomCategoria>(model);

                using (var ps = new PedidoServiceClient())
                {
                    ps.UpdateShowRoomDescripcionCategoria(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    data = ""
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

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2 ? sv.SelectPaises().ToList() : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        [HttpPost]
        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        #region Comprar desde Página de Oferta

        public ActionResult DetalleOfertaCUV(string query)
        {
            if (Request.Browser.IsMobileDevice)
            {
                return RedirectToAction("DetalleOfertaCUV", "ShowRoom", new { area = "Mobile", query });
            }

            if (query != null)
            {
                string param = Util.Decrypt(query);
                string[] lista = param.Split(';');

                if (lista[2] != userData.CodigoConsultora && lista[1] != userData.CodigoISO)
                {
                    return RedirectToAction("Index", "Bienvenida");
                }

                if (lista[0] == CodigoProceso)
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        _blnRecibido = Convert.ToBoolean(sv.GetEventoConsultoraRecibido(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID));
                    }

                    _ofertaId = lista[5] != null ? Convert.ToInt32(lista[5]) : 0;

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && !_blnRecibido)
                    {
                        var entidad = new BEShowRoomEventoConsultora
                        {
                            CodigoConsultora = lista[2],
                            CampaniaID = Convert.ToInt32(lista[3])
                        };

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, entidad);
                        }

                    }
                }
                else
                {
                    return RedirectToAction("Index", "Bienvenida");
                }

            }

            return RedirectToAction("DetalleOferta", "ShowRoom", new { id = _ofertaId });
        }

        public ActionResult DetalleOferta(int id)
        {
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var estrategiaSR = sessionManager.GetEstrategiaSR();
            var modelo = ViewDetalleOferta(id);
            modelo.EstrategiaId = id;
            var xList = modelo.ListaOfertaShowRoom.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
            modelo.ListaOfertaShowRoom = xList;

            bool esFacturacion = EsFacturacion();

            var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, estrategiaSR.BeShowRoom.EventoID,
                        estrategiaSR.BeShowRoom.CampaniaID);
            modelo.ListaShowRoomCompraPorCompra = listaCompraPorCompra;
            modelo.TieneCompraXcompra = estrategiaSR.BeShowRoom.TieneCompraXcompra;

            ViewBag.ImagenFondoProductPage = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoProductPage, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
            ViewBag.IconoLLuvia = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

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

                bool esFacturacion = EsFacturacion();
                var productosShowRoom = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, esFacturacion, false);

                var listaNoSubCampania = new List<ShowRoomOfertaModel>();
                var listaNoSubCampaniaPerdio = new List<ShowRoomOfertaModel>();

                if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
                {
                    listaNoSubCampania = productosShowRoom.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                    listaNoSubCampaniaPerdio = productosShowRoom.Where(x => !x.EsSubCampania && x.FlagRevista != Constantes.FlagRevista.Valor0).ToList();
                }
                else
                {
                    listaNoSubCampania = productosShowRoom.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                }
                var totalNoSubCampania = listaNoSubCampania.Count;

                if (model.ListaFiltro != null && model.ListaFiltro.Count > 0)
                {
                    var filtroCategoria = model.ListaFiltro.FirstOrDefault(p => p.Tipo == Constantes.ShowRoomTipoFiltro.Categoria);
                    if (filtroCategoria != null)
                    {
                        var arrayCategoria = filtroCategoria.Valores.ToArray();
                        listaNoSubCampania = listaNoSubCampania.Where(p => arrayCategoria.Contains(p.CodigoCategoria)).ToList();
                    }

                    var filtroRangoPrecio = model.ListaFiltro.FirstOrDefault(p => p.Tipo == Constantes.ShowRoomTipoFiltro.RangoPrecios);
                    if (filtroRangoPrecio != null)
                    {
                        var valorDesde = filtroRangoPrecio.Valores[0];
                        var valorHasta = filtroRangoPrecio.Valores[1];
                        listaNoSubCampania = listaNoSubCampania.Where(p => p.PrecioOferta >= Convert.ToDecimal(valorDesde)
                                     && p.PrecioOferta <= Convert.ToDecimal(valorHasta)).ToList();
                    }
                }
                if (model.Ordenamiento != null && model.Ordenamiento.Tipo == Constantes.ShowRoomTipoOrdenamiento.Precio)
                {
                    switch (model.Ordenamiento.Valor)
                    {
                        case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido:
                            listaNoSubCampania = listaNoSubCampania.OrderBy(p => p.Orden).ToList();
                            break;
                        case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor:
                            listaNoSubCampania = listaNoSubCampania.OrderBy(p => p.PrecioOferta).ToList();
                            break;
                        case Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor:
                            listaNoSubCampania = listaNoSubCampania.OrderByDescending(p => p.PrecioOferta).ToList();
                            break;
                        default:
                            listaNoSubCampania = listaNoSubCampania.OrderBy(p => p.Orden).ToList();
                            break;
                    }
                }

                if (model.Limite > 0)
                    listaNoSubCampania = listaNoSubCampania.Take(model.Limite).ToList();

                var listaSubCampania = productosShowRoom.Where(x => x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                listaSubCampania = ValidarUnidadesPermitidas(listaSubCampania);

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    listaNoSubCampania,
                    totalNoSubCampania,
                    listaSubCampania,
                    listaNoSubCampaniaPerdio
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

                var esFacturacion = EsFacturacion();
                var productosShowRoom = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, esFacturacion, false);
                productosShowRoom = productosShowRoom.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();

                if (model.Limite > 0 && productosShowRoom.Count > 0)
                {
                    productosShowRoom = productosShowRoom.Take(model.Limite).ToList();
                }

                var index = 0;
                productosShowRoom.Each(x =>
                {
                    x.Posicion = index++;
                    x.UrlDetalle = Url.Action("DetalleOferta", new { id = x.OfertaShowRoomID });
                });

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    data = productosShowRoom,
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

                var showRoom = configEstrategiaSR.BeShowRoom ?? new BEShowRoomEvento();

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

                if (!PaisTieneShowRoom(userData.CodigoISO))
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

                var showRoom = configEstrategiaSR.BeShowRoom ?? new BEShowRoomEvento();

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var showRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
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
        public JsonResult CerrarBannerCompraPorCompra()
        {
            try
            {
                userData.CloseBannerCompraPorCompra = true;

                SetUserData(userData);

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
            SetUserData(userData);
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
            configEstrategiaSR.BeShowRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
            configEstrategiaSR.BeShowRoomConsultora.Suscripcion = true;
            configEstrategiaSR.BeShowRoomConsultora.CorreoEnvioAviso = model.EMail;
            configEstrategiaSR.BeShowRoomConsultora.CampaniaID = userData.CampaniaID;
            configEstrategiaSR.BeShowRoomConsultora.CodigoConsultora = userData.CodigoConsultora;

            using (PedidoServiceClient sac = new PedidoServiceClient())
            {
                sac.ShowRoomProgramarAviso(userData.PaisID, configEstrategiaSR.BeShowRoomConsultora);
            }
        }

        public ActionResult ConsultarTiposOferta(string sidx, string sord, int page, int rows)
        {
            if (!ModelState.IsValid) return RedirectToAction("Index", "Bienvenida");

            List<BEShowRoomTipoOferta> lst;
            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetShowRoomTipoOferta(userData.PaisID).ToList();
            }

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };

            IEnumerable<BEShowRoomTipoOferta> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "Codigo":
                        items = lst.OrderBy(x => x.Codigo);
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
                    case "Codigo":
                        items = lst.OrderBy(x => x.Codigo);
                        break;
                    case "Descripcion":
                        items = lst.OrderBy(x => x.Descripcion);
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
                           id = a.TipoOfertaID,
                           cell = new[]
                           {
                        a.TipoOfertaID.ToString(),
                        a.Codigo,
                        a.Descripcion,
                        a.Activo.ToString()
                    }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ExisteTipoOferta(BEShowRoomTipoOferta entity)
        {
            int resultado = -1;

            try
            {
                using (var ps = new PedidoServiceClient())
                {
                    resultado = ps.ExisteShowRoomTipoOferta(userData.PaisID, entity);
                }

                var message = resultado == 0
                    ? "OK"
                    : resultado == 1
                        ? "Código Tipo de Oferta ya existe "
                        : resultado == 2
                            ? "Descripción de Tipo de Oferta ya existe"
                            : "Error al verificar si existe el tipo de oferta";

                return Json(new
                {
                    success = true,
                    resultado,
                    message
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    resultado,
                    message = "Error al verificar si existe el tipo de oferta"
                });
            }
        }

        [HttpPost]
        public JsonResult GuardarShowRoomTipoOferta(BEShowRoomTipoOferta entity)
        {
            try
            {
                string message;

                entity.UsuarioCreacion = userData.CodigoConsultora;

                using (var ps = new PedidoServiceClient())
                {
                    if (entity.TipoOfertaID == 0)
                    {
                        ps.InsertShowRoomTipoOferta(userData.PaisID, entity);
                        message = "Tipo de Oferta Agregado correctamente";
                    }
                    else
                    {
                        ps.UpdateShowRoomTipoOferta(userData.PaisID, entity);
                        message = "Tipo de Oferta Modificado correctamente";
                    }
                }

                return Json(new
                {
                    success = true,
                    message,
                    data = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "ERROR",
                    data = ""
                });
            }
        }

        [HttpPost]
        public JsonResult HabilitarShowRoomTipoOferta(BEShowRoomTipoOferta entity)
        {
            try
            {
                using (var ps = new PedidoServiceClient())
                {
                    ps.HabilitarShowRoomTipoOferta(userData.PaisID, entity);
                }

                var message = "Tipo de Oferta ShowRoom " + (entity.Activo ? "Activado" : "Desactivado") + " correctamente";

                return Json(new
                {
                    success = true,
                    message,
                    data = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "ERROR",
                    data = ""
                });
            }
        }

        private List<ShowRoomOfertaModel> ValidarUnidadesPermitidas(List<ShowRoomOfertaModel> listaShowRoomOferta)
        {
            if (listaShowRoomOferta != null)
            {
                var detalle = new List<BEPedidoWebDetalle>();
                if (sessionManager.GetDetallesPedido() != null)
                    detalle = sessionManager.GetDetallesPedido();
                if (detalle.Count > 0)
                {
                    for (var i = 0; i <= listaShowRoomOferta.Count - 1; i++)
                    {
                        var item = listaShowRoomOferta[i];
                        item.UnidadesPermitidasRestantes = item.UnidadesPermitidas;
                        if (item.EsSubCampania)
                        {
                            int cantidad = detalle.Where(x => x.CUV == item.CUV).Sum(x => x.Cantidad).ToInt();
                            item.UnidadesPermitidasRestantes = item.UnidadesPermitidas - cantidad;
                        }
                    }
                }
            }
            return listaShowRoomOferta;
        }

        [HttpGet]
        public JsonResult DesactivarBannerInferior()
        {
            _sessionManager.ShowRoom.BannerInferiorConfiguracion.Activo = false;

            return Json(ResultModel<bool>.BuildOk(true), JsonRequestBehavior.AllowGet);
        }
    }
}
