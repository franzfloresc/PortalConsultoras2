using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Microsoft.Ajax.Utilities;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Controllers
{
    public class ShowRoomController : BaseController
    {
        public ActionResult DetalleSet()
        {
            return View();
        }
        public ActionResult Intriga()
        {
            var showRoomEvento = new BEShowRoomEvento();
            var showRoomEventoConsultora = new BEShowRoomEventoConsultora();

            if (!userData.CargoEntidadesShowRoom) throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");
            showRoomEventoConsultora = userData.BeShowRoomConsultora;
            showRoomEvento = userData.BeShowRoom;

            if (showRoomEvento == null || showRoomEventoConsultora == null)
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var model = new ShowRoomOfertaModel();

            if (showRoomEvento.Estado == 1)
            {
                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                if (fechaHoy >= userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Date
                    && fechaHoy <= userData.FechaInicioCampania.AddDays(showRoomEvento.DiasDespues).Date)
                {
                    return RedirectToAction("Index", "ShowRoom");
                }

                ViewBag.DiasFaltan = userData.FechaInicioCampania.AddDays(-showRoomEvento.DiasAntes).Day - fechaHoy.Day;
                if (ViewBag.DiasFaltan <= 0)
                {
                    return RedirectToAction("Index", "Bienvenida");
                }

                var listaShowRoomOferta = new List<BEShowRoomOferta>();
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    var CodigoConsultora = userData.UsuarioPrueba == 1 ? userData.CodigoConsultora.ToString() : userData.CodigoConsultora.ToString();
                    listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, userData.CampaniaID, CodigoConsultora).ToList();
                }

                if (listaShowRoomOferta.Any())
                {
                    listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                    listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));

                    var listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);
                    model = listaShowRoomOfertaModel.FirstOrDefault();
                }

                model.CodigoISO = userData.CodigoISO;

                var lstPersonalizacion = userData.ListaShowRoomPersonalizacionConsultora.Where(x => x.TipoAplicacion == "Desktop").ToList();
                ViewBag.urlImagenPopupIntriga = string.Empty;
                ViewBag.urlTerminosyCondiciones = string.Empty;

                foreach (var item in lstPersonalizacion)
                {
                    if (item.Atributo == "BannerImagenIntriga") ViewBag.urlImagenPopupIntriga = item.Valor;
                    if (item.Atributo == "UrlTerminosCondiciones") ViewBag.urlTerminosyCondiciones = item.Valor;
                }
            }
            else
            {
                return RedirectToAction("Index", "Bienvenida");
            }
            
            return View(model);
        }

        public ActionResult Index()
        {
            ViewBag.TerminoMostrar = 1;
            
            try
            {
                var showRoomEvento = new BEShowRoomEvento();
                var showRoomEventoConsultora = new BEShowRoomEventoConsultora();
                var listaShowRoomOferta = new List<BEShowRoomOferta>();

                if (!userData.CargoEntidadesShowRoom) throw new Exception("Ocurrió un error al intentar traer la información de los evento y consultora de ShowRoom.");
                showRoomEventoConsultora = userData.BeShowRoomConsultora;
                showRoomEvento = userData.BeShowRoom;

                if (showRoomEvento == null)
                {
                    return RedirectToAction("Index", "Bienvenida");
                }
                else
                {
                    if (showRoomEventoConsultora == null)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }
                    else
                    {
                        if (showRoomEvento.Estado == 1)
                        {
                            int diasAntes = showRoomEvento.DiasAntes;
                            int diasDespues = showRoomEvento.DiasDespues;

                            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                            if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date && fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date))
                            {
                                var codigoConsultora = userData.CodigoConsultora;                                

                                Mapper.CreateMap<BEShowRoomEvento, ShowRoomEventoModel>()
                                    .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                                    .ForMember(t => t.Tema, f => f.MapFrom(c => c.Tema))
                                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                                    .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                                    .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                                    .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento));                                   

                                ShowRoomEventoModel showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                                showRoomEventoModel.Simbolo = userData.Simbolo;
                                showRoomEventoModel.CodigoIso = userData.CodigoISO;                                
                                
                                showRoomEventoModel.ListaShowRoomOferta = ObtenerListaProductoShowRoom(userData.CampaniaID, codigoConsultora);

                                return View(showRoomEventoModel);
                            }
                            else
                            {
                                return RedirectToAction("Index", "Bienvenida");
                            }
                        }
                        else
                        {
                            return RedirectToAction("Index", "Bienvenida");
                        }
                    }
                }
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

        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            //PaisID = 11;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            IEnumerable<ConfiguracionOfertaModel> lstConfig = DropDowListConfiguracion(PaisID);
            return Json(new
            {
                lista = lst,
                lstConfig = lstConfig
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

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
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

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                        select new
                        {
                            id = a.EventoID,
                            cell = new[]
                            {
                                a.EventoID.ToString(),
                                a.Nombre,
                                a.Tema,
                                a.DiasAntes.ToString(),
                                a.DiasDespues.ToString(),
                                a.NumeroPerfiles.ToString(),
                                a.Imagen1,
                                a.Imagen2,
                                a.ImagenCabeceraProducto,
                                a.ImagenVentaSetPopup,
                                a.ImagenVentaTagLateral,
                                a.ImagenPestaniaShowRoom,
                                a.ImagenPreventaDigital,
                                a.CampaniaID.ToString(),
                                a.Descuento.ToString(),
                                a.TextoEstrategia,
                                a.OfertaEstrategia.ToString(),
                                a.Estado.ToString(),
                                a.TieneCategoria.ToString()
                            }
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

                if (listaShowRoomNivel.Count <= 0)
                {
                    return Json(new
                    {
                        success = true,
                        message = "OK",
                        data = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        message = "OK",
                        data = listaShowRoomNivel
                    });
                }
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

                if (listaCategorias.Count <= 0)
                {
                    return Json(new
                    {
                        success = true,
                        message = "OK",
                        data = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        message = "OK",
                        data = listaCategorias
                    });
                }
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

                if (listaShowRoomPerfil == null || listaShowRoomPerfil.Count <= 0)
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
                Mapper.CreateMap<ShowRoomEventoModel, BEShowRoomEvento>()
                .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento))
                .ForMember(t => t.OfertaEstrategia, f => f.MapFrom(c => c.OfertaEstrategia))
                .ForMember(t => t.TextoEstrategia, f => f.MapFrom(c => c.TextoEstrategia))
                .ForMember(t => t.Tema, f => f.MapFrom(c => c.Tema))
                .ForMember(t => t.DiasAntes, f => f.MapFrom(c => c.DiasAntes))
                .ForMember(t => t.DiasDespues, f => f.MapFrom(c => c.DiasDespues))
                .ForMember(t => t.NumeroPerfiles, f => f.MapFrom(c => c.NumeroPerfiles))
                .ForMember(t => t.ImagenCabeceraProducto, f => f.MapFrom(c => c.ImagenCabeceraProducto))
                .ForMember(t => t.ImagenVentaSetPopup, f => f.MapFrom(c => c.ImagenVentaSetPopup))
                .ForMember(t => t.ImagenVentaTagLateral, f => f.MapFrom(c => c.ImagenVentaTagLateral))
                .ForMember(t => t.ImagenPestaniaShowRoom, f => f.MapFrom(c => c.ImagenPestaniaShowRoom))
                .ForMember(t => t.ImagenPreventaDigital, f => f.MapFrom(c => c.ImagenPreventaDigital))                
                .ForMember(t => t.Estado, f => f.MapFrom(c => c.Estado))
                .ForMember(t => t.TieneCategoria, f => f.MapFrom(c => c.TieneCategoria));

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
                        // 1664 - Gestion de contenido S3
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

                    using (StreamReader sr = new StreamReader(finalPath))
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
                                    ent.PrecioOferta = decimal.Parse(values[4].Trim().Replace("\"", ""));
                                    ent.UnidadesPermitidas = int.Parse(values[5].Trim().Replace("\"", ""));
                                    ent.Descripcion = values[6].Trim().Replace("\"", "");
                                    ent.CodigoCategoria = values[7].Trim().Replace("\"", "");
                                    ent.TipNegocio = values[8].Trim().Replace("\"", "");

                                    if (ent.Stock >= 0)
                                        lstStock.Add(ent);
                                }
                            }
                        }
                    }
                    if (lstStock.Count > 0)
                    {
                        lstStock.Update(x => x.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom);
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
                                //ent.NombreSet = values[1].Trim().Replace("\"", "");
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

        public ActionResult ConsultarOfertaShowRoom(string sidx, string sord, int page, int rows, int PaisID, string codigoOferta, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEShowRoomOferta> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetProductosShowRoom(PaisID, Constantes.ConfiguracionOferta.ShowRoom, CampaniaID, codigoOferta).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEShowRoomOferta> items = lst;

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

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                string ISO = Util.GetPaisISO(PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                lst.Update(x => x.ImagenProducto = x.ImagenProducto.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + ISO));
                lst.Update(x => x.ImagenMini = x.ImagenMini.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.RutaImagenesMatriz + "/" + ISO));
                lst.Update(x => x.ISOPais = ISO);
                // Creamos la estructura
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
                                   a.ImagenMini,
                                   a.CampaniaID.ToString() ,
                                   a.Stock.ToString(),
                                   a.UnidadesPermitidas.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.OfertaShowRoomID.ToString(),
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

        public JsonResult ObtenerImagenesByCodigoSAP(int paisID, string codigoSAP)
        {
            List<BEMatrizComercial> lst = new List<BEMatrizComercial>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByCodigoSAP(paisID, codigoSAP).ToList();
            }

            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (lst != null && lst.Count > 0)
            {
                if (lst[0].FotoProducto01 != "")
                    lst[0].FotoProducto01 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto01, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[0].FotoProducto02 != "")
                    lst[0].FotoProducto02 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto02, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);

                if (lst[0].FotoProducto03 != "")
                    lst[0].FotoProducto03 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto03, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
            }
            return Json(new
            {
                lista = lst
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
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
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
                    .ForMember(t => t.FlagAgotado, f => f.MapFrom(c => c.Agotado));

                BEShowRoomOferta entidad = Mapper.Map<ShowRoomOfertaModel, BEShowRoomOferta>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {

                    int Stock = 0;
                    Stock = sv.ValidadStockOfertaShowRoom(userData.PaisID, entidad);

                    if (entidad.Incrementa == 1 && Stock < 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "La cantidad ingresada supera el stock actual.",
                            extra = ""
                        });
                    }

                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.ShowRoom;
                    entidad.ConfiguracionOfertaID = lstConfiguracion.Find(x => x.CodigoOferta == model.CodigoTipoOferta).ConfiguracionOfertaID;
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

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string CUV)
        {
            int UnidadesPermitidas = 0;
            int Saldo = 0;
            /* 2024 - Inicio */
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
                CantidadPedida
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
                    .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID));


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

                    sv.InsPedidoWebDetalleOferta(entidad);

                    Session["PedidoWeb"] = null;
                    Session["PedidoWebDetalle"] = null;
                }

                UpdPedidoWebMontosPROL();

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

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
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
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                string ISO = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + ISO;

                lst.Update(x => x.Imagen = x.Imagen.ToString().Equals(string.Empty) ? string.Empty : ConfigS3.GetUrlFileS3(carpetaPais, x.Imagen, Globals.RutaImagenesMatriz + "/" + ISO));
                
                // Creamos la estructura
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
                                   a.Imagen                                
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
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

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

        private string GetDescripcionMarca(int marcaId)
        {
            string result = string.Empty;

            switch (marcaId)
            {
                case 1:
                    result = "Lbel";
                    break;
                case 2:
                    result = "Esika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 4:
                    result = "S&M";
                    break;
                case 5:
                    result = "Home Collection";
                    break;
                case 6:
                    result = "Finart";
                    break;
                case 7:
                    result = "Generico";
                    break;
                case 8:
                    result = "Glance";
                    break;
                default:
                    result = "NO DISPONIBLE";
                    break;
            }

            return result;
        }

        private List<ShowRoomOfertaModel> ObtenerListaProductoShowRoom(int campaniaId, string codigoConsultora)
        {
            var listaShowRoomOferta = new List<BEShowRoomOferta>();
            var listaShowRoomOfertaModel = new List<ShowRoomOfertaModel>();

            if (Session[Constantes.ConstSession.CDRWeb] != null)
            {
                return (List<ShowRoomOfertaModel>)Session[Constantes.ConstSession.ListaProductoShowRoom];
            }

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, campaniaId, codigoConsultora).ToList();
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                if (listaShowRoomOferta != null)
                {
                    listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                    listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));
                }
            }

            Mapper.CreateMap<BEShowRoomOferta, ShowRoomOfertaModel>()
                .ForMember(t => t.OfertaShowRoomID, f => f.MapFrom(c => c.OfertaShowRoomID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                .ForMember(t => t.PrecioCatalogo, f => f.MapFrom(c => c.PrecioCatalogo))
                .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                .ForMember(t => t.StockInicial, f => f.MapFrom(c => c.StockInicial))
                .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
                .ForMember(t => t.CategoriaID, f => f.MapFrom(c => c.CategoriaID))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.ImagenMini, f => f.MapFrom(c => c.ImagenMini))
                .ForMember(t => t.CodigoCategoria, f => f.MapFrom(c => c.CodigoCategoria))
                .ForMember(t => t.TipNegocio, f => f.MapFrom(c => c.TipNegocio));
            
            listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);
            listaShowRoomOfertaModel.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

            //using (PedidoServiceClient sv = new PedidoServiceClient())
            //{
            //    foreach (var item in listaShowRoomOfertaModel)
            //    {
            //        var listaDetalle = sv.GetProductosShowRoomDetalle(userData.PaisID, userData.CampaniaID, item.CUV).ToList();

            //        if (listaDetalle != null)
            //        {
            //            listaDetalle.Update(x => x.Imagen = string.IsNullOrEmpty(x.Imagen)
            //                        ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.Imagen, Globals.UrlMatriz + "/" + userData.CodigoISO));

            //            Mapper.CreateMap<BEShowRoomOfertaDetalle, ShowRoomOfertaDetalleModel>()
            //            .ForMember(t => t.OfertaShowRoomDetalleID, f => f.MapFrom(c => c.OfertaShowRoomDetalleID))
            //            .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
            //            .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
            //            .ForMember(t => t.NombreProducto, f => f.MapFrom(c => c.NombreProducto))
            //            .ForMember(t => t.Descripcion1, f => f.MapFrom(c => c.Descripcion1))
            //            .ForMember(t => t.Descripcion2, f => f.MapFrom(c => c.Descripcion2))
            //            .ForMember(t => t.Descripcion3, f => f.MapFrom(c => c.Descripcion3))
            //            .ForMember(t => t.Imagen, f => f.MapFrom(c => c.Imagen))
            //            .ForMember(t => t.FechaCreacion, f => f.MapFrom(c => c.FechaCreacion))
            //            .ForMember(t => t.UsuarioCreacion, f => f.MapFrom(c => c.UsuarioCreacion))
            //            .ForMember(t => t.FechaModificacion, f => f.MapFrom(c => c.FechaModificacion))
            //            .ForMember(t => t.UsuarioModificacion, f => f.MapFrom(c => c.UsuarioModificacion));

            //            var listaDetalleOfertaShowRoom = Mapper.Map<List<BEShowRoomOfertaDetalle>, List<ShowRoomOfertaDetalleModel>>(listaDetalle);
            //            item.ListaDetalleOfertaShowRoom = listaDetalleOfertaShowRoom;
            //        }
            //    }
            //}

            Session[Constantes.ConstSession.ListaProductoShowRoom] = listaShowRoomOfertaModel;
            return listaShowRoomOfertaModel;
        }

        #region PL20-1310 : Comprar desde Página de Oferta

        public ActionResult DetalleOferta(int id)
        {
            var modelo = GetOfertaDetalle(id);
            return View("DetalleSet", modelo);
        }

        private ShowRoomOfertaModel GetOfertaYDetalle(int idOferta)
        {
            var ofertaShowRoomModelo = new ShowRoomOfertaModel();
            try
            {
                if (idOferta <= 0)
                    return ofertaShowRoomModelo;

                var ofertaShowRoom = new BEShowRoomOferta(); // cambiar por el metodo privado que obtiene el padre, en session
                var listaDetalle = new List<BEShowRoomOfertaDetalle>();
                int paisId = userData.PaisID;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    ofertaShowRoom = sv.GetShowRoomOfertaById(userData.PaisID, idOferta);
                }

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaDetalle = sv.GetProductosShowRoomDetalle(paisId, userData.CampaniaID, ofertaShowRoom.CUV).ToList();
                }

                ofertaShowRoomModelo = Mapper.Map<BEShowRoomOferta, ShowRoomOfertaModel>(ofertaShowRoom);
                ofertaShowRoomModelo.ListaDetalleOfertaShowRoom = Mapper.Map<List<BEShowRoomOfertaDetalle>, List<ShowRoomOfertaDetalleModel>>(listaDetalle);
            }
            catch (Exception ex)
            {
                throw;
            }
            return ofertaShowRoomModelo;

        }

        private List<ShowRoomOfertaModel> GetOfertaListadoExcepto(int idOferta)
        {
            var listaOferta = new List<ShowRoomOfertaModel>();
            try
            {
                if (idOferta <= 0) return listaOferta;

                // obtener listado de todos las ofertas show room excepto el idOferta(parametro)
                var listadoOfertasTodas = new List<ShowRoomOfertaModel>(); // cambiar por el metodo de jave, en session
                listaOferta = listadoOfertasTodas.Where(o => o.OfertaShowRoomID != idOferta).ToList();
            }
            catch (Exception ex)
            {
                throw;
            }
            return listaOferta;
        }

        #endregion
    }
}
