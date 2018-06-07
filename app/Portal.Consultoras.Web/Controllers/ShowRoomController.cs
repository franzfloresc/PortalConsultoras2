using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;
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
    public class ShowRoomController : BaseEstrategiaController
    {
        public ShowRoomController() : base()
        {

        }

        //OK
        public ActionResult Intriga()
        {
            if (!ValidarIngresoShowRoom(true))
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var model = ObtenerPrimeraOfertaShowRoom();
            if (model == null)
            {
                return RedirectToAction("Index", "Bienvenida");
            }
            InicializarViewbag();
            model.Simbolo = userData.Simbolo;
            model.CodigoISO = userData.CodigoISO;
            model.Suscripcion = (configEstrategiaSR.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora()).Suscripcion;
            model.EMail = userData.EMail;
            model.EMailActivo = userData.EMailActivo;
            model.Celular = userData.Celular;
            model.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
            model.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == model.CUV) ? "block" : "none";

            return View(model);
        }

        //OK
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

                    if (srQsv.CodigoConsultora != userData.CodigoConsultora && srQsv.CodigoIso != userData.CodigoISO ||
                        srQsv.CodigoProceso != CodigoProceso)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }

                    if (srQsv.CampanaId == userData.CampaniaID && !GetEventoConsultoraRecibido(userData))
                    {
                        UpdShowRoomEventoConsultoraEmailRecibido(srQsv.CodigoConsultora, srQsv.CampanaId, userData);
                    }
                }

                var showRoomEventoModel = CargarValoresModel();
                showRoomEventoModel.ListaShowRoomOferta = ValidarUnidadesPermitidas(showRoomEventoModel.ListaShowRoomOferta);
                showRoomEventoModel.ListaShowRoomOferta = showRoomEventoModel.ListaShowRoomOferta ?? new List<ShowRoomOfertaModel>();

                if (!showRoomEventoModel.ListaShowRoomOferta.Any()) return RedirectToAction("Index", "Bienvenida");

                showRoomEventoModel.FiltersBySorting = GetTablaLogicaDatos(Constantes.TablaLogica.OrdenamientoShowRoom);
                var xlistaShowRoom = showRoomEventoModel.ListaShowRoomOferta.Where(x => !x.EsSubCampania).ToList();
                ViewBag.PrecioMin = xlistaShowRoom.Any() ? xlistaShowRoom.Min(p => p.PrecioOferta) : Convert.ToDecimal(0);
                ViewBag.PrecioMax = xlistaShowRoom.Any() ? xlistaShowRoom.Max(p => p.PrecioOferta) : Convert.ToDecimal(0);

                ViewBag.CloseBannerCompraPorCompra = userData.CloseBannerCompraPorCompra;

                ViewBag.BannerImagenVenta = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.BannerImagenVenta, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
                ViewBag.IconoLLuvia = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

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

        //OK
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

        //OK
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

        //OK
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

        //OK
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

        //OK
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

        #region Compra por Compra
        [Obsolete("Revisar si se va usar")]
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

        //OK
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

        #endregion

        //OK
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

        //OK
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

        //OK
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

        //OK
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

        //OK
        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            return InsertarPedidoWebPortal(model, 1);
        }

        //OK
        [HttpPost]
        public JsonResult InsertOfertaWebPortalCpc(PedidoDetalleModel model)
        {
            return InsertarPedidoWebPortal(model, 2);
        }

        //OK
        public ActionResult ConsultarOfertaShowRoomDetalleNew(string sidx, string sord, int page, int rows, int estrategiaId)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategiaProducto> lst;
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

                IEnumerable<BEEstrategiaProducto> items = lst;

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

        //OK
        [HttpPost]
        public JsonResult InsertOfertaShowRoomDetalleNew(EstrategiaProductoModel model)
        {
            try
            {
                var entidad = Mapper.Map<EstrategiaProductoModel, BEEstrategiaProducto>(model);

                entidad.PaisID = userData.PaisID;
                entidad.UsuarioModificacion = userData.CodigoConsultora;
                entidad.ImagenProducto = GuardarImagenAmazon(model.ImagenProducto, model.ImagenAnterior, userData.PaisID);

                List<BEEstrategiaProducto> lstProd;
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

        //OK
        [HttpPost]
        public JsonResult UpdateOfertaShowRoomDetalleNew(EstrategiaProductoModel model)
        {
            try
            {
                var entidad = Mapper.Map<EstrategiaProductoModel, BEEstrategiaProducto>(model);

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

        //OK
        [HttpPost]
        public JsonResult EliminarOfertaShowRoomDetalleNew(int estrategiaId, string cuv)
        {
            try
            {
                var entidad = new BEEstrategiaProducto
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

        //OK
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

        //OK
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

        //OK
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

        #region Comprar desde Página de Oferta

        //OK
        public ActionResult DetalleOferta(int id)
        {
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var estrategiaSR = sessionManager.GetEstrategiaSR();
            var modelo = ViewDetalleOferta(id);
            modelo.EstrategiaId = id;
            var xList = modelo.ListaOfertaShowRoom.Where(x => !x.EsSubCampania).ToList();
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

        //OK
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
                    listaNoSubCampania = productosShowRoom.Where(x => !x.EsSubCampania).ToList();
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

                var listaSubCampania = productosShowRoom.Where(x => x.EsSubCampania).ToList();
                listaSubCampania = ValidarUnidadesPermitidas(listaSubCampania);

                return Json(new
                {
                    success = true,
                    message = "Ok",
                    listaNoSubCampania,
                    totalNoSubCampania,
                    listaSubCampania,
                    listaNoSubCampaniaPerdio   //JN: Nueva lista de CUV en Zona Dorada
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.CargarProductosShowRoom);
            }
        }

        //OK
        [HttpPost]
        public JsonResult CargarProductosShowRoomOferta(BusquedaProductoModel model)
        {
            try
            {
                if (!ValidarIngresoShowRoom(esIntriga: false))
                    return ErrorJson(string.Empty);

                var esFacturacion = EsFacturacion();
                var productosShowRoom = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, esFacturacion);

                if (model.Limite > 0 && productosShowRoom.Count > 0)
                {
                    productosShowRoom = productosShowRoom.Where(x => !x.EsSubCampania).Take(model.Limite).ToList();
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

        //OK
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

        [Obsolete("Revisar si se va usar")]
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

        //OK
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

        //OK
        [HttpGet]
        public JsonResult DesactivarBannerInferior()
        {
            sessionManager.ShowRoom.BannerInferiorConfiguracion.Activo = false;

            return Json(ResultModel<bool>.BuildOk(true), JsonRequestBehavior.AllowGet);
        }

        #region Metodos Privados

        private string GuardarImagenAmazon(string nombreImagen, string nombreImagenAnterior, int paisId, bool keepFile = false)
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

        //[HttpPost]
        //private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        //{
        //    IList<BECampania> lst;
        //    using (var sv = new ZonificacionServiceClient())
        //    {
        //        lst = sv.SelectCampanias(paisId);
        //    }

        //    return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        //}

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

        //private int TieneVariedad(string codigo, string cuv)
        //{
        //    var tieneVariedad = 0;
        //    switch (codigo)
        //    {
        //        case Constantes.TipoEstrategiaSet.IndividualConTonos:
        //            List<ServiceODS.BEProducto> listaHermanosE;
        //            using (var svc = new ODSServiceClient())
        //            {
        //                listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, cuv).ToList();
        //            }
        //            tieneVariedad = listaHermanosE.Any() ? 1 : 0;
        //            break;
        //        case Constantes.TipoEstrategiaSet.CompuestaVariable:
        //            tieneVariedad = 1;
        //            break;
        //    }

        //    return tieneVariedad;
        //}

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

        //private IEnumerable<PaisModel> DropDowListPaises()
        //{
        //    List<BEPais> lst;
        //    using (var sv = new ZonificacionServiceClient())
        //    {
        //        lst = userData.RolID == 2 ? sv.SelectPaises().ToList() : new List<BEPais> { sv.SelectPais(userData.PaisID) };
        //    }

        //    return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        //}

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

        #endregion

        #region Metodos Obsoletos

        //[Obsolete("No se usa")]
        //public static bool IsNumeric(object expression)
        //{
        //    double retNum;
        //    var isNum = Double.TryParse(Convert.ToString(expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
        //    return isNum;
        //}

        //[Obsolete("No se usa")]
        //public ActionResult DetalleOfertaCUV(string query)
        //{
        //    var ofertaId = 0;

        //    if (GetIsMobileDevice())
        //    {
        //        return RedirectToAction("DetalleOfertaCUV", "ShowRoom", new { area = "Mobile", query });
        //    }

        //    if (string.IsNullOrEmpty(query))
        //    {
        //        return RedirectToAction("DetalleOferta", "ShowRoom", new { id = ofertaId });
        //    }

        //    var srQsv = new ShowRoomQueryStringValidator(query);

        //    if ((srQsv.CodigoConsultora != userData.CodigoConsultora && srQsv.CodigoIso != userData.CodigoISO) ||
        //        (srQsv.CodigoProceso != CodigoProceso))
        //    {
        //        return RedirectToAction("Index", "Bienvenida");
        //    }

        //    ofertaId = srQsv.OfertaId;

        //    if (srQsv.CampanaId == userData.CampaniaID && !GetEventoConsultoraRecibido(userData))
        //    {
        //        UpdShowRoomEventoConsultoraEmailRecibido(srQsv.CodigoConsultora, srQsv.CampanaId, userData);
        //    }

        //    return RedirectToAction("DetalleOferta", "ShowRoom", new { id = ofertaId });
        //}

        //[Obsolete("No se usa")]
        //public JsonResult ObtenerImagenesByCodigoSAP(int paisId, string codigoSap)
        //{
        //    List<BEMatrizComercial> lst;
        //    List<BEMatrizComercial> lstFinal = new List<BEMatrizComercial>();

        //    using (var sv = new PedidoServiceClient())
        //    {
        //        lst = sv.GetImagenesByCodigoSAP(paisId, codigoSap).ToList();
        //    }

        //    var carpetaPais = ObtenerCarpetaPais();
        //    if (lst.Count > 0)
        //    {
        //        lstFinal.Add(new BEMatrizComercial
        //        {
        //            IdMatrizComercial = lst[0].IdMatrizComercial,
        //            CodigoSAP = lst[0].CodigoSAP,
        //            Descripcion = lst[0].Descripcion,
        //            PaisID = lst[0].PaisID
        //        });

        //        if (lst[0].FotoProducto != "")
        //            lstFinal[0].FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

        //        if (lst[1].FotoProducto != "")
        //            lstFinal[0].FotoProducto02 = ConfigS3.GetUrlFileS3(carpetaPais, lst[1].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

        //        if (lst[2].FotoProducto != "")
        //            lstFinal[0].FotoProducto03 = ConfigS3.GetUrlFileS3(carpetaPais, lst[2].FotoProducto, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
        //    }
        //    return Json(new
        //    {
        //        lista = lstFinal
        //    }, JsonRequestBehavior.AllowGet);
        //}

        //[Obsolete("Migrado Zona Estrategias")]
        //public JsonResult ObtenterCampaniasPorPais(int paisId)
        //{
        //    var lst = DropDowListCampanias(paisId);

        //    return Json(new
        //    {
        //        lista = lst,
        //    }, JsonRequestBehavior.AllowGet);
        //}

        //[Obsolete("Migrado Zona Estrategias")]
        //public JsonResult ObtenerParametroPersonalizacion(int paisId)
        //{
        //    var datos = GetTablaLogicaDatos(Constantes.TablaLogica.Plan20);

        //    var campaniaMinimaPersonalizacion = "";
        //    if (datos.Any())
        //    {
        //        var par = datos.FirstOrDefault(d => d.TablaLogicaDatosID == Constantes.TablaLogicaDato.PersonalizacionShowroom);
        //        if (par != null)
        //        {
        //            campaniaMinimaPersonalizacion = par.Codigo;
        //        }
        //    }

        //    return Json(new
        //    {
        //        campaniaMinimaPersonalizacion
        //    }, JsonRequestBehavior.AllowGet);
        //}

        //[Obsolete("Migrado Zona Estrategias")]
        //[HttpPost]
        //public JsonResult GuardarImagenShowRoom(int eventoId, string nombreImagen, string nombreImagenAnterior, int tipo)
        //{
        //    string nombreImagenFinal = "";

        //    try
        //    {
        //        string tempImage01 = nombreImagen ?? "";
        //        nombreImagen = nombreImagen ?? "";
        //        nombreImagenAnterior = nombreImagenAnterior ?? "";

        //        string soloImagen = nombreImagen.Split('.')[0];
        //        string soloExtension = nombreImagen.Split('.')[1];

        //        string iso = Util.GetPaisISO(userData.PaisID);
        //        var carpetaPais = Globals.UrlMatriz + "/" + iso;

        //        bool esNuevo = nombreImagenAnterior == "";

        //        if (nombreImagen != nombreImagenAnterior)
        //        {
        //            string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() +
        //                          DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
        //            var newfilename = iso + "_" + soloImagen + "_" + time + "_" + "01" + "_" +
        //                              FileManager.RandomString() + "." + soloExtension;

        //            nombreImagenFinal = newfilename;

        //            if (!esNuevo) ConfigS3.DeleteFileS3(carpetaPais, nombreImagenAnterior);
        //            ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage01), carpetaPais, newfilename);
        //        }

        //        using (var sv = new PedidoServiceClient())
        //        {
        //            sv.GuardarImagenShowRoom(userData.PaisID, eventoId, nombreImagenFinal, tipo,
        //                userData.CodigoConsultora);
        //        }

        //        return Json(new
        //        {
        //            success = true,
        //            message = "Se registro la imagen satisfactoriamente.",
        //            extra = nombreImagenFinal
        //        });
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //}

        #endregion
    }
}
