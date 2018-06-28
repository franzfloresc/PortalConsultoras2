using AutoMapper;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Models.PagoEnLinea;

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

            Mapper.CreateMap<EstrategiaPedidoModel, ServicePedido.BEEstrategia>()
                .ForMember(t => t.EstrategiaDetalle, f => f.MapFrom(c => c.EstrategiaDetalle))
                .ForMember(t => t.TipoEstrategia, f => f.MapFrom(c => c.TipoEstrategia));

            Mapper.CreateMap<EstrategiaDetalleModelo, ServicePedido.BEEstrategiaDetalle>();

            Mapper.CreateMap<TipoEstrategiaModelo, ServicePedido.BETipoEstrategia>()
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

            Mapper.CreateMap<RegistrarEstrategiaModel, ServicePedido.BEEstrategia>();

            Mapper.CreateMap<UsuarioModel, BEInputReservaProl>()
                .ForMember(t => t.PaisISO, f => f.MapFrom(c => c.CodigoISO))
                .ForMember(t => t.FechaHoraReserva, f => f.MapFrom(c => c.DiaPROL && c.MostrarBotonValidar))
                .ForMember(t => t.SegmentoInternoID, f => f.MapFrom(c => c.SegmentoInternoID == null ? 0 : Convert.ToInt32(c.SegmentoInternoID)));

            Mapper.CreateMap<UsuarioModel, ServicePedido.BEUsuario>()
                .ForMember(t => t.FechaInicioFacturacion, f => f.MapFrom(c => c.FechaInicioCampania))
                .ForMember(t => t.FechaFinFacturacion, f => f.MapFrom(c => c.FechaFinCampania))
                .ForMember(t => t.MontoMinimoFlexipago, f => f.Ignore())
                .ForMember(t => t.OfertaDelDia, f => f.Ignore());

            Mapper.CreateMap<AdministrarPalancaModel, ServiceSAC.BEConfiguracionPais>();
            Mapper.CreateMap<ConfiguracionPaisDatosModel, ServiceUsuario.BEConfiguracionPaisDatos>();
            Mapper.CreateMap<AdministrarOfertasHomeModel, BEConfiguracionOfertasHome>();
            Mapper.CreateMap<DescripcionEstrategiaModel, BEDescripcionEstrategia>();

            Mapper.CreateMap<FiltroReportePedidoDDWebModel, BEPedidoDDWeb>()
                .ForMember(t => t.paisID, f => f.MapFrom(c => Convert.ToInt32(c.PaisID)))
                .ForMember(t => t.paisISO, f => f.MapFrom(c => c.CodigoISO))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => Convert.ToInt32(c.Campania)))
                .ForMember(t => t.RegionCodigo, f => f.MapFrom(c => c.RegionID))
                .ForMember(t => t.ZonaCodigo, f => f.MapFrom(c => c.ZonaID))
                .ForMember(t => t.Origen, f => f.MapFrom(c => Convert.ToInt32(c.Origen)))
                .ForMember(t => t.ConsultoraCodigo, f => f.MapFrom(c => string.IsNullOrEmpty(c.Consultora) || c.Consultora == "0" ? string.Empty : c.Consultora))
                .ForMember(t => t.EstadoValidacion, f => f.MapFrom(c => Convert.ToInt32(c.EstadoValidacion)))
                .ForMember(t => t.EsRechazado, f => f.MapFrom(c => Convert.ToInt32(c.EsRechazado)))
                .ForMember(t => t.FechaRegistroInicio, f => f.MapFrom(c => string.IsNullOrEmpty(c.FechaInicio) ? (DateTime?)null : DateTime.Parse(c.FechaInicio)))
                .ForMember(t => t.FechaRegistroFin, f => f.MapFrom(c => string.IsNullOrEmpty(c.FechaFin) ? (DateTime?)null : DateTime.Parse(c.FechaFin)));

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

            Mapper.CreateMap<ConfiguracionProgramaNuevasAppModel, BEConfiguracionProgramaNuevasApp>();

            Mapper.CreateMap<AdministrarBelcorpRespondeModel, BEBelcorpResponde>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.Telefono1, f => f.MapFrom(c => c.Telefono1))
                .ForMember(t => t.Telefono2, f => f.MapFrom(c => c.Telefono2))
                .ForMember(t => t.Escribenos, f => f.MapFrom(c => c.Escribenos))
                .ForMember(t => t.EscribenosURL, f => f.MapFrom(c => c.EscribenosURL))
                .ForMember(t => t.Correo, f => f.MapFrom(c => c.Correo))
                .ForMember(t => t.CorreoBcc, f => f.MapFrom(c => c.CorreoBcc))
                .ForMember(t => t.Chat, f => f.MapFrom(c => c.Chat))
                .ForMember(t => t.ChatURL, f => f.MapFrom(c => c.ChatURL))
                .ForMember(t => t.ParametroPais, f => f.MapFrom(c => c.ParametroPais))
                .ForMember(t => t.ParametroCodigoConsultora, f => f.MapFrom(c => c.ParametroCodigoConsultora));

            Mapper.CreateMap<ConfiguracionOfertaModel, BEConfiguracionOferta>()
                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                .ForMember(t => t.CodigoOferta, f => f.MapFrom(c => c.CodigoOferta))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.EstadoRegistro, f => f.MapFrom(c => c.EstadoRegistro));

            Mapper.CreateMap<AdministrarFeErratasModel, BEFeErratas>()
                .ForMember(t => t.FeErratasID, f => f.MapFrom(c => c.FeErratasID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Titulo, f => f.MapFrom(c => c.Titulo))
                .ForMember(t => t.Pagina, f => f.MapFrom(c => c.Pagina))
                .ForMember(t => t.Dice, f => f.MapFrom(c => c.Dice))
                .ForMember(t => t.DebeDecir, f => f.MapFrom(c => c.DebeDecir));

            Mapper.CreateMap<OfertaProductoModel, BEOfertaProducto>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
                .ForMember(t => t.TipoOferta, f => f.MapFrom(c => c.CodigoTipoOferta));

            Mapper.CreateMap<AdministracionOfertaProductoModel, BEAdministracionOfertaProducto>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.OfertaAdmID, f => f.MapFrom(c => c.OfertaAdmID))
                .ForMember(t => t.Correos, f => f.MapFrom(c => c.Correos))
                .ForMember(t => t.StockMinimo, f => f.MapFrom(c => c.StockMinimo));

            Mapper.CreateMap<AdministrarFactoresGananciaModel, BEFactorGanancia>()
                .ForMember(t => t.FactorGananciaID, f => f.MapFrom(c => c.FactorGananciaID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.RangoMinimo, f => f.MapFrom(c => c.RangoMinimo))
                .ForMember(t => t.RangoMaximo, f => f.MapFrom(c => c.RangoMaximo))
                .ForMember(t => t.Porcentaje, f => f.MapFrom(c => c.Porcentaje));

            Mapper.CreateMap<AdministrarIncentivosModel, BEIncentivo>()
                .ForMember(t => t.IncentivoID, f => f.MapFrom(c => c.IncentivoID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaIDInicio, f => f.MapFrom(c => c.CampaniaIDInicio))
                .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                .ForMember(t => t.Titulo, f => f.MapFrom(c => c.Titulo))
                .ForMember(t => t.Subtitulo, f => f.MapFrom(c => c.Subtitulo))
                .ForMember(t => t.ArchivoPortada, f => f.MapFrom(c => c.ArchivoPortada))
                .ForMember(t => t.ArchivoPortadaAnterior, f => f.MapFrom(c => c.ArchivoPortadaAnterior))
                .ForMember(t => t.ArchivoPDF, f => f.MapFrom(c => c.ArchivoPDF))
                .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

            Mapper.CreateMap<AdministrarLinkModel, ServiceSeguridad.BEPermiso>()
                .ForMember(t => t.PermisoID, f => f.MapFrom(c => c.PermisoID))
                .ForMember(t => t.OrdenItem, f => f.MapFrom(c => c.OrdenItem))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.UrlItem, f => f.MapFrom(c => c.UrlItem))
                .ForMember(t => t.Posicion, f => f.MapFrom(c => c.Posicion))
                .ForMember(t => t.PaginaNueva, f => f.MapFrom(c => c.PaginaNueva))
                .ForMember(t => t.IdPadre, f => f.MapFrom(c => c.PermisoIDPadre));

            Mapper.CreateMap<AdministrarProductoSugeridoModel, BEProductoSugerido>()
                .ForMember(t => t.ProductoSugeridoID, f => f.MapFrom(c => c.ProductoSugeridoID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.CUVSugerido, f => f.MapFrom(c => c.CUVSugerido))
                .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                .ForMember(t => t.Estado, f => f.MapFrom(c => c.Estado));

            Mapper.CreateMap<AdministrarBannerPedidoModel, BEBannerPedido>()
                .ForMember(t => t.BannerPedidoID, f => f.MapFrom(c => c.BannerPedidoID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaIDInicio, f => f.MapFrom(c => c.CampaniaIDInicio))
                .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                .ForMember(t => t.ArchivoPortada, f => f.MapFrom(c => c.ArchivoPortada))
                .ForMember(t => t.ArchivoPortadaAnterior, f => f.MapFrom(c => c.ArchivoPortadaAnterior))
                .ForMember(t => t.Archivo, f => f.MapFrom(c => c.Archivo))
                .ForMember(t => t.TipoUrl, f => f.MapFrom(c => c.grupoTipoUrl))
                .ForMember(t => t.Posicion, f => f.MapFrom(c => c.PosicionBannerPedido))
                .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

            Mapper.CreateMap<ProductoCompartidoModel, ServiceODS.BEProductoCompartido>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.mPaisID))
                .ForMember(t => t.PcCampaniaID, f => f.MapFrom(c => c.mCampaniaID))
                .ForMember(t => t.PcCuv, f => f.MapFrom(c => c.mCUV))
                .ForMember(t => t.PcPalanca, f => f.MapFrom(c => c.mPalanca))
                .ForMember(t => t.PcDetalle, f => f.MapFrom(c => c.mDetalle))
                .ForMember(t => t.PcApp, f => f.MapFrom(c => c.mApplicacion));

            Mapper.CreateMap<ConfiguracionValidacionZonaModel, BEConfiguracionValidacionZona>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID));

            Mapper.CreateMap<ConfiguracionValidacionModel, BEConfiguracionValidacion>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.DiasAntes, f => f.MapFrom(c => c.DiasAntes))
                .ForMember(t => t.HoraInicio, f => f.MapFrom(c => c.HoraInicio))
                .ForMember(t => t.HoraFin, f => f.MapFrom(c => c.HoraFin))
                .ForMember(t => t.HoraInicioNoFacturable, f => f.MapFrom(c => c.HoraInicioNoFacturable))
                .ForMember(t => t.HoraCierreNoFacturable, f => f.MapFrom(c => c.HoraCierreNoFacturable))
                .ForMember(t => t.FlagNoValidados, f => f.MapFrom(c => c.FlagNoValidados))
                .ForMember(t => t.ProcesoRegular, f => f.MapFrom(c => c.ProcesoRegular))
                .ForMember(t => t.ProcesoDA, f => f.MapFrom(c => c.ProcesoDA))
                .ForMember(t => t.ProcesoDAPRD, f => f.MapFrom(c => c.ProcesoDAPRD))
                .ForMember(t => t.HabilitarRestriccionHoraria, f => f.MapFrom(c => c.HabilitarRestriccionHoraria));

            Mapper.CreateMap<ConsultaPedidoModel, BEPedidoWeb>()
                .ForMember(t => t.PedidoID, f => f.MapFrom(c => c.PedidoID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                .ForMember(t => t.DescripcionBloqueo, f => f.MapFrom(c => c.DescripcionBloqueo));

            Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.FormularioDatoID, f => f.MapFrom(c => c.FormularioDatoID))
                .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

            Mapper.CreateMap<ConfiguracionCrossSellingModel, BEConfiguracionCrossSelling>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.HabilitarDiasValidacion, f => f.MapFrom(c => c.HabilitarDiasValidacion));

            Mapper.CreateMap<CrossSellingProductoModel, BECrossSellingProducto>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                .ForMember(t => t.MensajeProducto, f => f.MapFrom(c => c.MensajeProducto));

            Mapper.CreateMap<CrossSellingAsociacionModel, BECrossSellingAsociacion>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.CUVAsociado, f => f.MapFrom(c => c.CUVAsociado))
                .ForMember(t => t.CUVAsociado2, f => f.MapFrom(c => c.CUVAsociado2))
                .ForMember(t => t.CodigoSegmento, f => f.MapFrom(c => c.CodigoSegmento))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.EtiquetaPrecio, f => f.MapFrom(c => c.EtiquetaPrecio))
                .ForMember(t => t.CrossSellingAsociacionID, f => f.MapFrom(c => c.CrossSellingAsociacionID));

            Mapper.CreateMap<ConsultoraFicticiaModel, ServiceUsuario.BEUsuario>()
                .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

            Mapper.CreateMap<ConsultoraFicticiaModel, BEConsultoraFicticia>()
                .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.ActualizarClave, f => f.MapFrom(c => c.ActualizarClave))
                .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID));

            Mapper.CreateMap<OfertaFlexipagoModel, BEOfertaFlexipago>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
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
                .ForMember(t => t.PrecioNormal, f => f.MapFrom(c => c.PrecioNormal))
                .ForMember(t => t.LinksFlexipago, f => f.MapFrom(c => c.LinksFlexipago))
                .ForMember(t => t.UsuarioRegistro, f => f.MapFrom(c => c.UsuarioRegistro));

            Mapper.CreateMap<MatrizCampaniaModel, ServiceSAC.BEProductoDescripcion>();

            Mapper.CreateMap<MisReclamosModel, ServiceCDR.BECDRWebDetalle>()
                .ForMember(t => t.CDRWebDetalleID, f => f.MapFrom(c => c.CDRWebDetalleID))
                .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad));

            Mapper.CreateMap<RolModel, ServiceSeguridad.BERol>()
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.RolID, f => f.MapFrom(c => c.RolID))
                .ForMember(t => t.Sistema, f => f.MapFrom(c => c.Sistema))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

            Mapper.CreateMap<GestionFaltantesModel, BEProductoFaltante>()
               .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
               .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
               .ForMember(t => t.Zona, f => f.MapFrom(c => c.Zona))
               .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID));

            Mapper.CreateMap<CronogramaModel, BECronograma>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                .ForMember(t => t.TipoCronogramaID, f => f.MapFrom(c => c.TipoCronogramaID))
                .ForMember(t => t.FechaInicioWeb, f => f.MapFrom(c => c.FechaInicioWeb))
                .ForMember(t => t.FechaFinWeb, f => f.MapFrom(c => c.FechaFinWeb))
                .ForMember(t => t.FechaInicioDD, f => f.MapFrom(c => c.FechaInicioDD))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.FechaFinDD, f => f.MapFrom(c => c.FechaFinDD))
                .ForMember(t => t.CodigoZona, f => f.MapFrom(c => c.CodigoZona))
                .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania));

            Mapper.CreateMap<UsuarioRolModel, ServiceUsuario.BEUsuarioRol>()
                .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                .ForMember(t => t.RolID, f => f.MapFrom(c => c.RolID));

            Mapper.CreateMap<UsuarioRolModel, ServiceSeguridad.BEUsuarioRol>()
                .ForMember(t => t.RolID, f => f.MapFrom(c => c.RolID))
                .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario));

            Mapper.CreateMap<OfertaNuevaModel, BEOfertaNueva>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.CampaniaIDFin, f => f.MapFrom(c => c.CampaniaIDFin))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.NumeroPedido, f => f.MapFrom(c => c.NumeroPedido))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.PrecioNormal, f => f.MapFrom(c => c.PrecioNormal))
                .ForMember(t => t.PrecioParaTi, f => f.MapFrom(c => c.PrecioParaTi))
                .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                .ForMember(t => t.ImagenProducto01, f => f.MapFrom(c => c.ImagenProducto01))
                .ForMember(t => t.ImagenProducto02, f => f.MapFrom(c => c.ImagenProducto02))
                .ForMember(t => t.ImagenProducto03, f => f.MapFrom(c => c.ImagenProducto03))
                .ForMember(t => t.FlagImagenActiva, f => f.MapFrom(c => c.FlagImagenActiva))
                .ForMember(t => t.FlagHabilitarOferta, f => f.MapFrom(c => c.FlagHabilitarOferta))
                .ForMember(t => t.UsuarioRegistro, f => f.MapFrom(c => c.UsuarioRegistro))
                .ForMember(t => t.OfertaNuevaId, f => f.MapFrom(c => c.OfertaNuevaId))
                .ForMember(t => t.UsuarioModificacion, f => f.MapFrom(c => c.UsuarioModificacion))
                .ForMember(t => t.ganahasta, f => f.MapFrom(c => c.ganahasta));

            Mapper.CreateMap<CronogramaFICModel, ServiceZonificacion.BECronogramaFIC>()
                .ForMember(t => t.CodigoConsultora, f => f.MapFrom(c => c.CodigoConsultora))
                .ForMember(t => t.Zona, f => f.MapFrom(c => c.Zona))
                .ForMember(t => t.Campania, f => f.MapFrom(c => c.Campania))
                .ForMember(t => t.FechaFin, f => f.MapFrom(c => c.FechaFin));

            Mapper.CreateMap<ProveedorDespachoCobranzaModel, BEProveedorDespachoCobranza>()
                .ForMember(t => t.NombreComercial, f => f.MapFrom(c => c.NombreComercial))
                .ForMember(t => t.ProveedorDespachoCobranzaID, f => f.MapFrom(c => c.ProveedorDespachoCobranzaID))
                .ForMember(t => t.RazonSocial, f => f.MapFrom(c => c.RazonSocial))
                .ForMember(t => t.RFC, f => f.MapFrom(c => c.RFC))
                .ForMember(t => t.ProveedorDespachoCobranzaID, f => f.MapFrom(c => c.ProveedorDespachoCobranzaID))
                .ForMember(t => t.Accion, f => f.MapFrom(c => c.Accion))
                .ForMember(t => t.CampoId, f => f.MapFrom(c => c.CampoId))
                .ForMember(t => t.Valor, f => f.MapFrom(c => c.Valor))
                .ForMember(t => t.ValorAnterior, f => f.MapFrom(c => c.ValorAnterior));

            Mapper.CreateMap<ServicioModel, BEServicio>()
                .ForMember(t => t.ServicioId, f => f.MapFrom(c => c.ServicioId))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

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

            Mapper.CreateMap<ShowRoomCategoriaModel, BEShowRoomCategoria>()
                .ForMember(t => t.CategoriaId, f => f.MapFrom(c => c.CategoriaId))
                .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            Mapper.CreateMap<ShowRoomPersonalizacionNivelModel, BEShowRoomPersonalizacionNivel>()
                .ForMember(t => t.PersonalizacionNivelId, f => f.MapFrom(c => c.PersonalizacionNivelId))
                .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                .ForMember(t => t.CategoriaId, f => f.MapFrom(c => c.CategoriaId))
                .ForMember(t => t.PersonalizacionId, f => f.MapFrom(c => c.PersonalizacionId))
                .ForMember(t => t.NivelId, f => f.MapFrom(c => c.NivelId))
                .ForMember(t => t.Valor, f => f.MapFrom(c => c.Valor));

            Mapper.CreateMap<PedidoDetalleModel, BEPedidoWebDetalle>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CantidadAnterior, f => f.MapFrom(c => c.CantidadAnterior))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                .ForMember(t => t.PrecioUnidad, f => f.MapFrom(c => c.PrecioUnidad))
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Flag, f => f.MapFrom(c => c.Flag))
                .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                .ForMember(t => t.OrigenPedidoWeb, f => f.MapFrom(c => c.OrigenPedidoWeb));

            Mapper.CreateMap<EstrategiaProductoModel, ServicePedido.BEEstrategiaProducto>();

            Mapper.CreateMap<UpSellingModel, UpSelling>()
                .ForMember(t => t.Regalos, f => f.MapFrom(c => c.Regalos));

            Mapper.CreateMap<UpSellingRegaloModel, UpSellingDetalle>()
                .ForMember(t => t.UpSellingDetalleId, f => f.MapFrom(c => c.UpSellingRegaloId));

            Mapper.CreateMap<OfertaFinalRegaloModel, UpSellingRegalo>();

            Mapper.CreateMap<OfertaFinalMontoMetaModel, UpSellingMontoMeta>();

            Mapper.CreateMap<PagoEnLineaTipoPagoModel, BEPagoEnLineaTipoPago>();
            Mapper.CreateMap<PagoEnLineaMedioPagoModel, BEPagoEnLineaMedioPago>();
            Mapper.CreateMap<PagoEnLineaMedioPagoDetalleModel, BEPagoEnLineaMedioPagoDetalle>();
        }
    }
}