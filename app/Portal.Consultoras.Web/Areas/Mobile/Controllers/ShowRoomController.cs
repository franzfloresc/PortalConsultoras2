using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ShowRoomController : BaseMobileController
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
    }
}
