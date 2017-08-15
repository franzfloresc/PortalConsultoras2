using AutoMapper;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Models.AutoMapper
{
    public class ModelToDomainMappingProfile : Profile
    {
        public override string ProfileName
        {
            get { return "ModelToDomainMappings"; }
        }

        protected override void Configure()
        {
            Mapper.CreateMap<PedidoDetalleModel, ServiceCliente.BECliente>()
                .ForMember(t => t.eMail, f => f.MapFrom(c => c.eMail))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre));

            Mapper.CreateMap<MatrizComercialModel, BEMatrizComercial>();
            
            Mapper.CreateMap<EstrategiaPedidoModel, BEEstrategia>()
                .ForMember(t => t.EstrategiaDetalle, f => f.MapFrom(c => c.EstrategiaDetalle))
                .ForMember(t => t.TipoEstrategia, f => f.MapFrom(c => c.TipoEstrategia));

            Mapper.CreateMap<EstrategiaDetalleModelo, BEEstrategiaDetalle>();

            Mapper.CreateMap<TipoEstrategiaModelo, BETipoEstrategia>()
                .ForMember(t => t.FlagActivo, f => f.MapFrom(c => c.FlagActivo ? 1 : 0));

            Mapper.CreateMap<ProductoModel, Producto>()
                .ForMember(t => t.IdMarca, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.Cuv, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.NombreMarca, f => f.MapFrom(c => c.DescripcionMarca));


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
            .ForMember(t => t.TieneCategoria, f => f.MapFrom(c => c.TieneCategoria))
            .ForMember(t => t.TieneCompraXcompra, f => f.MapFrom(c => c.TieneCompraXcompra))
            .ForMember(t => t.TieneSubCampania, f => f.MapFrom(c => c.TieneSubCampania));

            Mapper.CreateMap<MisDatosModel, ServiceUsuario.BEUsuario>()
                .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                .ForMember(t => t.EMail, f => f.MapFrom(c => c.EMail))
                .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono))
                .ForMember(t => t.TelefonoTrabajo, f => f.MapFrom(c => c.TelefonoTrabajo))
                .ForMember(t => t.Celular, f => f.MapFrom(c => c.Celular))
                .ForMember(t => t.Sobrenombre, f => f.MapFrom(c => c.Sobrenombre))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.NombreCompleto))
                .ForMember(t => t.CompartirDatos, f => f.MapFrom(c => c.CompartirDatos))
                .ForMember(t => t.AceptoContrato, f => f.MapFrom(c => c.AceptoContrato));

            Mapper.CreateMap<RegistrarEstrategiaModel, BEEstrategia>();
            Mapper.CreateMap<UsuarioModel, BEInputReservaProl>()
                .ForMember(t => t.PaisISO, f => f.MapFrom(c => c.CodigoISO))
                .ForMember(t => t.FechaHoraReserva, f => f.MapFrom(c => c.DiaPROL && c.MostrarBotonValidar))
                .ForMember(t => t.ProlV2, f => f.MapFrom(c => c.NuevoPROL && c.ZonaNuevoPROL));

            Mapper.CreateMap<UsuarioModel, ServicePedido.BEUsuario>()
                .ForMember(t => t.MontoMinimoFlexipago, f => f.Ignore());

            Mapper.CreateMap<AdministrarPalancaModel, ServiceSAC.BEConfiguracionPais > ();

        }
    }
}