using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceSeguridad;
using ServiceUsuario = Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Models.Pedido;
using System.Linq;

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
                .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                .ForMember(t => t.ClienteID, f => f.MapFrom(c => c.ClienteID))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                .ForMember(t => t.PedidoDetalleID, f => f.MapFrom(c => c.PedidoDetalleID))
                .ForMember(t => t.CodigoUsuarioCreacion, f => f.MapFrom(c => c.CodigoUsuarioModificacion))
                .ForMember(t => t.DescripcionLarga, f => f.MapFrom(c => c.DescripcionLarga))
                .ForMember(t => t.DescripcionLarga, f => f.MapFrom(c => c.Categoria))
                .ForMember(t => t.ClienteID_, f => f.MapFrom(c => c.ClienteID == 0 ? "-1" : c.ClienteID.ToString()))
                .ForMember(t => t.ListObservacionProl, f => f.MapFrom(c => (c.ObservacionPROL ?? "").Split('|').Where(o => !string.IsNullOrEmpty(o)).ToList()));

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

            Mapper.CreateMap<ServicePedido.BEEstrategia, EstrategiaPedidoModel>()
                .ForMember(t => t.EstrategiaDetalle, f => f.MapFrom(c => c.EstrategiaDetalle))
                .ForMember(t => t.TipoEstrategia, f => f.MapFrom(c => c.TipoEstrategia));

            Mapper.CreateMap<ServicePedido.BEEstrategiaDetalle, EstrategiaDetalleModelo>();

            Mapper.CreateMap<ServicePedido.BETipoEstrategia, TipoEstrategiaModelo>()
                .ForMember(t => t.FlagActivo, f => f.MapFrom(c => c.FlagActivo == 1));

            Mapper.CreateMap<ServicePedido.BETipoEstrategia, TipoEstrategiaModel>()
                .ForMember(t => t.TipoEstrategiaID, f => f.MapFrom(c => c.TipoEstrategiaID))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.DescripcionEstrategia))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.FlagNueva, f => f.MapFrom(c => c.FlagNueva))
                .ForMember(t => t.FlagRecoPerfil, f => f.MapFrom(c => c.FlagRecoPerfil))
                .ForMember(t => t.FlagRecoProduc, f => f.MapFrom(c => c.FlagRecoProduc))
                .ForMember(t => t.Imagen, f => f.MapFrom(c => c.ImagenEstrategia))
                .ForMember(t => t.CodigoPrograma, f => f.MapFrom(c => c.CodigoPrograma))
                .ForMember(t => t.FlagValidarImagen, f => f.MapFrom(c => c.FlagValidarImagen))
                .ForMember(t => t.PesoMaximoImagen, f => f.MapFrom(c => c.PesoMaximoImagen));

            Mapper.CreateMap<BEPedidoFICDetalle, PedidoWebDetalleModel>();

            Mapper.CreateMap<ServiceUsuario.BEMisPedidos, ClienteOnlineModel>()
                .ForMember(t => t.SolicitudClienteID, f => f.MapFrom(c => c.PedidoId))
                .ForMember(t => t.ClienteNuevo, f => f.MapFrom(c => c.MarcaID > 0 || !c.FlagConsultora));

            Mapper.CreateMap<BEMotivoSolicitud, MisPedidosMotivoRechazoModel>();
            Mapper.CreateMap<ServiceUsuario.BENotificacionesDetallePedido, NotificacionesModelDetallePedido>();

            Mapper.CreateMap<BELogGPRValidacion, NotificacionesModel>()
                .ForMember(t => t.Descuento, f => f.MapFrom(c => -c.Descuento))
                .ForMember(t => t.FechaValidacion, f => f.MapFrom(c => c.FechaFinValidacion));

            Mapper.CreateMap<ServiceUsuario.BEMisPedidosDetalle, ClienteOnlineDetalleModel>()
                .ForMember(t => t.SolicitudClienteDetalleID, f => f.MapFrom(c => c.PedidoDetalleId));

            Mapper.CreateMap<BELogGPRValidacionDetalle, NotificacionesModelDetallePedido>()
                .ForMember(t => t.IndicadorOferta, f => f.MapFrom(c => c.IndicadorOferta ? 1 : 0));

            Mapper.CreateMap<ServiceUsuario.BEMisPedidosDetalle, MisPedidosDetalleModel2>();

            Mapper.CreateMap<MatrizComercialModel, BEMatrizComercial>();
            Mapper.CreateMap<BEMatrizComercial, MatrizComercialResultadoModel>();
            Mapper.CreateMap<BERegion, RegionModel>();

            Mapper.CreateMap<Producto, ProductoModel>()
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.Cuv))
                .ForMember(t => t.CodigoProducto, f => f.MapFrom(c => c.CodigoSap))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.NombreComercial))
                .ForMember(t => t.DescripcionComercial, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.ImagenProductoSugerido, f => f.MapFrom(c => c.Imagen))
                .ForMember(t => t.NombreBulk, f => f.MapFrom(c => c.NombreBulk))
                .ForMember(t => t.ImagenBulk, f => f.MapFrom(c => c.ImagenBulk))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.IdMarca))
                .ForMember(t => t.DescripcionMarca, f => f.MapFrom(c => c.NombreMarca))
                .ForMember(t => t.CUVPedidoImagen, f => f.MapFrom(c => c.ImagenCUVPedido))
                .ForMember(t => t.CUVPedidoNombre, f => f.MapFrom(c => c.NombreCUVPedido));

            Mapper.CreateMap<BECDRWeb, CDRWebModel>();

            Mapper.CreateMap<BELogCDRWeb, CDRWebModel>()
                .ForMember(t => t.PedidoNumero, f => f.MapFrom(c => c.PedidoFacturadoId))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => string.IsNullOrEmpty(c.CampaniaId) ? 0 : Convert.ToInt32(c.CampaniaId)))
                .ForMember(t => t.Estado, f => f.MapFrom(c => c.EstadoCDR))
                .ForMember(t => t.Importe, f => f.MapFrom(c => c.ImporteCDR));

            Mapper.CreateMap<ServiceUsuario.BEUsuarioExterno, UsuarioExternoModel>()
                .ForMember(t => t.CodigoUsuario, f => f.MapFrom(c => c.CodigoUsuario))
                .ForMember(t => t.Proveedor, f => f.MapFrom(c => c.Proveedor))
                .ForMember(t => t.IdAplicacion, f => f.MapFrom(c => c.IdAplicacion))
                .ForMember(t => t.Login, f => f.MapFrom(c => c.Login))
                .ForMember(t => t.Nombres, f => f.MapFrom(c => c.Nombres))
                .ForMember(t => t.Apellidos, f => f.MapFrom(c => c.Apellidos))
                .ForMember(t => t.FechaNacimiento, f => f.MapFrom(c => c.FechaNacimiento))
                .ForMember(t => t.Correo, f => f.MapFrom(c => c.Correo))
                .ForMember(t => t.Genero, f => f.MapFrom(c => c.Genero))
                .ForMember(t => t.Ubicacion, f => f.MapFrom(c => c.Ubicacion))
                .ForMember(t => t.LinkPerfil, f => f.MapFrom(c => c.LinkPerfil))
                .ForMember(t => t.FotoPerfil, f => f.MapFrom(c => c.FotoPerfil))
                .ForMember(t => t.FechaRegistro, f => f.MapFrom(c => c.FechaRegistro))
                .ForMember(t => t.Estado, f => f.MapFrom(c => c.Estado));

            Mapper.CreateMap<BEShowRoomOferta, ShowRoomOfertaModel>()
                 .ForMember(t => t.OfertaShowRoomID, f => f.MapFrom(c => c.OfertaShowRoomID))
                 .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                 .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                 .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                 .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                 .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                 .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                 .ForMember(t => t.PrecioValorizado, f => f.MapFrom(c => c.PrecioValorizado))
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
                 .ForMember(t => t.TipNegocio, f => f.MapFrom(c => c.TipNegocio))
                 .ForMember(t => t.CodigoProducto, f => f.MapFrom(c => c.CodigoProducto))
                 .ForMember(t => t.DescripcionCategoria, f => f.MapFrom(c => c.DescripcionCategoria))
                 .ForMember(t => t.EsSubCampania, f => f.MapFrom(c => c.EsSubCampania));

            Mapper.CreateMap<BEShowRoomOfertaDetalle, ShowRoomOfertaDetalleModel>();
            Mapper.CreateMap<BEPedidoObservacion, ObservacionModel>();
            Mapper.CreateMap<ServiceUsuario.BEConfiguracionPais, ConfiguracionPaisModel>();
            Mapper.CreateMap<ServiceSAC.BEConfiguracionPais, ConfiguracionPaisModel>();
            Mapper.CreateMap<ServiceSAC.BEConfiguracionPais, AdministrarPalancaModel>();
            Mapper.CreateMap<ServiceUsuario.BEConfiguracionPaisDatos, ConfiguracionPaisDatosModel>();

            Mapper.CreateMap<ServiceUsuario.BEConfiguracionPaisDatos, ConfiguracionPaisComponenteModel>()
                .ForMember(t => t.ConfiguracionPaisComponenteID, f => f.MapFrom(c => c.Codigo + c.CampaniaID + c.Componente))
                .ForMember(t => t.PalancaCodigo, f => f.MapFrom(c => c.Codigo))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => (c.Componente ?? "").Replace("_", " ")))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Componente));

            Mapper.CreateMap<BEConfiguracionOfertasHome, AdministrarOfertasHomeModel>();
            Mapper.CreateMap<BETablaLogicaDatos, TablaLogicaDatosModel>()
                .ForMember(t => t.TablaLogicaDatosID, f => f.MapFrom(c => c.TablaLogicaDatosID))
                .ForMember(t => t.TablaLogicaID, f => f.MapFrom(c => c.TablaLogicaID))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                .ForMember(t => t.Valor, f => f.MapFrom(c => c.Valor))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            Mapper.CreateMap<ServicePedido.BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>();

            Mapper.CreateMap<BEConsultoraRegaloProgramaNuevas, ConsultoraRegaloProgramaNuevasModel>()
                .ForMember(t => t.CodigoNivel, f => f.MapFrom(c => c.CodigoNivel))
                .ForMember(t => t.TippingPoint, f => f.MapFrom(c => c.TippingPoint))
                .ForMember(t => t.CUVPremio, f => f.MapFrom(c => c.CUVPremio))
                .ForMember(t => t.DescripcionPremio, f => f.MapFrom(c => c.DescripcionPremio))
                .ForMember(t => t.CodigoSap, f => f.MapFrom(c => c.CodigoSap))
                .ForMember(t => t.PrecioCatalogo, f => f.MapFrom(c => c.PrecioCatalogo))
                .ForMember(t => t.PrecioValorizado, f => f.MapFrom(c => c.PrecioValorizado))
                .ForMember(t => t.UrlImagenRegalo, f => f.MapFrom(c => c.UrlImagenRegalo));

            Mapper.CreateMap<BEPermiso, PermisoModel>()
                .ForMember(t => t.EsDireccionExterior, f => f.MapFrom(c => c.UrlItem.ToLower().StartsWith("http")))
                .ForMember(t => t.DescripcionFormateada, f => f.MapFrom(c => c.Descripcion.ToLower()))
                .ForMember(x => x.PermisoID, t => t.MapFrom(c => c.PermisoID))
                .ForMember(x => x.RolId, t => t.MapFrom(c => c.RolId))
                .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                .ForMember(x => x.IdPadre, t => t.MapFrom(c => c.IdPadre))
                .ForMember(x => x.OrdenItem, t => t.MapFrom(c => c.OrdenItem))
                .ForMember(x => x.UrlItem, t => t.MapFrom(c => c.UrlItem))
                .ForMember(x => x.PaginaNueva, t => t.MapFrom(c => c.PaginaNueva))
                .ForMember(x => x.RolId, t => t.MapFrom(c => c.RolId))
                .ForMember(x => x.Mostrar, t => t.MapFrom(c => c.Mostrar))
                .ForMember(x => x.Posicion, t => t.MapFrom(c => c.Posicion));

            Mapper.CreateMap<BEMenuMobile, MenuMobileModel>()
                .ForMember(t => t.MenuPadreDescripcion, f => f.MapFrom(c => c.Descripcion));

            Mapper.CreateMap<BEBannerInfo, BannerInfoModel>();
            Mapper.CreateMap<BEConfiguracionOfertasHome, ConfiguracionSeccionHomeModel>();
            Mapper.CreateMap<BEProductoComentarioDetalle, EstrategiaProductoComentarioModel>();

            Mapper.CreateMap<BEPais, PaisModel>();

            Mapper.CreateMap<ServiceODS.BEProductoDescripcion, GestionFaltantesModel>();

            Mapper.CreateMap<AdministrarLugaresPagoModel, BELugarPago>()
                .ForMember(t => t.LugarPagoID, f => f.MapFrom(c => c.LugarPagoID))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.UrlSitio, f => f.MapFrom(c => c.UrlSitio))
                .ForMember(t => t.ArchivoLogo, f => f.MapFrom(c => c.ArchivoLogo))
                .ForMember(t => t.TextoPago, f => f.MapFrom(c => c.TextoPago))
                .ForMember(t => t.Posicion, f => f.MapFrom(c => c.Posicion))
                .ForMember(t => t.ArchivoInstructivo, f => f.MapFrom(c => c.ArchivoInstructivo));

            Mapper.CreateMap<BEFichaProducto, FichaProductoModel>();

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

            Mapper.CreateMap<ServiceUsuario.BEEventoFestivo, EventoFestivoModel>();
            Mapper.CreateMap<BETracking, SeguimientoMobileModel>();


            Mapper.CreateMap<ServiceCliente.BECliente, ClienteModel>();
            Mapper.CreateMap<BEDescripcionEstrategia, DescripcionEstrategiaModel>();

            Mapper.CreateMap<BETipoLink, TipoLinkModel>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.TipoLinkID, f => f.MapFrom(c => c.TipoLinkID))
                .ForMember(t => t.Url, f => f.MapFrom(c => c.Url));

            Mapper.CreateMap<BEMiCertificado, MiCertificadoModel>();
             
            Mapper.CreateMap<BEEtiqueta, EtiquetaModel>()
                .ForMember(t => t.EtiquetaID, f => f.MapFrom(c => c.EtiquetaID))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            Mapper.CreateMap<BEFeErratas, AdministrarFeErratasModel>()
                .ForMember(t => t.FeErratasID, f => f.MapFrom(c => c.FeErratasID))
                .ForMember(t => t.Pagina, f => f.MapFrom(c => c.Pagina))
                .ForMember(t => t.Dice, f => f.MapFrom(c => c.Dice))
                .ForMember(t => t.DebeDecir, f => f.MapFrom(c => c.DebeDecir));

            Mapper.CreateMap<BEOfertaProducto, OfertaProductoModel>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.OfertaProductoID, f => f.MapFrom(c => c.OfertaProductoID))
                .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal))
                .ForMember(t => t.TallaColor, f => f.MapFrom(c => c.TallaColor))
                .ForMember(t => t.DescripcionMarca, f => f.MapFrom(c => c.DescripcionMarca))
                .ForMember(t => t.DescripcionCategoria, f => f.MapFrom(c => c.DescripcionCategoria))
                .ForMember(t => t.DescripcionEstrategia, f => f.MapFrom(c => c.DescripcionEstrategia));

            Mapper.CreateMap<BEConfiguracionOferta, ConfiguracionOfertaModel>()
                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                .ForMember(t => t.CodigoOferta, f => f.MapFrom(c => c.CodigoOferta))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            Mapper.CreateMap<ServiceCliente.BECliente, ClienteMobileModel>()
                .ForMember(t => t.Email, f => f.MapFrom(c => c.eMail))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono))
                .ForMember(t => t.Celular, f => f.MapFrom(c => c.Celular))
                .ForMember(t => t.TieneTelefono, f => f.MapFrom(c => c.TieneTelefono));

            Mapper.CreateMap<ServiceSAC.BEServicioCampania, ServicioCampaniaModel>()
                .ForMember(x => x.ServicioId, t => t.MapFrom(c => c.ServicioId))
                .ForMember(x => x.Descripcion, t => t.MapFrom(c => c.Descripcion))
                .ForMember(x => x.Url, t => t.MapFrom(c => c.Url));

            Mapper.CreateMap<BEShowRoomEvento, ShowRoomEventoModel>()
                .ForMember(t => t.EventoID, f => f.MapFrom(c => c.EventoID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Tema, f => f.MapFrom(c => c.Tema))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.Imagen1, f => f.MapFrom(c => c.Imagen1))
                .ForMember(t => t.Imagen2, f => f.MapFrom(c => c.Imagen2))
                .ForMember(t => t.Descuento, f => f.MapFrom(c => c.Descuento))
                .ForMember(t => t.TieneCategoria, f => f.MapFrom(c => c.TieneCategoria))
                .ForMember(t => t.TieneCompraXcompra, f => f.MapFrom(c => c.TieneCompraXcompra))
                .ForMember(t => t.TieneSubCampania, f => f.MapFrom(c => c.TieneSubCampania));

            Mapper.CreateMap<BEConfiguracionTipoProcesoCargaPedidos, ZonaModel>()
                .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.CodigoZona))
                .ForMember(t => t.DiasParametroCarga, f => f.MapFrom(c => c.DiasParametroCarga));

            Mapper.CreateMap<BEConfiguracionValidacionZona, ConfiguracionValidacionZonaModel>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID));

            Mapper.CreateMap<BEConfiguracionValidacion, ConfiguracionValidacionModel>()
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

            Mapper.CreateMap<BEConfiguracionValidacionNuevoPROL, ZonaModel>()
                .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.CodigoZona));

            Mapper.CreateMap<BEZona, ZonaModel>()
                .ForMember(x => x.ZonaID, t => t.MapFrom(c => c.ZonaID))
                .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo))
                .ForMember(x => x.Nombre, t => t.MapFrom(c => c.Nombre))
                .ForMember(x => x.RegionID, t => t.MapFrom(c => c.RegionID));

            Mapper.CreateMap<BECrossSellingProducto, CrossSellingProductoModel>()
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            Mapper.CreateMap<BECrossSellingAsociacion, CrossSellingAsociacionModel>()
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            Mapper.CreateMap<BEOfertaFlexipago, OfertaFlexipagoModel>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                .ForMember(t => t.PrecioNormal, f => f.MapFrom(c => c.PrecioNormal))
                .ForMember(t => t.Stock, f => f.MapFrom(c => c.Stock))
                .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                .ForMember(t => t.Orden, f => f.MapFrom(c => c.Orden))
                .ForMember(t => t.UnidadesPermitidas, f => f.MapFrom(c => c.UnidadesPermitidas))
                .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID))
                .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                .ForMember(t => t.OfertaProductoID, f => f.MapFrom(c => c.OfertaProductoID))
                .ForMember(t => t.DescripcionLegal, f => f.MapFrom(c => c.DescripcionLegal));

            Mapper.CreateMap<BECampania, CampaniaModel>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            Mapper.CreateMap<BESolicitudCredito, SolicitudCreditoModel>()
                .ForMember(x => x.SolicitudCreditoID, t => t.MapFrom(c => c.SolicitudCreditoID))
                .ForMember(x => x.PaisID, t => t.MapFrom(c => c.PaisID))
                .ForMember(x => x.TipoSolicitud, t => t.MapFrom(c => c.TipoSolicitud ?? ""))
                .ForMember(x => x.CodigoUbigeo, t => t.MapFrom(c => c.CodigoUbigeo ?? ""))
                .ForMember(x => x.IndicadorActivo, t => t.MapFrom(c => c.IndicadorActivo))
                .ForMember(x => x.UsuarioCreacion, t => t.MapFrom(c => c.UsuarioCreacion ?? ""))
                .ForMember(x => x.FechaCreacion, t => t.MapFrom(c => c.FechaCreacion))
                .ForMember(x => x.CodigoLote, t => t.MapFrom(c => c.CodigoLote))
                .ForMember(x => x.FuenteIngreso, t => t.MapFrom(c => c.FuenteIngreso ?? ""))
                .ForMember(x => x.NumeroPreimpreso, t => t.MapFrom(c => c.NumeroPreimpreso ?? ""))
                .ForMember(x => x.CodigoZona, t => t.MapFrom(c => c.CodigoZona ?? ""))
                .ForMember(x => x.CodigoTerritorio, t => t.MapFrom(c => c.CodigoTerritorio ?? ""))
                .ForMember(x => x.TipoContacto, t => t.MapFrom(c => c.TipoContacto))
                .ForMember(x => x.CampaniaID, t => t.MapFrom(c => c.CampaniaID))
                .ForMember(x => x.CodigoConsultoraRecomienda, t => t.MapFrom(c => c.CodigoConsultoraRecomienda ?? ""))
                .ForMember(x => x.NombreConsultoraRecomienda, t => t.MapFrom(c => c.NombreConsultoraRecomienda ?? ""))
                .ForMember(x => x.CodigoConsultora, t => t.MapFrom(c => c.CodigoConsultora ?? ""))
                .ForMember(x => x.CodigoPremio, t => t.MapFrom(c => c.CodigoPremio ?? ""))
                .ForMember(x => x.ApellidoPaterno, t => t.MapFrom(c => c.ApellidoPaterno ?? ""))
                .ForMember(x => x.ApellidoMaterno, t => t.MapFrom(c => c.ApellidoMaterno ?? ""))
                .ForMember(x => x.PrimerNombre, t => t.MapFrom(c => c.PrimerNombre ?? ""))
                .ForMember(x => x.SegundoNombre, t => t.MapFrom(c => c.SegundoNombre ?? ""))
                .ForMember(x => x.TipoDocumento, t => t.MapFrom(c => c.TipoDocumento ?? ""))
                .ForMember(x => x.NumeroDocumento, t => t.MapFrom(c => c.NumeroDocumento ?? ""))
                .ForMember(x => x.Sexo, t => t.MapFrom(c => c.Sexo ?? ""))
                .ForMember(x => x.FechaNacimiento, t => t.MapFrom(c => c.FechaNacimiento))
                .ForMember(x => x.EstadoCivil, t => t.MapFrom(c => c.EstadoCivil ?? ""))
                .ForMember(x => x.NivelEducativo, t => t.MapFrom(c => c.NivelEducativo ?? ""))
                .ForMember(x => x.CodigoOtrasMarcas, t => t.MapFrom(c => c.CodigoOtrasMarcas))
                .ForMember(x => x.TipoNacionalidad, t => t.MapFrom(c => c.TipoNacionalidad ?? ""))
                .ForMember(x => x.Telefono, t => t.MapFrom(c => c.Telefono ?? ""))
                .ForMember(x => x.Celular, t => t.MapFrom(c => c.Celular ?? ""))
                .ForMember(x => x.CorreoElectronico, t => t.MapFrom(c => c.CorreoElectronico ?? ""))
                .ForMember(x => x.Direccion, t => t.MapFrom(c => c.Direccion ?? ""))
                .ForMember(x => x.Referencia, t => t.MapFrom(c => c.Referencia ?? ""))
                .ForMember(x => x.Ciudad, t => t.MapFrom(c => c.Ciudad ?? ""))
                .ForMember(x => x.TipoVia, t => t.MapFrom(c => c.TipoVia ?? ""))
                .ForMember(x => x.PoblacionVilla, t => t.MapFrom(c => c.PoblacionVilla ?? ""))
                .ForMember(x => x.CodigoPostal, t => t.MapFrom(c => c.CodigoPostal ?? ""))
                .ForMember(x => x.DireccionEntrega, t => t.MapFrom(c => c.DireccionEntrega ?? ""))
                .ForMember(x => x.ReferenciaEntrega, t => t.MapFrom(c => c.ReferenciaEntrega ?? ""))
                .ForMember(x => x.TelefonoEntrega, t => t.MapFrom(c => c.TelefonoEntrega ?? ""))
                .ForMember(x => x.CelularEntrega, t => t.MapFrom(c => c.CelularEntrega ?? ""))
                .ForMember(x => x.ObservacionEntrega, t => t.MapFrom(c => c.ObservacionEntrega ?? ""))
                .ForMember(x => x.ApellidoFamiliar, t => t.MapFrom(c => c.ApellidoFamiliar ?? ""))
                .ForMember(x => x.NombreFamiliar, t => t.MapFrom(c => c.NombreFamiliar ?? ""))
                .ForMember(x => x.DireccionFamiliar, t => t.MapFrom(c => c.DireccionFamiliar ?? ""))
                .ForMember(x => x.TelefonoFamiliar, t => t.MapFrom(c => c.TelefonoFamiliar ?? ""))
                .ForMember(x => x.CelularFamiliar, t => t.MapFrom(c => c.CelularFamiliar ?? ""))
                .ForMember(x => x.TipoVinculoFamiliar, t => t.MapFrom(c => c.TipoVinculoFamiliar))
                .ForMember(x => x.ApellidoNoFamiliar, t => t.MapFrom(c => c.ApellidoNoFamiliar ?? ""))
                .ForMember(x => x.NombreNoFamiliar, t => t.MapFrom(c => c.NombreNoFamiliar ?? ""))
                .ForMember(x => x.DireccionNoFamiliar, t => t.MapFrom(c => c.DireccionNoFamiliar ?? ""))
                .ForMember(x => x.TelefonoNoFamiliar, t => t.MapFrom(c => c.TelefonoNoFamiliar ?? ""))
                .ForMember(x => x.CelularNoFamiliar, t => t.MapFrom(c => c.CelularNoFamiliar ?? ""))
                .ForMember(x => x.TipoVinculoNoFamiliar, t => t.MapFrom(c => c.TipoVinculoNoFamiliar))
                .ForMember(x => x.ApellidoPaternoAval, t => t.MapFrom(c => c.ApellidoPaternoAval ?? ""))
                .ForMember(x => x.ApellidoMaternoAval, t => t.MapFrom(c => c.ApellidoMaternoAval ?? ""))
                .ForMember(x => x.PrimerNombreAval, t => t.MapFrom(c => c.PrimerNombreAval ?? ""))
                .ForMember(x => x.SegundoNombreAval, t => t.MapFrom(c => c.SegundoNombreAval ?? ""))
                .ForMember(x => x.DireccionAval, t => t.MapFrom(c => c.DireccionAval ?? ""))
                .ForMember(x => x.TelefonoAval, t => t.MapFrom(c => c.TelefonoAval ?? ""))
                .ForMember(x => x.CelularAval, t => t.MapFrom(c => c.CelularAval ?? ""))
                .ForMember(x => x.TipoDocumentoAval, t => t.MapFrom(c => c.TipoDocumentoAval ?? ""))
                .ForMember(x => x.NumeroDocumentoAval, t => t.MapFrom(c => c.NumeroDocumentoAval ?? ""))
                .ForMember(x => x.TipoVinculoAval, t => t.MapFrom(c => c.TipoVinculoAval))
                .ForMember(x => x.MontoMeta, t => t.MapFrom(c => c.MontoMeta))
                .ForMember(x => x.TipoMeta, t => t.MapFrom(c => c.TipoMeta ?? ""))
                .ForMember(x => x.DescripcionMeta, t => t.MapFrom(c => c.DescripcionMeta ?? ""));

            Mapper.CreateMap<BEBannerSegmentoZona, PaisModel>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisId))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.NombrePais))
                .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombrePais));

            Mapper.CreateMap<BEProveedorDespachoCobranza, ProveedorDespachoCobranzaModel>()
                .ForMember(t => t.ProveedorDespachoCobranzaID, f => f.MapFrom(c => c.ProveedorDespachoCobranzaID))
                .ForMember(t => t.NombreComercial, f => f.MapFrom(c => c.NombreComercial));

            Mapper.CreateMap<ServiceSAC.BEParametro, ParametroModel>()
                .ForMember(t => t.ParametroId, f => f.MapFrom(c => c.ParametroId))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                .ForMember(t => t.Abreviatura, f => f.MapFrom(c => c.Abreviatura));

            Mapper.CreateMap<BEServicioSegmentoZona, PaisModel>()
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisId))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.NombrePais))
                .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombrePais));

            Mapper.CreateMap<BEServicioSegmentoZona, CampaniaModel>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaId))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.DesCampania))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.DesCampania));

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

            Mapper.CreateMap<ServiceUsuario.BEUsuario, UsuarioModel>()
                .ForMember(t => t.NombreConsultora, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.CambioClave, f => f.MapFrom(c => Convert.ToInt32(c.CambioClave)))
                .ForMember(t => t.FechaInicioCampania, f => f.MapFrom(c => c.FechaInicioFacturacion))
                .ForMember(t => t.VioVideoModelo, f => f.MapFrom(c => c.VioVideo))
                .ForMember(t => t.VioTutorialModelo, f => f.MapFrom(c => c.VioTutorial))
                .ForMember(t => t.DiaPROLMensajeCierreCampania, f => f.MapFrom(c => DateTime.Now.AddHours(c.ZonaHoraria) >= c.FechaInicioFacturacion))
                .ForMember(t => t.HoraInicioReserva, f => f.MapFrom(c => c.HoraInicio))
                .ForMember(t => t.HoraFinReserva, f => f.MapFrom(c => c.HoraFin))
                .ForMember(t => t.HoraInicioPreReserva, f => f.MapFrom(c => c.HoraInicioNoFacturable))
                .ForMember(t => t.HoraFinPreReserva, f => f.MapFrom(c => c.HoraCierreNoFacturable))
                .ForMember(t => t.DiasCampania, f => f.MapFrom(c => c.DiasAntes))
                .ForMember(t => t.HoraFinFacturacion, f => f.MapFrom(c => c.HoraFin))
                .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.CampaniaDescripcion))
                .ForMember(t => t.SobrenombreOriginal, f => f.MapFrom(c => c.Sobrenombre))
                .ForMember(t => t.SegmentoConstancia, f => f.MapFrom(c => c.SegmentoConstancia ?? string.Empty))
                .ForMember(t => t.NombreGerenteZonal, f => f.MapFrom(c => c.NombreGerenteZona))
                .ForMember(t => t.MensajePedidoDesktop, f => f.MapFrom(c => c.TipoUsuario == Constantes.TipoUsuario.Postulante ? c.MensajePedidoDesktop : 0))
                .ForMember(t => t.MensajePedidoMobile, f => f.MapFrom(c => c.TipoUsuario == Constantes.TipoUsuario.Postulante ? c.MensajePedidoMobile : 0))
                .ForMember(t => t.MontoMinimo, f => f.MapFrom(c => c.MontoMinimoPedido))
                .ForMember(t => t.MontoMaximo, f => f.MapFrom(c => c.MontoMaximoPedido))
                .ForMember(t => t.ListaLoginExterno, f => f.MapFrom(c => new List<UsuarioExternoModel>()))
                .ForMember(t => t.CodigosConcursos, f => f.MapFrom(c => string.Empty))
                .ForMember(t => t.CodigosProgramaNuevas, f => f.MapFrom(c => string.Empty));

            Mapper.CreateMap<UpSelling, UpSellingModel>()
                .ForMember(t => t.Regalos, f => f.MapFrom(c => c.Regalos));

            Mapper.CreateMap<UpSellingDetalle, UpSellingRegaloModel>()
                .ForMember(t => t.UpSellingRegaloId, f => f.MapFrom(c => c.UpSellingDetalleId));


            Mapper.CreateMap<UpSellingRegalo, OfertaFinalRegaloModel>();

            Mapper.CreateMap<UpSellingMontoMeta, OfertaFinalMontoMetaModel>();

            Mapper.CreateMap<BEPedidoWebSet, PedidoWebSetModel>()
                .ForMember(t => t.Campania, f => f.MapFrom(c => c.Campania))
                .ForMember(t => t.SetId, f => f.MapFrom(c => c.SetId))
                .ForMember(t => t.Detalles, f => f.MapFrom(c => c.Detalles));

            Mapper.CreateMap<BEPedidoWebSetDetalle, PedidoWebSetDetalleModel>()
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CuvProducto))
                .ForMember(t => t.TipoOfertaSisId, f => f.MapFrom(c => c.TipoOfertaSisId));

            Mapper.CreateMap<ServiceUsuario.BEUsuario, MisDatosModel>();
        }
    }
}