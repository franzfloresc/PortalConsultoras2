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

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    showRoomEvento = sv.GetShowRoomEventoByCampaniaID(userData.PaisID, userData.CampaniaID);
                    showRoomEventoConsultora = sv.GetShowRoomConsultora(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora);
                    listaShowRoomOferta = sv.GetShowRoomOfertas(userData.PaisID, userData.CampaniaID).ToList();
                }

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
                        var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                        if ((fechaHoy >= userData.FechaInicioCampania.AddDays(-2).Date &&
                              fechaHoy <= userData.FechaInicioCampania.AddDays(1).Date))
                        {
                            var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                            showRoomEvento.Imagen1 = showRoomEvento.Imagen1 ?? "";
                            showRoomEvento.Imagen2 = showRoomEvento.Imagen2 ?? "";

                            showRoomEvento.Imagen1 = ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.Imagen1, Globals.UrlMatriz + "/" + UserData().CodigoISO);
                            showRoomEvento.Imagen2 = ConfigS3.GetUrlFileS3(carpetaPais, showRoomEvento.Imagen2, Globals.UrlMatriz + "/" + UserData().CodigoISO);

                            if (listaShowRoomOferta != null)
                            {
                                listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                listaShowRoomOferta.Update(x => x.ImagenProducto1 = string.IsNullOrEmpty(x.ImagenProducto1) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto1, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                listaShowRoomOferta.Update(x => x.ImagenProducto2 = string.IsNullOrEmpty(x.ImagenProducto2) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto2, Globals.UrlMatriz + "/" + userData.CodigoISO));
                                listaShowRoomOferta.Update(x => x.ImagenProducto3 = string.IsNullOrEmpty(x.ImagenProducto3) ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto3, Globals.UrlMatriz + "/" + userData.CodigoISO));
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
                                .ForMember(t => t.DescripcionProducto1, f => f.MapFrom(c => c.DescripcionProducto1))
                                .ForMember(t => t.DescripcionProducto2, f => f.MapFrom(c => c.DescripcionProducto2))
                                .ForMember(t => t.DescripcionProducto3, f => f.MapFrom(c => c.DescripcionProducto3))
                                .ForMember(t => t.ImagenProducto1, f => f.MapFrom(c => c.ImagenProducto1))
                                .ForMember(t => t.ImagenProducto2, f => f.MapFrom(c => c.ImagenProducto2))
                                .ForMember(t => t.ImagenProducto3, f => f.MapFrom(c => c.ImagenProducto3))
                                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID));

                            var showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                            showRoomEventoModel.Simbolo = userData.Simbolo;

                            var listaShowRoomOfertaModel = Mapper.Map<List<BEShowRoomOferta>, List<ShowRoomOfertaModel>>(listaShowRoomOferta);

                            listaShowRoomOfertaModel.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

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
