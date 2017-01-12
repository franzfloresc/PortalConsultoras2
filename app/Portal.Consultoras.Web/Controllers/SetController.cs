using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Routing;
using System.Web.Mvc;
using System.Web.UI.HtmlControls;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class SetController: Controller
    {
        
        public ActionResult Index(string parameter)
        {
            var model = new ShowRoomOfertaModel();

            var array = parameter.Split('_');

            string codigoIso = array[0] ?? "";
            string idShowroomCadena = array[1] ?? "";
            string campania = array[2] ?? "";
            string redSocial = array[3] ?? "";

            int idShowRoom = 0;
            bool esId = int.TryParse(idShowroomCadena, out idShowRoom);

            int idFinal = esId ? idShowRoom : 0;

            int idCampania = 0;
            bool esCampania = int.TryParse(campania, out idCampania);

            int idCampaniaFinal = esCampania ? idCampania : 0;

            int paisId = Util.GetPaisID(codigoIso);

            var ofertaShowRoom = new BEShowRoomOferta();
            var listaDetalle = new List<BEShowRoomOfertaDetalle>();

            var carpetaPais = Globals.UrlMatriz + "/" + codigoIso;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                ofertaShowRoom = sv.GetShowRoomOfertaById(paisId, idFinal);
            }

            if (ofertaShowRoom != null)
            {
                if (string.IsNullOrEmpty(ofertaShowRoom.ImagenProducto))
                {
                    ofertaShowRoom.ImagenMini = "";
                    ofertaShowRoom.ImagenProducto = "";
                }
                else
                {
                    ofertaShowRoom.ImagenMini = ConfigS3.GetUrlFileS3(carpetaPais, ofertaShowRoom.ImagenMini,
                        Globals.UrlMatriz + "/" + codigoIso);
                    ofertaShowRoom.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, ofertaShowRoom.ImagenProducto,
                        Globals.UrlMatriz + "/" + codigoIso);
                }

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listaDetalle = sv.GetProductosShowRoomDetalle(paisId, idCampaniaFinal, ofertaShowRoom.CUV).ToList();
                }

                var subTitulo = "";
                var contadorDetalle = 1;
                foreach (var detalle in listaDetalle)
                {
                    subTitulo += contadorDetalle == listaDetalle.Count ? detalle.NombreProducto : detalle.NombreProducto + " + ";
                    contadorDetalle++;
                }

                ViewBag.MetaImageShowRoom = redSocial == "W" ? ofertaShowRoom.ImagenMini : ofertaShowRoom.ImagenProducto;
                ViewBag.MetaTitleShowRoom = ofertaShowRoom.Descripcion + ": " + subTitulo + ".";
                ViewBag.MetaImageSecureShowRoom = redSocial == "W" ? ofertaShowRoom.ImagenMini : ofertaShowRoom.ImagenProducto;                
                ViewBag.MetaSiteNameShowRoom = "Somos Belcorp";
                ViewBag.MetaDescripcionShowRoom = "Míralo Aquí";
                ViewBag.MetaTypeShowRoom = "article";

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
                    .ForMember(t => t.ImagenMini, f => f.MapFrom(c => c.ImagenMini));

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

                model = Mapper.Map<BEShowRoomOferta, ShowRoomOfertaModel>(ofertaShowRoom);
                model.Subtitulo = subTitulo + ".";

                var listaDetalleModel = Mapper.Map<List<BEShowRoomOfertaDetalle>, List<ShowRoomOfertaDetalleModel>>(listaDetalle);
                model.ListaDetalleOfertaShowRoom = listaDetalleModel;
            }

            return View(model);
        }
    }
}