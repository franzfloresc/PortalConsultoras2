﻿using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.Models.ProgramaNuevas;
using Portal.Consultoras.Web.Models.Recomendaciones;
using Portal.Consultoras.Web.ServiceCDR;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager.MasGanadoras;
using Portal.Consultoras.Web.SessionManager.OfertaDelDia;
using Portal.Consultoras.Web.SessionManager.ShowRoom;
using System;
using System.Collections.Generic;
using Portal.Consultoras.Web.Models.CaminoBrillante;

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

        List<ServiceCDR.BECDRWebDetalle> GetCDRWebDetalle();

        void SetCDRWebDetalle(List<ServiceCDR.BECDRWebDetalle> datos);

        List<ServiceCDR.BECDRWeb> GetCdrWeb();

        void SetCdrWeb(List<ServiceCDR.BECDRWeb> datos);

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

        int? GetNroPedidosCDRConfig();

        void SetNroPedidosCDRConfig(int cantidad);

        List<CDRWebModel> GetListaCDRWebCargaInicial();

        void SetListaCDRWebCargaInicial(List<CDRWebModel> lista);

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

        void SetAceptoContrato(bool aceptoContrato);
        bool GetAceptoContrato();

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

        void SetTieneMg(bool tiene);

        bool GetTieneMg();

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

        void SetArmaTuPack(ArmaTuPackModel data);

        ArmaTuPackModel GetArmaTuPack();

        void SetBEEstrategia(string key, List<ServiceOferta.BEEstrategia> data);

        List<ServiceOferta.BEEstrategia> GetBEEstrategia(string key);

        void SetPedidosFacturados(PedidoWebClientePrincipalMobilModel model);

        PedidoWebClientePrincipalMobilModel GetPedidosFacturados();

        List<BEPedidoWebDetalle> GetDetallesPedidoSetAgrupado();

        void SetDetallesPedidoSetAgrupado(List<BEPedidoWebDetalle> detallesPedidoWeb);

        void SetUrlVc(int id);

        int GetUrlVc();

        void SetMiAcademia(int id);

        int GetMiAcademia();

        void SetMiAcademiaVideo(int id);

        int GetMiAcademiaVideo();

        void SetMiAcademiaParametro(string value);

        string GetMiAcademiaParametro();

        void SetPedidoValidado(bool validado);

        bool GetPedidoValidado();

        void setBEUsuarioModel(List<ServiceUsuario.BEUsuario> model);

        List<ServiceUsuario.BEUsuario> getBEUsuarioModel();

        IOfertaDelDia OfertaDelDia { get; }

        BEConfiguracionProgramaNuevas GetConfiguracionProgNuevas();
        void SetConfiguracionProgramaNuevas(BEConfiguracionProgramaNuevas configuracion);
        bool GetProcesoKitNuevas();
        void SetProcesoKitNuevas(bool proceso);
        string GetCuvKitNuevas();
        void SetCuvKitNuevas(string cuvKit);
        string GetMensajeKitNuevas();
        void SetMensajeKitNuevas(string mensajeKit);
        int GetLimElectivosProgNuevas();
        void SetLimElectivosProgNuevas(int limElectivos);
        List<PremioElectivoModel> GetListPremioElectivo();
        void SetListPremioElectivo(List<PremioElectivoModel> listPremioElectivo);
        Dictionary<string, PremioProgNuevasOFModel> GetDictPremioProgNuevasOF();
        void SetDictPremioProgNuevasOF(Dictionary<string, PremioProgNuevasOFModel> dictPremioProgNuevasOF);

        void SetBuscadorYFiltrosConfig(BuscadorYFiltrosConfiguracionModel buscadorYFiltrosModel);

        BuscadorYFiltrosConfiguracionModel GetBuscadorYFiltrosConfig();

        void SetConfigMicroserviciosPersonalizacion(MSPersonalizacionConfiguracionModel msPersonalizacionModel);
        MSPersonalizacionConfiguracionModel GetConfigMicroserviciosPersonalizacion();

        void SetRecomendacionesConfig(RecomendacionesConfiguracionModel recomendacionesConfiguracionModel);

        RecomendacionesConfiguracionModel GetRecomendacionesConfig();

        void SetOcultarBannerApp(dynamic val);

        dynamic GetOcultarBannerApp();

        void SetBannerApp(BEComunicado val);

        BEComunicado GetBannerApp();

        void SetPrimeraVezSessionMobile(dynamic val);

        dynamic GetPrimeraVezSessionMobile();

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

        void SetCDRPedidoFacturado(List<BEPedidoWeb> val);

        List<BEPedidoWeb> GetCDRPedidoFacturado();

        void SetCDRCampanias(List<CampaniaModel> val);

        List<CampaniaModel> GetCDRCampanias();

        void SetCDRPedidoID(List<CampaniaModel> val);

        List<CampaniaModel> GetCDRPedidoID();

        void SetListaCDRDetalle(CDRWebModel val);

        CDRWebModel GetListaCDRDetalle();

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

        void SetListaProductoShowRoomCpc(List<BEShowRoomOferta> val);

        List<BEShowRoomOferta> GetListaProductoShowRoomCpc();

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

        BEUsuarioDatos GetDatosUsuario();

        IMasGanadoras MasGanadoras { get; }
        bool GetMostrarBannerNuevas();

        void SetMostrarBannerNuevas(bool mostrarBannerNuevas);

        void SetJwtApiSomosBelcorp(string token);

        string GetJwtApiSomosBelcorp();
        void SetUsuarioOpciones(List<UsuarioOpcionesModel> val);
        List<UsuarioOpcionesModel> GetUsuarioOpciones();

        void SetConsultoraDigital(bool val);
        bool? GetConsultoraDigital();
        
        void SetConsultoraCaminoBrillante(BEConsultoraCaminoBrillante val);
        BEConsultoraCaminoBrillante GetConsultoraCaminoBrillante();

        void SetKitCaminoBrillante(List<BEKitCaminoBrillante> val);
        List<BEKitCaminoBrillante> GetKitCaminoBrillante();

        void SetDemostradoresCaminoBrillante(List<BEDesmostradoresCaminoBrillante> val);
        List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillante();
    }
}
