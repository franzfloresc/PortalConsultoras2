using AutoMapper;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;

namespace Portal.Consultoras.Web.Models.AutoMapper
{
    public class DomainToModelMappingProfile : Profile
    {
        public override string ProfileName
        {
            get { return "DomainToModelMappings"; }
        }

        protected override void Configure()
        {
            Mapper.CreateMap<BEPedidoWebDetalle, PedidoWebDetalleModel>()
                .ForMember(t => t.IPUsuario, f => f.MapFrom(c => c.IPUsuario))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                .ForMember(t => t.ClienteID, f => f.MapFrom(c => c.ClienteID))
                .ForMember(t => t.PedidoID, f => f.MapFrom(c => c.PedidoID))
                .ForMember(t => t.OfertaWeb, f => f.MapFrom(c => c.OfertaWeb))
                .ForMember(t => t.IndicadorMontoMinimo, f => f.MapFrom(c => c.IndicadorMontoMinimo))
                .ForMember(t => t.SubTipoOfertaSisID, f => f.MapFrom(c => c.SubTipoOfertaSisID))
                .ForMember(t => t.EsSugerido, f => f.MapFrom(c => c.EsSugerido))
                .ForMember(t => t.SubTipoOfertaSisID, f => f.MapFrom(c => c.SubTipoOfertaSisID))
                .ForMember(t => t.EsKitNueva, f => f.MapFrom(c => c.EsKitNueva))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                .ForMember(t => t.PrecioUnidad, f => f.MapFrom(c => c.PrecioUnidad))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.DescripcionProd, f => f.MapFrom(c => c.DescripcionProd))
                .ForMember(t => t.ImporteTotal, f => f.MapFrom(c => c.ImporteTotal))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                .ForMember(t => t.PedidoDetalleID, f => f.MapFrom(c => c.PedidoDetalleID))
                .ForMember(t => t.Flag, f => f.MapFrom(c => c.Flag))
                .ForMember(t => t.TipoPedido, f => f.MapFrom(c => c.TipoPedido))
                .ForMember(t => t.EliminadoTemporal, f => f.MapFrom(c => c.EliminadoTemporal))
                .ForMember(t => t.ImporteTotalPedido, f => f.MapFrom(c => c.ImporteTotalPedido))
                .ForMember(t => t.CodigoUsuarioCreacion, f => f.MapFrom(c => c.CodigoUsuarioModificacion))
                .ForMember(t => t.EstadoItem, f => f.MapFrom(c => c.EstadoItem))
                .ForMember(t => t.CUVNuevo, f => f.MapFrom(c => c.CUVNuevo))
                .ForMember(t => t.ClaseFila, f => f.MapFrom(c => c.ClaseFila))
                .ForMember(t => t.Mensaje, f => f.MapFrom(c => c.Mensaje))
                .ForMember(t => t.DescripcionOferta, f => f.MapFrom(c => c.DescripcionOferta))
                .ForMember(t => t.DescripcionLarga, f => f.MapFrom(c => c.DescripcionLarga))
                .ForMember(t => t.DescripcionLarga, f => f.MapFrom(c => c.Categoria))
                .ForMember(t => t.DescripcionEstrategia, f => f.MapFrom(c => c.DescripcionEstrategia))
                .ForMember(t => t.TipoEstrategiaID, f => f.MapFrom(c => c.TipoEstrategiaID))
                .ForMember(t => t.IndicadorOfertaCUV, f => f.MapFrom(c => c.IndicadorOfertaCUV))
                .ForMember(t => t.FlagConsultoraOnline, f => f.MapFrom(c => c.FlagConsultoraOnline))
                .ForMember(t => t.ClienteID_, f => f.MapFrom(c => c.ClienteID == 0 ? "-1" : c.ClienteID.ToString()));

            Mapper.CreateMap<BEOfertaNueva, OfertaNuevaModel>()
                .ForMember(t => t.OfertaNuevaId, f => f.MapFrom(c => c.OfertaNuevaId))
                .ForMember(t => t.NumeroPedido, f => f.MapFrom(c => c.NumeroPedido))
                .ForMember(t => t.ImagenProducto01, f => f.MapFrom(c => c.ImagenProducto01))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.IndicadorMontoMinimo, f => f.MapFrom(c => c.IndicadorMontoMinimo))
                .ForMember(t => t.DescripcionProd, f => f.MapFrom(c => c.DescripcionProd))
                .ForMember(t => t.PrecioNormal, f => f.MapFrom(c => c.PrecioNormal))
                .ForMember(t => t.PrecioParaTi, f => f.MapFrom(c => c.PrecioParaTi))
                .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                .ForMember(t => t.IndicadorPedido, f => f.MapFrom(c => c.IndicadorPedido));

            Mapper.CreateMap<BEEstrategia, EstrategiaPedidoModel>();

            Mapper.CreateMap<BEPedidoFICDetalle, PedidoWebDetalleModel>();

            Mapper.CreateMap<BEMisPedidos, ClienteOnlineModel>()
                .ForMember(t => t.SolicitudClienteID, f => f.MapFrom(c => c.PedidoId))
                .ForMember(t => t.ClienteNuevo, f => f.MapFrom(c => c.MarcaID > 0 || !c.FlagConsultora));

            Mapper.CreateMap<BEMotivoSolicitud, MisPedidosMotivoRechazoModel>();
            Mapper.CreateMap<BENotificacionesDetallePedido, NotificacionesModelDetallePedido>();

            Mapper.CreateMap<BELogGPRValidacion, NotificacionesModel>()
                .ForMember(t => t.Descuento, f => f.MapFrom(c => -c.Descuento))
                .ForMember(t => t.FechaValidacion, f => f.MapFrom(c => c.FechaFinValidacion));

            Mapper.CreateMap<BEMisPedidosDetalle, ClienteOnlineDetalleModel>()
                .ForMember(t => t.SolicitudClienteDetalleID, f => f.MapFrom(c => c.PedidoDetalleId));
            Mapper.CreateMap<BELogGPRValidacionDetalle, NotificacionesModelDetallePedido>()
                .ForMember(t => t.IndicadorOferta, f => f.MapFrom(c => c.IndicadorOferta ? 1 : 0));

            Mapper.CreateMap<BEMisPedidosDetalle, MisPedidosDetalleModel2>();

            Mapper.CreateMap<BERegion, RegionModel>();

            Mapper.CreateMap<BEZona, ZonaModel>();
            Mapper.CreateMap<MatrizComercialModel, BEMatrizComercial>();

            Mapper.CreateMap<Producto, ProductoModel>()
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.IdMarca))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.Cuv))
                .ForMember(t => t.DescripcionMarca, f => f.MapFrom(c => c.NombreMarca))
                .ForMember(t => t.CUVPedidoImagen, f => f.MapFrom(c => c.ImagenCUVPedido))
                .ForMember(t => t.CUVPedidoNombre, f => f.MapFrom(c => c.NombreCUVPedido));

            Mapper.CreateMap<ProductoModel, Producto>()
                .ForMember(t => t.IdMarca, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.Cuv, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.NombreMarca, f => f.MapFrom(c => c.DescripcionMarca));
        }
    }
}