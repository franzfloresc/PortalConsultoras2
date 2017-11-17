using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
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
        private int OfertaID = 0;
        private bool blnRecibido = false;

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
            model.Suscripcion = (userData.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora()).Suscripcion;
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
            userData.ListaShowRoomPersonalizacionConsultora = userData.ListaShowRoomPersonalizacionConsultora ?? new List<ShowRoomPersonalizacionModel>();
            var personalizacionesDesktop = userData.ListaShowRoomPersonalizacionConsultora.Where(x => x.TipoAplicacion == "Desktop").ToList();
            foreach (var item in personalizacionesDesktop)
            {
                if (item.Atributo == Constantes.ShowRoomPersonalizacion.Desktop.BannerImagenIntriga)
                    ViewBag.urlImagenPopupIntriga = item.Valor;

                if (item.Atributo == Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones)
                    ViewBag.urlTerminosyCondiciones = item.Valor;
            }
        }

        public ActionResult Index(string query)
        {
            ViewBag.TerminoMostrar = 1;

            try
            {
                var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

                bool mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

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
                        return RedirectToAction("Index", "ShowRoom", new { area = "Mobile", query = query });
                    }

                    string param = Util.Decrypt(query);
                    string[] lista = param.Split(new char[] { ';' });

                    if (lista[2] != userData.CodigoConsultora && lista[1] != userData.CodigoISO)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }

                    if (lista[0] == CodigoProceso)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            blnRecibido = Convert.ToBoolean(sv.GetEventoConsultoraRecibido(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID));
                        }

                        if (Convert.ToInt32(lista[3]) == userData.CampaniaID && blnRecibido == false)
                        {
                            BEShowRoomEventoConsultora Entidad = new BEShowRoomEventoConsultora();

                            Entidad.CodigoConsultora = lista[2];
                            Entidad.CampaniaID = Convert.ToInt32(lista[3]);

                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, Entidad);
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

                using (SACServiceClient svc = new SACServiceClient())
                {
                    showRoomEventoModel.FiltersBySorting = svc.GetTablaLogicaDatos(userData.PaisID, 99).ToList();
                }

                var xlistaShowRoom = showRoomEventoModel.ListaShowRoomOferta.Where(x => x.EsSubCampania == false).ToList();
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

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerParametroPersonalizacion(int PaisID)
        {
            var datos = new List<BETablaLogicaDatos>();
            using (var svc = new SACServiceClient())
            {
                datos = svc.GetTablaLogicaDatos(PaisID, Constantes.TablaLogica.Plan20).ToList();
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

        public JsonResult ConsultarShowRoom(string sidx, string sord, int page, int rows, int PaisID, int campaniaID)
        {
            try
            {
                var showRoomEvento = new BEShowRoomEvento();
                var listaShowRoomEvento = new List<BEShowRoomEvento>();

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    showRoomEvento = sv.GetShowRoomEventoByCampaniaID(userData.PaisID, campaniaID);
                }

                if (showRoomEvento != null)
                {
                    string ISO = Util.GetPaisISO(PaisID);
                    var carpetaPais = Globals.UrlMatriz + "/" + ISO;

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

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, listaShowRoomEvento);

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
                var listaShowRoomNivel = userData.ListaShowRoomNivel ?? new List<BEShowRoomNivel>();

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
                var listaCategorias = new List<BEShowRoomCategoria>();

                using (PedidoServiceClient ps = new PedidoServiceClient())
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
                var listaShowRoomPerfil = new List<BEShowRoomPerfil>();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaShowRoomPerfil = sv.GetShowRoomPerfiles(paisId, eventoId).ToList();
                }

                listaShowRoomPerfil = listaShowRoomPerfil ?? new List<BEShowRoomPerfil>();

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
                    var idEventoNuevo = 0;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        beShowRoomEvento.UsuarioCreacion = userData.CodigoConsultora;
                        idEventoNuevo = sv.InsertShowRoomEvento(userData.PaisID, beShowRoomEvento);
                    }

                    return Json(new
                    {
                        success = true,
                        message = "ShowRoom Agregado correctamente",
                        data = idEventoNuevo
                    });
                }

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    beShowRoomEvento.UsuarioModificacion = userData.CodigoConsultora;
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
        public JsonResult DeshabilitarShowRoomEvento(int campaniaID, int eventoID)
        {
            try
            {
                BEShowRoomEvento beShowRoomEvento = new BEShowRoomEvento();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    beShowRoomEvento.UsuarioModificacion = userData.CodigoConsultora;
                    beShowRoomEvento.CampaniaID = campaniaID;
                    beShowRoomEvento.EventoID = eventoID;
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
        public JsonResult EliminarShowRoomEvento(int campaniaID, int eventoID)
        {
            try
            {
                BEShowRoomEvento beShowRoomEvento = new BEShowRoomEvento();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    beShowRoomEvento.CampaniaID = campaniaID;
                    beShowRoomEvento.EventoID = eventoID;
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
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    string tempImage01 = nombreImagen ?? "";
                    nombreImagen = nombreImagen ?? "";
                    nombreImagenAnterior = nombreImagenAnterior ?? "";

                    string soloImagen = nombreImagen.Split('.')[0];
                    string soloExtension = nombreImagen.Split('.')[1];

                    string ISO = Util.GetPaisISO(userData.PaisID);
                    var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                    bool esNuevo = nombreImagenAnterior == "";

                    if (nombreImagen != nombreImagenAnterior)
                    {
                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = ISO + "_" + soloImagen + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + "." + soloExtension;

                        nombreImagenFinal = newfilename;

                        if (!esNuevo)
                            ConfigS3.DeleteFileS3(carpetaPais, nombreImagenAnterior);
                        ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage01), carpetaPais, newfilename);
                    }

                    sv.GuardarImagenShowRoom(userData.PaisID, eventoId, nombreImagenFinal, tipo, userData.CodigoConsultora);
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
        public string CargarMasivaConsultora(HttpPostedFileBase flCargarConsultoras, int hdCargaEventoID, int hdCargaCampaniaID)
        {
            string message = string.Empty;
            int registros = 0;

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                string finalPath = string.Empty;
                List<BEShowRoomEventoConsultora> listaConsultoras = new List<BEShowRoomEventoConsultora>();

                if (flCargarConsultoras != null)
                {
                    string fileName = Path.GetFileName(flCargarConsultoras.FileName);
                    string extension = Path.GetExtension(flCargarConsultoras.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    finalPath = Path.Combine(pathFile, newfileName);
                    flCargarConsultoras.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            values = inputLine.Split(',');
                            if (values.Length > 1)
                            {
                                BEShowRoomEventoConsultora ent = new BEShowRoomEventoConsultora();
                                ent.EventoID = hdCargaEventoID;
                                ent.CampaniaID = hdCargaCampaniaID;
                                ent.CodigoConsultora = values[0].Trim();
                                ent.Segmento = values[1].Trim();
                                ent.UsuarioCreacion = userData.CodigoConsultora;
                                ent.FechaCreacion = DateTime.Now;
                                ent.FechaModificacion = DateTime.Now;
                                listaConsultoras.Add(ent);
                            }
                        }
                    }

                    if (listaConsultoras.Count > 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            int paisID = userData.PaisID;
                            if (paisID > 0)
                            {
                                try
                                {
                                    registros += sv.CargarMasivaConsultora(paisID, listaConsultoras.ToArray());
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

        [HttpPost]
        public string ActualizarStockMasivo(HttpPostedFileBase flStock, int hdCargaStockEventoID)
        {
            string message = string.Empty;
            int registros = 0;
            try
            {
                #region Procesar Carga Masiva Archivo CSV
                string finalPath = string.Empty;
                List<BEShowRoomOferta> lstStock = new List<BEShowRoomOferta>();
                List<BEShowRoomCategoria> listaCategoria = new List<BEShowRoomCategoria>();

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
                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            values = inputLine.Split('|');
                            if (values.Length > 1)
                            {
                                if (IsNumeric(values[1].Trim()) && IsNumeric(values[3].Trim()))
                                {
                                    BEShowRoomOferta ent = new BEShowRoomOferta();
                                    ent.ISOPais = values[0].Trim().Replace("\"", ""); ;
                                    ent.CampaniaID = int.Parse(values[1].Trim().Replace("\"", ""));
                                    ent.CUV = values[2].Trim().Replace("\"", "");
                                    ent.Stock = int.Parse(values[3].Trim().Replace("\"", ""));
                                    ent.PrecioValorizado = decimal.Parse(values[4].Trim().Replace("\"", ""));
                                    ent.UnidadesPermitidas = int.Parse(values[5].Trim().Replace("\"", ""));
                                    ent.Descripcion = values[6].Trim().Replace("\"", "");
                                    ent.CodigoCategoria = values[7].Trim().Replace("\"", "");
                                    ent.TipNegocio = values[8].Trim().Replace("\"", "");
                                    ent.EsSubCampania = int.Parse(values[9].Trim().Replace("\"", "")) == 1;

                                    if (ent.Stock >= 0)
                                        lstStock.Add(ent);
                                }
                            }
                        }
                    }

                    if (lstStock.Count > 0)
                    {
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom);

                        var lstPrecioProductoPROL = new List<PrecioProducto>();
                        var stock1 = lstStock.First();
                        var codigosCuv = string.Join("|", lstStock.Select(x => x.CUV));

                        using (WsGestionWeb svc = new WsGestionWeb())
                        {
                            lstPrecioProductoPROL = svc.GetPrecioProductosOfertaWeb(stock1.ISOPais, stock1.CampaniaID.ToString(), codigosCuv).ToList();
                        }

                        stock1 = null;

                        if (lstPrecioProductoPROL.Any())
                        {
                            foreach (var item in lstPrecioProductoPROL)
                            {
                                var oStock = lstStock.Where(x => x.CUV == item.cuv).FirstOrDefault();
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

                            FaultException ex = new FaultException();
                            LogManager.LogManager.LogErrorWebServicesPortal(ex, "ERROR: CARGA PRODUCTO SHOWROOM", "CUV: " + productoPrecioCero.CUV + " con precio CERO");

                            return messageErrorPrecioCero;
                        }

                        List<BEShowRoomOferta> lstPaises = lstStock.GroupBy(x => x.ISOPais).Select(g => g.First()).ToList();

                        var categorias = lstStock.Select(p => p.CodigoCategoria).Distinct();
                        foreach (var item in categorias)
                        {
                            var beCategoria = new BEShowRoomCategoria();
                            beCategoria.Codigo = item;
                            beCategoria.Descripcion = item;
                            beCategoria.EventoID = hdCargaStockEventoID;
                            listaCategoria.Add(beCategoria);
                        }

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.DeleteInsertShowRoomCategoriaByEvento(userData.PaisID, hdCargaStockEventoID, listaCategoria.ToArray());
                        }

                        for (int i = 0; i < lstPaises.Count; i++)
                        {
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                List<BEShowRoomOferta> lstStockTemporal = lstStock.FindAll(x => x.ISOPais == lstPaises[i].ISOPais);
                                int paisID = Util.GetPaisID(lstPaises[i].ISOPais);
                                if (paisID > 0)
                                {
                                    try
                                    {
                                        registros += sv.UpdOfertaShowRoomStockMasivo(paisID, lstStockTemporal.ToArray());
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
        public string ActualizarDescripcionSetsMasivo(HttpPostedFileBase flDescripcionSets, int hdCargaDescripcionSetsEventoID, int hdCargaDescripcionSetsCampaniaID)
        {
            string message = string.Empty;
            int registros = 0;

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                string finalPath = string.Empty;
                List<BEShowRoomOfertaDetalle> listaDescripcionSets = new List<BEShowRoomOfertaDetalle>();

                if (flDescripcionSets != null)
                {
                    string fileName = Path.GetFileName(flDescripcionSets.FileName);
                    string extension = Path.GetExtension(flDescripcionSets.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    finalPath = Path.Combine(pathFile, newfileName);
                    flDescripcionSets.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            values = inputLine.Split('|');
                            if (values.Length > 1)
                            {
                                BEShowRoomOfertaDetalle ent = new BEShowRoomOfertaDetalle();
                                ent.CUV = values[0].Trim().Replace("\"", "");
                                ent.Posicion = values[1].Replace("\"", "0").ToInt();
                                ent.NombreProducto = values[2].Trim().Replace("\"", "");
                                ent.Descripcion1 = values[3].Trim().Replace("\"", "");
                                ent.Descripcion2 = values[4].Trim().Replace("\"", "");
                                ent.Descripcion3 = values[5].Trim().Replace("\"", "");
                                ent.MarcaProducto = values[6].Trim().Replace("\"", "");
                                ent.FechaCreacion = DateTime.Now;
                                ent.UsuarioCreacion = userData.CodigoConsultora;
                                ent.FechaModificacion = DateTime.Now;

                                listaDescripcionSets.Add(ent);
                            }
                        }
                    }

                    if (listaDescripcionSets.Count > 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            int paisID = userData.PaisID;
                            if (paisID > 0)
                            {
                                try
                                {
                                    registros += sv.CargarMasivaDescripcionSets(paisID, hdCargaDescripcionSetsCampaniaID, userData.CodigoConsultora, listaDescripcionSets.ToArray());
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
        public string CargarProductoCpc(HttpPostedFileBase flCargarProductoCpc, int hdCargarProductoCpcEventoID,
            int hdCargarProductoCpcCampaniaID)
        {
            string message = string.Empty;
            int registros = 0;

            try
            {
                #region Procesar Carga Masiva Consultoras Archivo CSV

                string finalPath = string.Empty;
                List<BEShowRoomCompraPorCompra> listaProductoCpc = new List<BEShowRoomCompraPorCompra>();

                if (flCargarProductoCpc != null)
                {
                    string fileName = Path.GetFileName(flCargarProductoCpc.FileName);
                    string extension = Path.GetExtension(flCargarProductoCpc.FileName);
                    string newfileName = string.Format("{0}{1}", Guid.NewGuid().ToString(), extension);
                    string pathFile = Server.MapPath("~/Content/FileShowRoomCargaConsultora");

                    if (!Directory.Exists(pathFile))
                        Directory.CreateDirectory(pathFile);
                    finalPath = Path.Combine(pathFile, newfileName);
                    flCargarProductoCpc.SaveAs(finalPath);

                    string inputLine = "";

                    string[] values = null;

                    int contador = 0;

                    using (StreamReader sr = new StreamReader(finalPath, Encoding.GetEncoding("iso-8859-1")))
                    {
                        while ((inputLine = sr.ReadLine()) != null)
                        {
                            if (contador == 0)
                            {
                                contador++;
                                continue;
                            }

                            values = inputLine.Split('|');
                            if (values.Length > 1)
                            {
                                BEShowRoomCompraPorCompra ent = new BEShowRoomCompraPorCompra();
                                ent.CUV = values[0].Trim().Replace("\"", "");
                                ent.SAP = values[1].Replace("\"", "0");
                                ent.Orden = values[2].Trim().Replace("\"", "").ToInt();
                                ent.PrecioValorizado = decimal.Parse(values[3].Trim().Replace("\"", ""));

                                listaProductoCpc.Add(ent);
                            }
                        }
                    }

                    if (listaProductoCpc.Count > 0)
                    {
                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            int paisID = userData.PaisID;
                            if (paisID > 0)
                            {
                                try
                                {
                                    registros += sv.CargarProductoCpc(paisID, hdCargarProductoCpcEventoID, userData.CodigoConsultora, listaProductoCpc.ToArray());
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
            userData.BeShowRoomConsultora.MostrarPopup = false;
            userData.BeShowRoomConsultora.MostrarPopupVenta = false;
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
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.UpdateShowRoomConsultoraMostrarPopup(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, !noMostrarPopup);
                }

                userData.CargoEntidadesShowRoom = false;
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

        public ActionResult ConsultarOfertaShowRoom(string sidx, string sord, int page, int rows, int PaisID, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEShowRoomOferta> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosShowRoom(PaisID, CampaniaID).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                string ISO = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                lst.Update(x => x.ImagenProducto = x.ImagenProducto.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + ISO));
                lst.Update(x => x.ImagenMini = x.ImagenMini.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.RutaImagenesMatriz + "/" + ISO));
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

        public JsonResult ObtenerImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            List<BEMatrizComercial> lst = new List<BEMatrizComercial>();
            List<BEMatrizComercial> lstFinal = new List<BEMatrizComercial>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAP(paisID, codigoSAP).ToList();
            }

            var carpetaPais = ObtenerCarpetaPais();
            lstFinal.Add(new BEMatrizComercial
            {
                IdMatrizComercial = lst[0].IdMatrizComercial,
                CodigoSAP = lst[0].CodigoSAP,
                Descripcion = lst[0].Descripcion,
                PaisID = lst[0].PaisID
            });

            if (lst != null && lst.Count > 0)
            {
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

        public JsonResult ValidarPriorizacion(int paisID, string codigoOferta, int CampaniaID, int Orden)
        {
            int FlagExiste = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                int ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == codigoOferta).ConfiguracionOfertaID;
                FlagExiste = sv.ValidarPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID, Orden);
            }

            return Json(new
            {
                FlagExiste = FlagExiste
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerOrdenPriorizacion(int paisID, int ConfiguracionOfertaID, int CampaniaID)
        {
            int Orden = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Orden = sv.GetOrdenPriorizacionShowRoom(paisID, ConfiguracionOfertaID, CampaniaID);
            }

            return Json(new
            {
                Orden = Orden
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaShowRoom(ShowRoomOfertaModel model)
        {
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioValorizado, f => f.MapFrom(c => c.PrecioValorizado))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta))
                    .ForMember(t => t.ImagenMini, f => f.MapFrom(c => c.ImagenMini));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.UsuarioRegistro = userData.CodigoConsultora;

                    string imagenProductoFinal = GuardarImagenAmazon(model.ImagenProducto, model.ImagenProductoAnterior, userData.PaisID);
                    string imagenMiniFinal = GuardarImagenAmazon(model.ImagenMini, model.ImagenMiniAnterior, userData.PaisID);

                    entidad.ImagenProducto = imagenProductoFinal;
                    entidad.ImagenMini = imagenMiniFinal;

                    sv.InsOfertaShowRoom(userData.PaisID, entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se insertó la Oferta ShowRoom satisfactoriamente.",
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
        public JsonResult UpdateOfertaShowRoom(ShowRoomOfertaModel model)
        {
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioValorizado, f => f.MapFrom(c => c.PrecioValorizado))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta))
                    .ForMember(t => t.ImagenMini, f => f.MapFrom(c => c.ImagenMini))
                    .ForMember(t => t.Incrementa, f => f.MapFrom(c => c.Incrementa))
                    .ForMember(t => t.CantidadIncrementa, f => f.MapFrom(c => c.CantidadIncrementa))
                    .ForMember(t => t.FlagAgotado, f => f.MapFrom(c => c.Agotado))
                    .ForMember(t => t.EsSubCampania, f => f.MapFrom(c => c.EsSubCampania));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.UsuarioModificacion = userData.CodigoConsultora;

                    string imagenProductoFinal = GuardarImagenAmazon(model.ImagenProducto, model.ImagenProductoAnterior, userData.PaisID);
                    string imagenMiniFinal = GuardarImagenAmazon(model.ImagenMini, model.ImagenMiniAnterior, userData.PaisID);

                    entidad.ImagenProducto = imagenProductoFinal;
                    entidad.ImagenMini = imagenMiniFinal;

                    sv.UpdOfertaShowRoom(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Oferta Show Room satisfactoriamente.",
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
        public JsonResult DeshabilitarOfertaShowRoom(ShowRoomOfertaModel model)
        {
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
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

        [HttpPost]
        public JsonResult RemoverOfertaShowRoom(ShowRoomOfertaModel model)
        {
            try
            {
                Mapper.CreateMap<ShowRoomOfertaModel, BEShowRoomOferta>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                    .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.UsuarioModificacion = userData.CodigoConsultora;
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

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV, string PrecioUnidad, string Cantidad)
        {
            int UnidadesPermitidas = 0;
            int Saldo = 0;
            int CantidadPedida = 0;
            var entidad = new BEOfertaProducto();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.CUV = CUV;
            entidad.ConsultoraID = Convert.ToInt32(userData.ConsultoraID);

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                UnidadesPermitidas = sv.GetUnidadesPermitidasByCuvShowRoom(userData.PaisID, userData.CampaniaID, CUV);
                Saldo = sv.ValidarUnidadesPermitidasEnPedidoShowRoom(userData.PaisID, userData.CampaniaID, CUV, userData.ConsultoraID);
                CantidadPedida = sv.CantidadPedidoByConsultoraShowRoom(entidad);
            }

            return Json(new
            {
                UnidadesPermitidas,
                Saldo,
                CantidadPedida,
                message = ""
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerStockActualProducto(string CUV)
        {
            int Stock = 0;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                Stock = sv.GetStockOfertaShowRoom(userData.PaisID, userData.CampaniaID, CUV);
            }

            return Json(new
            {
                Stock
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InsertOfertaWebPortal(PedidoDetalleModel model)
        {
            try
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

                Mapper.CreateMap<PedidoDetalleModel, BEPedidoWebDetalle>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                    .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                    .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                    .ForMember(t => t.PrecioUnidad, f => f.MapFrom(c => c.PrecioUnidad))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                    .ForMember(t => t.OrigenPedidoWeb, f => f.MapFrom(c => c.OrigenPedidoWeb));

                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.IPUsuario = userData.IPUsuario;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                    entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

                    sv.InsPedidoWebDetalleOferta(entidad);

                    sessionManager.SetPedidoWeb(null);
                    sessionManager.SetDetallesPedido(null);
                }

                UpdPedidoWebMontosPROL();

                if (entidad != null)
                {
                    BEIndicadorPedidoAutentico indPedidoAutentico = new BEIndicadorPedidoAutentico();
                    indPedidoAutentico.PedidoID = entidad.PedidoID;
                    indPedidoAutentico.CampaniaID = entidad.CampaniaID;
                    indPedidoAutentico.PedidoDetalleID = entidad.PedidoDetalleID;
                    indPedidoAutentico.IndicadorIPUsuario = GetIPCliente();
                    indPedidoAutentico.IndicadorFingerprint = "";
                    indPedidoAutentico.IndicadorToken = (Session["TokenPedidoAutentico"] != null) ? Session["TokenPedidoAutentico"].ToString() : ""; ;

                    InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);
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
        public JsonResult InsertOfertaWebPortalCpc(PedidoDetalleModel model)
        {
            try
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

                Mapper.CreateMap<PedidoDetalleModel, BEPedidoWebDetalle>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                    .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                    .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                    .ForMember(t => t.PrecioUnidad, f => f.MapFrom(c => c.PrecioUnidad))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                    .ForMember(t => t.OrigenPedidoWeb, f => f.MapFrom(c => c.OrigenPedidoWeb));

                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.OfertaWeb = false;
                    entidad.ConfiguracionOfertaID = 0;
                    entidad.TipoOfertaSisID = 0;
                    entidad.SubTipoOfertaSisID = 0;
                    entidad.EsSugerido = false;
                    entidad.EsKitNueva = false;
                    entidad.IPUsuario = userData.IPUsuario;
                    entidad.EsCompraPorCompra = true;

                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                    entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

                    sv.InsPedidoWebDetalleOferta(entidad);

                    sessionManager.SetPedidoWeb(null);
                    sessionManager.SetDetallesPedido(null);
                }

                UpdPedidoWebMontosPROL();

                if (entidad != null)
                {
                    BEIndicadorPedidoAutentico indPedidoAutentico = new BEIndicadorPedidoAutentico();
                    indPedidoAutentico.PedidoID = entidad.PedidoID;
                    indPedidoAutentico.CampaniaID = entidad.CampaniaID;
                    indPedidoAutentico.PedidoDetalleID = entidad.PedidoDetalleID;
                    indPedidoAutentico.IndicadorIPUsuario = GetIPCliente();
                    indPedidoAutentico.IndicadorFingerprint = "";
                    indPedidoAutentico.IndicadorToken = (Session["TokenPedidoAutentico"] != null) ? Session["TokenPedidoAutentico"].ToString() : ""; ;

                    InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);
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

        public string GuardarImagenAmazon(string nombreImagen, string nombreImagenAnterior, int paisId)
        {
            string nombreImagenFinal = "";

            string tempImage01 = nombreImagen ?? "";
            nombreImagen = nombreImagen ?? "";
            nombreImagenAnterior = nombreImagenAnterior ?? "";

            string ISO = Util.GetPaisISO(paisId);
            var carpetaPais = Globals.UrlMatriz + "/" + ISO;

            bool esNuevo = nombreImagenAnterior == "";

            if (nombreImagen != nombreImagenAnterior)
            {
                string soloImagen = nombreImagen.Split('.')[0];
                string soloExtension = nombreImagen.Split('.')[1];

                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                var newfilename = ISO + "_" + soloImagen + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + "." + soloExtension;

                nombreImagenFinal = newfilename;

                if (!esNuevo)
                    ConfigS3.DeleteFileS3(carpetaPais, nombreImagenAnterior);
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, tempImage01), carpetaPais, newfilename);
            }
            else
            {
                nombreImagenFinal = nombreImagen;
            }

            return nombreImagenFinal;
        }

        public ActionResult ConsultarOfertaShowRoomDetalle(string sidx, string sord, int page, int rows, int campaniaId, string cuv)
        {
            if (ModelState.IsValid)
            {
                List<BEShowRoomOfertaDetalle> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosShowRoomDetalle(userData.PaisID, campaniaId, cuv).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                string ISO = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                lst.Update(x => x.Imagen = x.Imagen.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.Imagen, Globals.RutaImagenesMatriz + "/" + ISO));

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

        [HttpPost]
        public JsonResult InsertOfertaShowRoomDetalle(ShowRoomOfertaDetalleModel model)
        {
            try
            {
                Mapper.CreateMap<ShowRoomOfertaDetalleModel, BEShowRoomOfertaDetalle>()
                    .ForMember(t => t.OfertaShowRoomDetalleID, f => f.MapFrom(c => c.OfertaShowRoomDetalleID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.NombreProducto, f => f.MapFrom(c => c.NombreProducto))
                    .ForMember(t => t.Descripcion1, f => f.MapFrom(c => c.Descripcion1))
                    .ForMember(t => t.Descripcion2, f => f.MapFrom(c => c.Descripcion2))
                    .ForMember(t => t.Descripcion3, f => f.MapFrom(c => c.Descripcion3))
                    .ForMember(t => t.MarcaProducto, f => f.MapFrom(c => c.MarcaProducto))
                    .ForMember(t => t.Imagen, f => f.MapFrom(c => c.Imagen))
                    .ForMember(t => t.FechaCreacion, f => f.MapFrom(c => c.FechaCreacion))
                    .ForMember(t => t.UsuarioCreacion, f => f.MapFrom(c => c.UsuarioCreacion))
                    .ForMember(t => t.FechaModificacion, f => f.MapFrom(c => c.FechaModificacion))
                    .ForMember(t => t.UsuarioModificacion, f => f.MapFrom(c => c.UsuarioModificacion));

                BEShowRoomOfertaDetalle entidad = Mapper.Map<ShowRoomOfertaDetalleModel, BEShowRoomOfertaDetalle>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.UsuarioCreacion = userData.CodigoConsultora;

                    string imagenFinal = GuardarImagenAmazon(model.Imagen, model.ImagenAnterior, userData.PaisID);

                    entidad.Imagen = imagenFinal;

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
        public JsonResult UpdateOfertaShowRoomDetalle(ShowRoomOfertaDetalleModel model)
        {
            try
            {
                Mapper.CreateMap<ShowRoomOfertaDetalleModel, BEShowRoomOfertaDetalle>()
                    .ForMember(t => t.OfertaShowRoomDetalleID, f => f.MapFrom(c => c.OfertaShowRoomDetalleID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.NombreProducto, f => f.MapFrom(c => c.NombreProducto))
                    .ForMember(t => t.Descripcion1, f => f.MapFrom(c => c.Descripcion1))
                    .ForMember(t => t.Descripcion2, f => f.MapFrom(c => c.Descripcion2))
                    .ForMember(t => t.Descripcion3, f => f.MapFrom(c => c.Descripcion3))
                    .ForMember(t => t.Imagen, f => f.MapFrom(c => c.Imagen))
                    .ForMember(t => t.FechaCreacion, f => f.MapFrom(c => c.FechaCreacion))
                    .ForMember(t => t.UsuarioCreacion, f => f.MapFrom(c => c.UsuarioCreacion))
                    .ForMember(t => t.FechaModificacion, f => f.MapFrom(c => c.FechaModificacion))
                    .ForMember(t => t.UsuarioModificacion, f => f.MapFrom(c => c.UsuarioModificacion));


                BEShowRoomOfertaDetalle entidad = Mapper.Map<ShowRoomOfertaDetalleModel, BEShowRoomOfertaDetalle>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.UsuarioModificacion = userData.CodigoConsultora;

                    string imagenFinal = GuardarImagenAmazon(model.Imagen, model.ImagenAnterior, userData.PaisID);

                    entidad.Imagen = imagenFinal;

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
        public JsonResult EliminarOfertaShowRoomDetalle(int ofertaShowRoomDetalleID, int campaniaID, string cuv)
        {
            try
            {
                BEShowRoomOfertaDetalle beShowRoomOfertaDetalle = new BEShowRoomOfertaDetalle();
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    beShowRoomOfertaDetalle.OfertaShowRoomDetalleID = ofertaShowRoomDetalleID;
                    beShowRoomOfertaDetalle.CampaniaID = campaniaID;
                    beShowRoomOfertaDetalle.CUV = cuv;
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
        public JsonResult EliminarOfertaShowRoomDetalleAll(int campaniaID, string cuv)
        {
            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.EliminarOfertaShowRoomDetalleAll(userData.PaisID, campaniaID, cuv);
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
        public JsonResult GetShowRoomPerfilOfertaCuvs(int campaniaId, int eventoId, int perfilId)
        {
            try
            {
                var listaShowRoomPerfilOferta = new List<BEShowRoomPerfilOferta>();
                BEShowRoomPerfilOferta beShowRoomPerfilOferta = new BEShowRoomPerfilOferta();
                beShowRoomPerfilOferta.CampaniaID = campaniaId;
                beShowRoomPerfilOferta.EventoID = eventoId;
                beShowRoomPerfilOferta.PerfilID = perfilId;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaShowRoomPerfilOferta = sv.GetShowRoomPerfilOfertaCuvs(userData.PaisID, beShowRoomPerfilOferta).ToList();
                }

                if (listaShowRoomPerfilOferta == null || listaShowRoomPerfilOferta.Count <= 0)
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
                using (PedidoServiceClient sv = new PedidoServiceClient())
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
                var listaPersonalizacion = userData.ListaShowRoomPersonalizacion.Where(
                        p => p.TipoPersonalizacion == Constantes.ShowRoomPersonalizacion.TipoPersonalizacion.Evento).ToList();

                var listaPersonalizacionNivel = new List<BEShowRoomPersonalizacionNivel>();

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    listaPersonalizacionNivel = ps.GetShowRoomPersonalizacionNivel(userData.PaisID, eventoId, nivelId, 0).ToList();
                }

                Mapper.CreateMap<BEShowRoomPersonalizacion, ShowRoomPersonalizacionModel>()
                   .ForMember(t => t.PersonalizacionId, f => f.MapFrom(c => c.PersonalizacionId))
                   .ForMember(t => t.TipoAplicacion, f => f.MapFrom(c => c.TipoAplicacion))
                   .ForMember(t => t.PersonalizacionId, f => f.MapFrom(c => c.PersonalizacionId))
                   .ForMember(t => t.Atributo, f => f.MapFrom(c => c.Atributo))
                   .ForMember(t => t.TextoAyuda, f => f.MapFrom(c => c.TextoAyuda))
                   .ForMember(t => t.TipoAtributo, f => f.MapFrom(c => c.TipoAtributo))
                   .ForMember(t => t.TipoPersonalizacion, f => f.MapFrom(c => c.TipoPersonalizacion))
                   .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                   .ForMember(t => t.Estado, f => f.MapFrom(c => c.Estado));

                var listaPersonalizacionModel = Mapper.Map<IList<BEShowRoomPersonalizacion>, IList<ShowRoomPersonalizacionModel>>(listaPersonalizacion);

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
                            string ISO = Util.GetPaisISO(userData.PaisID);
                            var carpetaPais = Globals.UrlMatriz + "/" + ISO;

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
                    model.Valor = model.Valor ?? "";
                    model.ValorAnterior = model.ValorAnterior ?? "";

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

                Mapper.CreateMap<ShowRoomPersonalizacionNivelModel, BEShowRoomPersonalizacionNivel>()
                    .ForMember(t => t.PersonalizacionNivelId, f => f.MapFrom(c => c.PersonalizacionNivelId))
                    .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                    .ForMember(t => t.CategoriaId, f => f.MapFrom(c => c.CategoriaId))
                    .ForMember(t => t.PersonalizacionId, f => f.MapFrom(c => c.PersonalizacionId))
                    .ForMember(t => t.NivelId, f => f.MapFrom(c => c.NivelId))
                    .ForMember(t => t.Valor, f => f.MapFrom(c => c.Valor));

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
                var categoria = new BEShowRoomCategoria();
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    categoria = ps.GetShowRoomCategoriaById(userData.PaisID, categoriaId);
                }

                categoria = categoria ?? new BEShowRoomCategoria();

                var listaPersonalizacion = userData.ListaShowRoomPersonalizacion.Where(
                        p => p.TipoPersonalizacion == Constantes.ShowRoomPersonalizacion.TipoPersonalizacion.Categoria).ToList();

                var listaPersonalizacionCategoria = new List<BEShowRoomPersonalizacionNivel>();

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    listaPersonalizacionCategoria = ps.GetShowRoomPersonalizacionNivel(userData.PaisID, eventoId, 0, categoriaId).ToList();
                }

                Mapper.CreateMap<BEShowRoomPersonalizacion, ShowRoomPersonalizacionModel>()
                   .ForMember(t => t.PersonalizacionId, f => f.MapFrom(c => c.PersonalizacionId))
                   .ForMember(t => t.TipoAplicacion, f => f.MapFrom(c => c.TipoAplicacion))
                   .ForMember(t => t.PersonalizacionId, f => f.MapFrom(c => c.PersonalizacionId))
                   .ForMember(t => t.Atributo, f => f.MapFrom(c => c.Atributo))
                   .ForMember(t => t.TextoAyuda, f => f.MapFrom(c => c.TextoAyuda))
                   .ForMember(t => t.TipoAtributo, f => f.MapFrom(c => c.TipoAtributo))
                   .ForMember(t => t.TipoPersonalizacion, f => f.MapFrom(c => c.TipoPersonalizacion))
                   .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                   .ForMember(t => t.Estado, f => f.MapFrom(c => c.Estado));

                var listaPersonalizacionModel = Mapper.Map<IList<BEShowRoomPersonalizacion>, IList<ShowRoomPersonalizacionModel>>(listaPersonalizacion);

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
                            string ISO = Util.GetPaisISO(userData.PaisID);
                            var carpetaPais = Globals.UrlMatriz + "/" + ISO;

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
                    categoria = categoria,
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
                Mapper.CreateMap<ShowRoomCategoriaModel, BEShowRoomCategoria>()
                  .ForMember(t => t.CategoriaId, f => f.MapFrom(c => c.CategoriaId))
                  .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                  .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                  .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

                var entidad = Mapper.Map<ShowRoomCategoriaModel, BEShowRoomCategoria>(model);

                using (PedidoServiceClient ps = new PedidoServiceClient())
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

        public static bool IsNumeric(object Expression)
        {
            bool isNum;
            double retNum;

            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }

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

        [HttpPost]
        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisID)
        {
            List<BEConfiguracionOferta> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstConfiguracion = sv.GetTipoOfertasAdministracion(paisID, Constantes.ConfiguracionOferta.ShowRoom).ToList();
                lst = lstConfiguracion;
            }
            Mapper.CreateMap<BEConfiguracionOferta, ConfiguracionOfertaModel>()
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.CodigoOferta, f => f.MapFrom(c => c.CodigoOferta))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        }

        #region Comprar desde Página de Oferta

        public ActionResult DetalleOfertaCUV(string query)
        {
            if (Request.Browser.IsMobileDevice)
            {
                return RedirectToAction("DetalleOfertaCUV", "ShowRoom", new { area = "Mobile", query = query });
            }

            if (query != null)
            {
                string param = Util.Decrypt(query);
                string[] lista = param.Split(new char[] { ';' });

                if (lista[2] != userData.CodigoConsultora && lista[1] != userData.CodigoISO)
                {
                    return RedirectToAction("Index", "Bienvenida");
                }

                if (lista[0] == CodigoProceso)
                {
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        blnRecibido = Convert.ToBoolean(sv.GetEventoConsultoraRecibido(userData.PaisID, userData.CodigoConsultora, userData.CampaniaID));
                    }

                    OfertaID = lista[5] != null ? Convert.ToInt32(lista[5]) : 0;

                    if (Convert.ToInt32(lista[3]) == userData.CampaniaID && blnRecibido == false)
                    {
                        BEShowRoomEventoConsultora Entidad = new BEShowRoomEventoConsultora();

                        Entidad.CodigoConsultora = lista[2];
                        Entidad.CampaniaID = Convert.ToInt32(lista[3]);

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.UpdShowRoomEventoConsultoraEmailRecibido(userData.PaisID, Entidad);
                        }

                    }
                }
                else
                {
                    return RedirectToAction("Index", "Bienvenida");
                }

            }


            return RedirectToAction("DetalleOferta", "ShowRoom", new { id = OfertaID });
        }

        public ActionResult DetalleOferta(int id)
        {
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var modelo = ViewDetalleOferta(id);

            var xList = modelo.ListaOfertaShowRoom.Where(x => x.EsSubCampania == false).ToList();
            modelo.ListaOfertaShowRoom = xList;

            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

            var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, userData.BeShowRoom.EventoID,
                        userData.BeShowRoom.CampaniaID);
            modelo.ListaShowRoomCompraPorCompra = listaCompraPorCompra;
            modelo.TieneCompraXcompra = userData.BeShowRoom.TieneCompraXcompra;

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
                if (!ValidarIngresoShowRoom(esIntriga: false))
                    return ErrorJson(string.Empty);

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
                var urlCompartir = GetUrlCompartirFB();

                var productosShowRoom = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, esFacturacion);
                productosShowRoom.ForEach(p => p.UrlCompartir = urlCompartir);

                var listaNoSubCampania = productosShowRoom.Where(x => !x.EsSubCampania).ToList();
                int totalNoSubCampania = listaNoSubCampania.Count;

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
                if (model.Ordenamiento != null)
                {
                    if (model.Ordenamiento.Tipo == Constantes.ShowRoomTipoOrdenamiento.Precio)
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
                }
                if (model.Limite > 0) listaNoSubCampania = listaNoSubCampania.Take(model.Limite).ToList();

                var listaSubCampania = productosShowRoom.Where(x => x.EsSubCampania).ToList();
                listaSubCampania.ForEach(p => p.ListaDetalleOfertaShowRoom = GetOfertaConDetalle(p.OfertaShowRoomID).ListaDetalleOfertaShowRoom);
                listaSubCampania = ValidarUnidadesPermitidas(listaSubCampania);
                return Json(new
                {
                    success = true,
                    message = "Ok",
                    listaNoSubCampania = listaNoSubCampania,
                    totalNoSubCampania = totalNoSubCampania,
                    listaSubCampania = listaSubCampania
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

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;
                var urlCompartir = GetUrlCompartirFB();

                var productosShowRoom = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora, esFacturacion);
                productosShowRoom.ForEach(p => p.UrlCompartir = urlCompartir);

                if (model.Limite > 0)
                {
                    if (productosShowRoom.Count > 0)
                        productosShowRoom = productosShowRoom.Where(x => x.EsSubCampania == false).Take(model.Limite).ToList();
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
                
                var showRoom = userData.BeShowRoom ?? new BEShowRoomEvento();

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var showRoomConsultora = userData.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();

                var personalizacionImagenIntriga = userData
                    .ListaShowRoomPersonalizacionConsultora
                    .FirstOrDefault(x => x.TipoAplicacion == TIPO_APLICACION_DESKTOP &&
                        x.Atributo == "PopupImagenIntriga");

                var imagenIntriga = personalizacionImagenIntriga.Valor;

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

                if (!userData.CargoEntidadesShowRoom)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = ""
                    });
                }

                var showRoom = userData.BeShowRoom ?? new BEShowRoomEvento();

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var showRoomConsultora = userData.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
                var mostrarPopupIntriga = showRoomConsultora.MostrarPopup;
                var mostrarPopupVenta = showRoomConsultora.MostrarPopupVenta;

                if (!mostrarPopupIntriga && !mostrarPopupVenta)
                {
                    return Json(new
                    {
                        success = false
                    });
                }

                var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

                mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
                mostrarPopupVenta = mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

                var rutaShowRoomPopup = string.Empty;
                if (mostrarShowRoomProductos)
                {
                    rutaShowRoomPopup = Url.Action("Index", "ShowRoom");
                }

                var personalizacionImagenIntriga = userData
                    .ListaShowRoomPersonalizacionConsultora
                    .FirstOrDefault(x => x.TipoAplicacion == TIPO_APLICACION_DESKTOP &&
                        x.Atributo == "PopupImagenIntriga");

                var imagenIntriga = personalizacionImagenIntriga.Valor;

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

                if ((userData.EMail != model.EMail) ||
                    (userData.EMail == model.EMail && !userData.EMailActivo))
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
            var cantidad = 0;
            using (UsuarioServiceClient svr = new UsuarioServiceClient())
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

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                sv.UpdateDatos(entidad, correoAnterior);
            }

            return entidad;
        }

        private void ActualizarUserData(ServiceUsuario.BEUsuario usuario)
        {
            userData.EMailActivo = usuario.EMail == userData.EMail ? userData.EMailActivo : false;
            userData.EMail = usuario.EMail;
            userData.Celular = usuario.Celular;
            SetUserData(userData);
        }

        private void EnviarConfirmacionCorreoShowRoom(MisDatosModel model)
        {
            const string UTM_NOMBRE_EVENTO = "{{NOMBRE_EVENTO}}";
            var parametros = new string[] {
                        userData.CodigoUsuario,
                        userData.PaisID.ToString(),
                        userData.CodigoISO,
                        model.EMail,
                        "UrlReturn,sr"
                    };
            var param_querystring = Util.Encrypt(string.Join(";", parametros));
            var request = HttpContext.Request;

            var esPaisEsika = WebConfig.PaisesEsika.Contains(userData.CodigoISO);

            var cadena = MailUtilities.CuerpoMensajePersonalizado(
                Util.GetUrlHost(HttpContext.Request).ToString(),
                userData.Sobrenombre,
                param_querystring,
                esPaisEsika);

            if (model.EnviarParametrosUTMs)
            {
                var nombreEvento = (userData.BeShowRoom != null && userData.BeShowRoom.Nombre != null) ?
                    userData.BeShowRoom.Nombre.Replace(" ", "") :
                    string.Empty;
                var utms = model.CadenaParametrosUTMs.Replace(UTM_NOMBRE_EVENTO, nombreEvento);
                cadena = cadena.Replace(".aspx?", ".aspx?" + utms + "&");
            }

            Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", model.EMail, "Confirmación de Correo", cadena, true, userData.NombreConsultora);
        }

        private void ProgramarAvisoShowRoom(MisDatosModel model)
        {
            userData.BeShowRoomConsultora = userData.BeShowRoomConsultora ?? new BEShowRoomEventoConsultora();
            userData.BeShowRoomConsultora.Suscripcion = true;
            userData.BeShowRoomConsultora.CorreoEnvioAviso = model.EMail;
            userData.BeShowRoomConsultora.CampaniaID = userData.CampaniaID;
            userData.BeShowRoomConsultora.CodigoConsultora = userData.CodigoConsultora;

            using (PedidoServiceClient sac = new PedidoServiceClient())
            {
                sac.ShowRoomProgramarAviso(userData.PaisID, userData.BeShowRoomConsultora);
            }
        }

        public ActionResult ConsultarTiposOferta(string sidx, string sord, int page, int rows)
        {
            if (ModelState.IsValid)
            {
                List<BEShowRoomTipoOferta> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetShowRoomTipoOferta(userData.PaisID).ToList();
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                BEPager pag = new BEPager();
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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

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
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult ExisteTipoOferta(BEShowRoomTipoOferta entity)
        {
            int resultado = -1;

            try
            {
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    resultado = ps.ExisteShowRoomTipoOferta(userData.PaisID, entity);
                }

                string message = resultado == 0
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
                string message = "";

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    entity.UsuarioCreacion = userData.CodigoConsultora;

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
                string message = "";

                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    ps.HabilitarShowRoomTipoOferta(userData.PaisID, entity);
                    message = "Tipo de Oferta ShowRoom " + (entity.Activo ? "Activado" : "Desactivado") + " correctamente";
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

        private List<ShowRoomOfertaModel> ValidarUnidadesPermitidas(List<ShowRoomOfertaModel> listaShowRoomOferta)
        {
            if (listaShowRoomOferta != null)
            {
                List<Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle> detalle = new List<Portal.Consultoras.Web.ServicePedido.BEPedidoWebDetalle>();
                if (sessionManager.GetDetallesPedido() != null)
                    detalle = sessionManager.GetDetallesPedido();
                if (detalle.Count > 0)
                {
                    for (int i = 0; i <= listaShowRoomOferta.Count - 1; i++)
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
    }
}
