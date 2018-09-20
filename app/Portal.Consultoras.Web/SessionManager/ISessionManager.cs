using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
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
        
        List<BEPedidoWeb> GetCdrPedidosFacturado();

        void SetCdrPedidosFacturado(List<BEPedidoWeb> datos);
        
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

        void SetStartSession(DateTime startSession);

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

        void SetMiAcademiaVideo(int id);

        int GetMiAcademiaVideo();

        void SetMiAcademiaParametro(string value);

        string GetMiAcademiaParametro();

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
    }
}
