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
using Portal.Consultoras.Web.ServicePROLConsultas;
using System.Configuration;

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

            ActionExecutingMobile();

            var showRoomEventoModel = OfertaShowRoom();

            return showRoomEventoModel == null
                ? (ActionResult) RedirectToAction("Index", "Bienvenida", new {area = "Mobile"})
                : View(showRoomEventoModel);
        }

        public ActionResult Intriga()
        {
            if (ValidarIngresoShowRoom(true))
            {
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

                        
                        if (showRoomBannerLateral.DiasFaltantes > 1)
                        {
                            showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍAS";
                        }
                        else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFaltantes).ToString() + " DÍA"; }

                        ViewBag.LetrasDias = showRoomBannerLateral.LetrasDias;
                        ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;

                        ViewBag.EstadoActivo = showRoomBannerLateral.EstadoActivo;
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
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
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

            if (!ValidarIngresoShowRoom(false))
            {
                return null;
            }

            try
            {
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                var showRoomEvento = userData.BeShowRoom;
                var codigoConsultora = userData.CodigoConsultora;

                Mapper.CreateMap<BEShowRoomEvento, ShowRoomEventoModel>()
                    .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                    .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                    .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento));                

                var showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                showRoomEventoModel.Simbolo = userData.Simbolo;
                showRoomEventoModel.CodigoIso = userData.CodigoISO;
                showRoomEventoModel.FormatoCampania = userData.CampaniaID.ToString();

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                var listaShowRoomOferta = ObtenerListaProductoShowRoom(userData.CampaniaID, codigoConsultora, esFacturacion);
                var listaShowRoomOfertaModel = listaShowRoomOferta;

                //listaShowRoomOfertaModel.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

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

                var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, showRoomEventoModel.EventoID, showRoomEventoModel.CampaniaID);
                showRoomEventoModel.ListaShowRoomCompraPorCompra = listaCompraPorCompra;

                return showRoomEventoModel;                
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return null;
        }
        
        public ActionResult DetalleOferta(int id)
        {
            ActionExecutingMobile();
            if (!ValidarIngresoShowRoom(false))
                return RedirectToAction("Index", "Bienvenida");

            var modelo = ViewDetalleOferta(id);

            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

            var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, userData.BeShowRoom.EventoID,
                        userData.BeShowRoom.CampaniaID);
            modelo.ListaShowRoomCompraPorCompra = listaCompraPorCompra;
            modelo.TieneCompraXcompra = userData.BeShowRoom.TieneCompraXcompra;


            return View("DetalleOferta", modelo);
        }
    }
}
