using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager.OfertaDelDia;
using Portal.Consultoras.Web.SessionManager.ShowRoom;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.SessionManager
{
    public interface ISessionManager
    {
        #region TablaLogica
        TablaLogicaDatosModel GetTablaLogicaDatos(string key);

        void SetTablaLogicaDatos(string key, TablaLogicaDatosModel datoLogico);

        List<TablaLogicaDatosModel> GetTablaLogicaDatosLista(string key);

        void SetTablaLogicaDatosLista(string key, List<TablaLogicaDatosModel> datoLogico);
        #endregion

        #region CDR

        List<BECDRWebDetalle> GetCDRWebDetalle();
        
        void SetCDRWebDetalle(List<BECDRWebDetalle> datos);
        
        List<BECDRWeb> GetCdrWeb();

        void SetCdrWeb(List<BECDRWeb> datos);
        
        List<CampaniaModel> GetCdrCampanias();

        void SetCdrCampanias(List<CampaniaModel> datos);
        
        List<BECDRParametria> GetCdrParametria();

        void SetCdrParametria(List<BECDRParametria> datos);
        
        List<BECDRWebDatos> GetCdrWebDatos();

        void SetCdrWebDatos(List<BECDRWebDatos> datos);
        
        List<BECDRWebDescripcion> GetCdrDescripcion();

        void SetCdrDescripcion(List<BECDRWebDescripcion> datos);

        List<BECDRWebMotivoOperacion> GetCdrMotivoOperacion();

        void SetCdrMotivoOperacion(List<BECDRWebMotivoOperacion> datos);
        #endregion

        BEPedidoWeb GetPedidoWeb();

        void SetPedidoWeb(BEPedidoWeb pedidoWeb);

        List<BEPedidoWebDetalle> GetDetallesPedido();

        void SetDetallesPedido(List<BEPedidoWebDetalle> detallesPedidoWeb);

        List<ObservacionModel> GetObservacionesProl();

        void SetObservacionesProl(List<ObservacionModel> observaciones);

        void SetEsShowRoom(string flag);

        bool GetEsShowRoom();

        void SetMostrarShowRoomProductos(string flag);

        bool GetMostrarShowRoomProductos();

        void SetMostrarShowRoomProductosExpiro(string flag);

        bool GetMostrarShowRoomProductosExpiro();

        void SetTiposEstrategia(List<ServicePedido.BETipoEstrategia> tiposEstrategia);

        List<ServicePedido.BETipoEstrategia> GetTiposEstrategia();

        void SetRevistaDigital(RevistaDigitalModel revistaDigital);

        RevistaDigitalModel GetRevistaDigital();

        void SetHerramientasVenta(HerramientasVentaModel herramientasVenta);

        HerramientasVentaModel GetHerramientasVenta();

        void SetGuiaNegocio(GuiaNegocioModel modeloGnd);

        GuiaNegocioModel GetGuiaNegocio();

        void SetIsContrato(int isContrato);

        int GetIsContrato();

        void SetIsOfertaPack(int isOfertaPack);

        int GetIsOfertaPack();

        void SetConfiguracionesPaisModel(List<ConfiguracionPaisModel> configuracionesPais);

        List<ConfiguracionPaisModel> GetConfiguracionesPaisModel();

        void SetOfertaFinalModel(OfertaFinalModel ofertaFinalModel);

        OfertaFinalModel GetOfertaFinalModel();

        void SetEventoFestivoDataModel(EventoFestivoDataModel eventoFestivoDataModel);

        EventoFestivoDataModel GetEventoFestivoDataModel();

        void SetTieneLan(bool tieneLan);

        bool GetTieneLan();

        void SetTieneLanX1(bool tieneLanX1);

        bool GetTieneLanX1();

        void SetTieneOpt(bool tieneOpt);

        bool GetTieneOpt();

        void SetTieneOpm(bool tieneOpm);

        bool GetTieneOpm();

        void SetTieneOpmX1(bool tieneOpmX1);

        bool GetTieneOpmX1();

        void SetTieneHv(bool tieneHv);

        bool GetTieneHv();

        void SetTieneHvX1(bool tieneHv);

        bool GetTieneHvX1();

        void SetUserData(UsuarioModel usuario);

        UsuarioModel GetUserData();

        void SetMontosProl(List<ObjMontosProl> montosProl);

        List<ObjMontosProl> GetMontosProl();

        void SetMisCertificados(List<MiCertificadoModel> lista);

        List<MiCertificadoModel> GetMisCertificados();

        void SetMisCertificadosData(List<BEMiCertificado> lista);

        List<BEMiCertificado> GetMisCertificadosData();

        void SetFlagLogCargaOfertas(bool habilitarLog);

        void SetListFiltersFAV(List<ServiceSAC.BETablaLogicaDatos> lista);

        bool GetFlagLogCargaOfertas();

        void SetMenuContenedorActivo(MenuContenedorModel menuContenedorActivo);

        MenuContenedorModel GetMenuContenedorActivo();

        void SetMenuContenedor(List<ConfiguracionPaisModel> menuContenedor);

        List<ConfiguracionPaisModel> GetMenuContenedor();

        void SetSeccionesContenedor(int campaniaId, List<BEConfiguracionOfertasHome> seccionesContenedor);

        List<BEConfiguracionOfertasHome> GetSeccionesContenedor(int campaniaId);

        List<ServiceSAC.BETablaLogicaDatos> GetListFiltersFAV();

        void SetStartSession(DateTime StartSession);

        DateTime GetStartSession();
        
        IShowRoom ShowRoom { get; }

        void SetDatosPagoVisa(PagoEnLineaModel model);

        PagoEnLineaModel GetDatosPagoVisa();
        
        void SetListadoEstadoCuenta(List<EstadoCuentaModel> model);

        List<EstadoCuentaModel> GetListadoEstadoCuenta();

        void SetProductoTemporal(EstrategiaPersonalizadaProductoModel modelo);

        EstrategiaPersonalizadaProductoModel GetProductoTemporal();

        void SetEstrategiaSR(Models.Estrategia.ShowRoom.ConfigModel data);

        Models.Estrategia.ShowRoom.ConfigModel GetEstrategiaSR();
        
        void SetBEEstrategia(string key, List<ServiceOferta.BEEstrategia> data);

        List<ServiceOferta.BEEstrategia> GetBEEstrategia(string key);

        void SetPedidosFacturados(PedidoWebClientePrincipalMobilModel model);

        PedidoWebClientePrincipalMobilModel GetPedidosFacturados();

        List<BEPedidoWebDetalle> GetDetallesPedidoSetAgrupado();

        void SetDetallesPedidoSetAgrupado(List<BEPedidoWebDetalle> detallesPedidoWeb);

        void SetMiAcademia(int id);

        int GetMiAcademia();

        void SetPedidoValidado(bool validado);

        bool GetPedidoValidado();

        void setBEUsuarioModel (List<ServiceUsuario.BEUsuario> model);

        List<ServiceUsuario.BEUsuario> getBEUsuarioModel();

        IOfertaDelDia OfertaDelDia { get; }
        BEConfiguracionProgramaNuevas ConfiguracionProgramaNuevas { get; set; }
        bool ProcesoKitNuevas { get; set; }
        string CuvKitNuevas { get; set; }
        
        void SetBuscadorYFiltros(BuscadorYFiltrosModel buscadorYFiltrosModel);
        BuscadorYFiltrosModel GetBuscadorYFiltros();
        
        void SetOcultarBannerApp(dynamic val);

        dynamic GetOcultarBannerApp();

        void SetBannerApp(BEComunicado val);

        BEComunicado GetBannerApp();

        void SetPrimeraVezSessionMobile(dynamic val);

        dynamic GetPrimeraVezSessionMobile();

        void SetIngresoPortalConsultoras(bool val);

        dynamic GetIngresoPortalConsultoras();

        void SetConsultoraNuevaBannerAppMostrar(dynamic val);

        bool GetConsultoraNuevaBannerAppMostrar();

        void SetTipoPopUpMostrar(int val);

        int GetTipoPopUpMostrar();

        void SetClientesByConsultora(List<ServiceCliente.BECliente> val);

        List<ServiceCliente.BECliente> GetClientesByConsultora();

        void SetProductosCatalogoPersonalizado(List<ProductoModel> val);

        List<ProductoModel> GetProductosCatalogoPersonalizado();

        void SetobjMisPedidos(MisPedidosModel val);

        MisPedidosModel GetobjMisPedidos();

        void SetobjMisPedidosDetalle(List<BEMisPedidosDetalle> val);

        List<BEMisPedidosDetalle> GetobjMisPedidosDetalle();

        void SetobjMisPedidosDetalleVal(List<ServiceODS.BEProducto> val);

        List<ServiceODS.BEProducto> GetobjMisPedidosDetalleVal();


        void SetkeyFechaGetCantidadPedidos(dynamic val);

        dynamic GetkeyFechaGetCantidadPedidos();

        void SetkeyCantidadGetCantidadPedidos(dynamic val);

        dynamic GetkeyCantidadGetCantidadPedidos();

        void SetFichaProductoTemporal(FichaProductoDetalleModel val);

        FichaProductoDetalleModel GetFichaProductoTemporal();

        void SetCDRCampanias(List<CampaniaModel> val);

        List<CampaniaModel> GetCDRCampanias();

        void SetListaCDRDetalle(CDRWebModel val);

        CDRWebModel GetListaCDRDetalle();

        void SetfechaGetNotificacionesSinLeer(dynamic val);

        dynamic GetfechaGetNotificacionesSinLeer();

        void SetcantidadGetNotificacionesSinLeer(dynamic val);

        dynamic GetcantidadGetNotificacionesSinLeer();

        void SetPedidoFIC(List<BEPedidoFICDetalle> val);

        List<BEPedidoFICDetalle> GetPedidoFIC();

        void SetListaProductoFaltantes(List<BEProductoFaltante> val);

        List<BEProductoFaltante> GetListaProductoFaltantes();

        void SetPrimeraVezSession(dynamic val);

        dynamic GetPrimeraVezSession();

        void SetTokenPedidoAutentico(string val);

        string GetTokenPedidoAutentico();

        void Setentradas(List<AdministrarFeErratasModel> val);

        List<AdministrarFeErratasModel> Getentradas();

        void SetcarpetaPais(string val);

        string GetcarpetaPais();

        void SetCdrPedidosFacturado(List<ServicePedido.BEPedidoWeb> datos);

        List<ServicePedido.BEPedidoWeb> GetCdrPedidosFacturado();

        void SetCDRMotivoOperacion(List<BECDRWebMotivoOperacion> val);

        List<BECDRWebMotivoOperacion> GetCDRMotivoOperacion();

        void SetCDRWebDatos(List<BECDRWebDatos> val);

        List<BECDRWebDatos> GetCDRWebDatos();

        void SetCDRDescripcion(List<BECDRWebDescripcion> val);

        List<BECDRWebDescripcion> GetCDRDescripcion();

        void SetCDRParametria(List<BECDRParametria> val);

        List<BECDRParametria> GetCDRParametria();

        void SetListaProductoShowRoom(List<BEShowRoomOferta> val);

        List<BEShowRoomOferta> GetListaProductoShowRoom();

        void SetResultadoZona(dynamic val);

        dynamic GetResultadoZona();

        void SetListaEstrategia(List<ServiceOferta.BEEstrategia> val);

        List<ServiceOferta.BEEstrategia> GetListaEstrategia();

        void SetListaProductoShowRoomCpc(List<BEShowRoomOferta> val);

        List<BEShowRoomOferta> GetListaProductoShowRoomCpc();

        void SetActualizarDatosConsultora(bool val);

        bool GetActualizarDatosConsultora();

        void SetSuenioNavidad(int val);

        int GetSuenioNavidad();

        void SetUserFiltersFAV(List<FiltroResultadoModel> val);

        List<FiltroResultadoModel> GetUserFiltersFAV();

        void SetProductosCatalogoPersonalizadoFilter(List<ProductoModel> val);

        List<ProductoModel> GetProductosCatalogoPersonalizadoFilter();

        void SetPaisID(int val);

        int GetPaisID();

        void SetlstZonasActivas(List<ZonaModel> val);

        List<ZonaModel> GetlstZonasActivas();

        void SetlstZonasInactivas(List<ZonaModel> val);

        List<ZonaModel> GetlstZonasInactivas();

        void SetZonaCodigoEliminar(string val);

        string GetZonaCodigoEliminar();

        void SetIngresoPortalLideres(bool val);

        bool GetIngresoPortalLideres();

        void Seterrores(List<MatrizCampaniaModel> val);

        List<MatrizCampaniaModel> Geterrores();

        void SetMisPedidosDetallePorCampania(List<BEPedidoWebDetalle> val);

        List<BEPedidoWebDetalle> GetMisPedidosDetallePorCampania();

        void SetMisPedidosDetallePorCampaniaCampania(string val);

        string GetMisPedidosDetallePorCampaniaCampania();

        void SetMisPedidosDetallePorCampaniaEstado(string val);

        string GetMisPedidosDetallePorCampaniaEstado();

        void SetMisPedidosDetallePorCampaniaPedidoId(int val);

        int GetMisPedidosDetallePorCampaniaPedidoId();

        void SetCDRExpressMensajes(List<BETablaLogicaDatos> val);

        List<BETablaLogicaDatos> GetCDRExpressMensajes();

        void SetCuvEsProgramaNuevas(bool val);

        bool GetCuvEsProgramaNuevas();

        void SetConfiguracionProgramaNuevas(BEConfiguracionProgramaNuevas val);

        BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas();

        void SetOcultarBannerTop(bool val);

        bool GetOcultarBannerTop();

        void SetPedidoWebDDDetalle(List<BEPedidoDDWeb> val);

        List<BEPedidoDDWeb> GetPedidoWebDDDetalle();

        void SetPedidoWebDDDetalleConf(string val);

        string GetPedidoWebDDDetalleConf();

        void SetListaIndividual(List<List<BEEstadoServicio>> val);

        List<List<BEEstadoServicio>> GetListaIndividual();

        void SetListaRango(List<List<BEEstadoServicio>> val);

        List<List<BEEstadoServicio>> GetListaRango();

        void SetAceptoContrato(bool val);

        bool GetAceptoContrato();
    }
}
