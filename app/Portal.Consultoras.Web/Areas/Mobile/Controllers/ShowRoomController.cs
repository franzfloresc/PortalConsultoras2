using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ShowRoomController : BaseShowRoomController
    {
        #region Variables

        private const string keyFechaGetCantidadProductos = "fechaGetCantidadProductos";
        private const string keyCantidadGetCantidadProductos = "cantidadGetCantidadProductos";

        #endregion

        public ActionResult Index()
        {
            var showRoomEventoModel = OfertaShowRoom();

            return showRoomEventoModel == null
                ? (ActionResult) RedirectToAction("Index", "Bienvenida", new {area = "Mobile"})
                : View(showRoomEventoModel);
        }
        public ActionResult Intriga()
        {
            //Session[keyFechaGetCantidadProductos] = null;
            //Session[keyCantidadGetCantidadProductos] = null;

            var userData = UserData();
            try
            {
                var model = new ShowRoomOfertaModel();

                var listaShowRoomOferta = new List<BEShowRoomOferta>();
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora).ToList();
                }

                if (listaShowRoomOferta.Any())
                {
                    listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                    listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));

                    var listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);
                 
                    model = listaShowRoomOfertaModel.FirstOrDefault();

                    ViewBag.Descripcion = model.Descripcion;
                    ViewBag.ImagenProducto = model.ImagenProducto;
                    ViewBag.PrecioOferta = model.PrecioOferta;
                    ViewBag.PrecioCatalogo = model.PrecioCatalogo;
                    ViewBag.CUV = model.CUV;
                    ViewBag.CategoriaID = model.CategoriaID;
                    ViewBag.ConfiguracionOfertaID = model.ConfiguracionOfertaID;
                    ViewBag.DescripcionMarca = model.DescripcionMarca;
                    ViewBag.MarcaID = model.MarcaID;
                    ViewBag.CodigoCampania = model.CodigoCampania;
                    ViewBag.Simbolo = userData.Simbolo;

                    ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                    var dateFuture = new DateTime(showRoomBannerLateral.AnioFaltante, showRoomBannerLateral.MesFaltante, showRoomBannerLateral.DiasFaltantes);
                    DateTime dateNow = DateTime.Now;
                    var seconds = Math.Floor((dateFuture - (dateNow)).TotalSeconds);
                    var minutes = Math.Floor(seconds / 60);
                    var hours = Math.Floor(minutes / 60);
                    var days = Math.Floor(hours / 24);

                    if (Convert.ToInt32(days) == 0 && hours > 0)
                    {
                        showRoomBannerLateral.DiasFaltantes = 1;
                    }
                    else
                    {
                        showRoomBannerLateral.DiasFaltantes = Convert.ToInt32(days);
                    }

                       // showRoomBannerLateral.DiasFaltantes = Convert.ToInt32(days);

                    if (days > 1)
                    {
                        showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍAS";
                    }
                    else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍA"; }

                    ViewBag.LetrasDias = showRoomBannerLateral.LetrasDias;
                    ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;

                    var showRoomOfertaModel = model;

                }

                return model == null
               ? (ActionResult)RedirectToAction("Index", "Bienvenida", new { area = "Mobile" })
               : View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return null;
        }

        public ActionResult ListadoProductoShowRoom(int id = 0)
        {
            var showRoomEventoModel = OfertaShowRoom();
            if (showRoomEventoModel != null)
                showRoomEventoModel.PosicionCarrusel = id;            

            return showRoomEventoModel == null
                ? (ActionResult) RedirectToAction("Index", "Bienvenida", new {area = "Mobile"})
                : View("ListadoProductoShowRoom", showRoomEventoModel);
        }
        
        private ShowRoomEventoModel OfertaShowRoom()
        {
            Session[keyFechaGetCantidadProductos] = null;
            Session[keyCantidadGetCantidadProductos] = null;

            var userData = UserData();

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
                    return null;
                }
                else
                {
                    if (showRoomEventoConsultora == null)
                    {
                        return null;
                    }
                    else
                    {
                        int diasAntes = showRoomEvento.DiasAntes;
                        int diasDespues = showRoomEvento.DiasDespues;

                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                        if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-diasAntes).Date &&
                              fechaHoy <= userData.FechaInicioCampania.AddDays(diasDespues).Date))
                        {
                            var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                listaShowRoomOferta = sv.GetShowRoomOfertasConsultora(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora).ToList();

                                if (listaShowRoomOferta != null)
                                {
                                    listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                    listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                }
                            }    

                            Mapper.CreateMap<BEShowRoomEvento, ShowRoomEventoModel>()
                                .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                                .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                                .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                                .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento));

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
                                .ForMember(t => t.ImagenMini, f => f.MapFrom(c => c.ImagenMini))
                                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID));

                            var showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                            showRoomEventoModel.Simbolo = userData.Simbolo;
                            showRoomEventoModel.CodigoIso = userData.CodigoISO;
                            showRoomEventoModel.FormatoCampania = userData.CampaniaID.ToString();

                            var listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);

                            listaShowRoomOfertaModel.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

                            using (PedidoServiceClient sv = new PedidoServiceClient())
                            {
                                foreach (var item in listaShowRoomOfertaModel)
                                {
                                    var listaDetalle = sv.GetProductosShowRoomDetalle(userData.PaisID, userData.CampaniaID, item.CUV).ToList();

                                    if (listaDetalle != null)
                                    {
                                        listaDetalle.Update(x => x.Imagen = string.IsNullOrEmpty(x.Imagen)
                                                    ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.Imagen, Globals.UrlMatriz + "/" + userData.CodigoISO));

                                        Mapper.CreateMap<BEShowRoomOfertaDetalle, ShowRoomOfertaDetalleModel>()
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

                                        var listaDetalleOfertaShowRoom = Mapper.Map<List<BEShowRoomOfertaDetalle>, List<ShowRoomOfertaDetalleModel>>(listaDetalle);
                                        item.ListaDetalleOfertaShowRoom = listaDetalleOfertaShowRoom;
                                    }
                                }
                            }

                            showRoomEventoModel.ListaShowRoomOferta = listaShowRoomOfertaModel;

                            return showRoomEventoModel;
                        }
                        else
                        {
                            return null;
                        }
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return null;
        }
        
        public ActionResult DetalleOferta(int id)
        {
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var modelo = GetOfertaConDetalle(id);
            return View( modelo);
        }
    }
}
