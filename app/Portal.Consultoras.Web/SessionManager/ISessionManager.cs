using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.SessionManager
{
    public interface ISessionManager
    {
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

        void SetTiposEstrategia(List<BETipoEstrategia> tiposEstrategia);

        List<BETipoEstrategia> GetTiposEstrategia();

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
        
        void SetDatosPagoVisa(PagoEnLineaModel model);

        IShowRoom ShowRoom { get; }

        PagoEnLineaModel GetDatosPagoVisa();
    }
}
