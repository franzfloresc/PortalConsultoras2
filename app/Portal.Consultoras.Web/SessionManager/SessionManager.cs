﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Areas.Mobile.Models;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using Portal.Consultoras.Web.ServiceCDR;
//using Portal.Consultoras.Web.ServiceCliente;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using System;
using System.Collections.Generic;
using System.Web;

namespace Portal.Consultoras.Web.SessionManager
{
    public class SessionManager : ISessionManager
    {
        private static ISessionManager _instance;
        private static IShowRoom _showRoom;

        public SessionManager()
        {
            if (_showRoom == null)
                _showRoom = new ShowRoom();
        }

        public static ISessionManager Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new SessionManager();

                return _instance;
            }
        }

        public IShowRoom ShowRoom
        {
            get
            {
                return _showRoom;
            }
        }

        BEPedidoWeb ISessionManager.GetPedidoWeb()
        {
            return (BEPedidoWeb)HttpContext.Current.Session["PedidoWeb"];
        }

        void ISessionManager.SetPedidoWeb(BEPedidoWeb pedidoWeb)
        {
            HttpContext.Current.Session["PedidoWeb"] = pedidoWeb;
        }

        List<BEPedidoWebDetalle> ISessionManager.GetDetallesPedido()
        {
            return (List<BEPedidoWebDetalle>)HttpContext.Current.Session["PedidoWebDetalle"];
        }

        void ISessionManager.SetDetallesPedido(List<BEPedidoWebDetalle> detallesPedidoWeb)
        {
            HttpContext.Current.Session["PedidoWebDetalle"] = detallesPedidoWeb;
        }

        List<BEPedidoWebDetalle> ISessionManager.GetDetallesPedidoSetAgrupado()
        {
            return (List<BEPedidoWebDetalle>)HttpContext.Current.Session["PedidoWebSetAgrupado"];
        }

        void ISessionManager.SetDetallesPedidoSetAgrupado(List<BEPedidoWebDetalle> detallesPedidoWeb)
        {
            HttpContext.Current.Session["PedidoWebSetAgrupado"] = detallesPedidoWeb;
        }
        List<ObservacionModel> ISessionManager.GetObservacionesProl()
        {
            return (List<ObservacionModel>)HttpContext.Current.Session["ObservacionesPROL"];
        }

        void ISessionManager.SetObservacionesProl(List<ObservacionModel> observaciones)
        {
            HttpContext.Current.Session["ObservacionesPROL"] = observaciones;
        }

        void ISessionManager.SetEsShowRoom(string flag)
        {
            HttpContext.Current.Session["EsShowRoom"] = flag;
        }

        bool ISessionManager.GetEsShowRoom()
        {
            var esShowRoom = HttpContext.Current.Session["EsShowRoom"];
            return esShowRoom != null && esShowRoom.ToString().Trim() == "1";
        }

        void ISessionManager.SetMostrarShowRoomProductos(string flag)
        {
            HttpContext.Current.Session["MostrarShowRoomProductos"] = flag;
        }

        bool ISessionManager.GetMostrarShowRoomProductos()
        {
            var mostrarShowRoomProductos = HttpContext.Current.Session["MostrarShowRoomProductos"];
            return mostrarShowRoomProductos != null && mostrarShowRoomProductos.ToString().Trim() == "1";
        }

        void ISessionManager.SetMostrarShowRoomProductosExpiro(string flag)
        {
            HttpContext.Current.Session["MostrarShowRoomProductosExpiro"] = flag;
        }

        bool ISessionManager.GetMostrarShowRoomProductosExpiro()
        {
            var mostrarShowRoomProductosExpiro = HttpContext.Current.Session["MostrarShowRoomProductosExpiro"];
            return mostrarShowRoomProductosExpiro != null && mostrarShowRoomProductosExpiro.ToString().Trim() == "1";
        }

        void ISessionManager.SetTiposEstrategia(List<ServicePedido.BETipoEstrategia> tiposEstrategia)
        {
            HttpContext.Current.Session["ListaTipoEstrategia"] = tiposEstrategia;
        }

        List<ServicePedido.BETipoEstrategia> ISessionManager.GetTiposEstrategia()
        {
            return (List<ServicePedido.BETipoEstrategia>)HttpContext.Current.Session["ListaTipoEstrategia"];
        }

        void ISessionManager.SetRevistaDigital(RevistaDigitalModel revistaDigital)
        {
            HttpContext.Current.Session[Constantes.ConstSession.RevistaDigital] = revistaDigital;
        }

        RevistaDigitalModel ISessionManager.GetRevistaDigital()
        {
            return ((RevistaDigitalModel)HttpContext.Current.Session[Constantes.ConstSession.RevistaDigital]) ?? new RevistaDigitalModel();
        }

        void ISessionManager.SetHerramientasVenta(HerramientasVentaModel herramientasVenta)
        {
            HttpContext.Current.Session[Constantes.ConstSession.HerramientasVenta] = herramientasVenta;
        }

        HerramientasVentaModel ISessionManager.GetHerramientasVenta()
        {
            return ((HerramientasVentaModel)HttpContext.Current.Session[Constantes.ConstSession.HerramientasVenta]) ?? new HerramientasVentaModel();
        }

        void ISessionManager.SetGuiaNegocio(GuiaNegocioModel modeloGnd)
        {
            HttpContext.Current.Session[Constantes.ConstSession.GuiaNegocio] = modeloGnd;
        }

        GuiaNegocioModel ISessionManager.GetGuiaNegocio()
        {
            return ((GuiaNegocioModel)HttpContext.Current.Session[Constantes.ConstSession.GuiaNegocio]) ?? new GuiaNegocioModel();
        }

        void ISessionManager.SetIsContrato(int isContrato)
        {
            HttpContext.Current.Session["IsContrato"] = isContrato;
        }

        int ISessionManager.GetIsContrato()
        {
            return (int)HttpContext.Current.Session["IsContrato"];
        }

        void ISessionManager.SetIsOfertaPack(int isOfertaPack)
        {
            HttpContext.Current.Session["IsOfertaPack"] = isOfertaPack;
        }

        int ISessionManager.GetIsOfertaPack()
        {
            return (int)HttpContext.Current.Session["IsOfertaPack"];
        }

        void ISessionManager.SetConfiguracionesPaisModel(List<ConfiguracionPaisModel> configuracionesPais)
        {
            HttpContext.Current.Session[Constantes.ConstSession.ConfiguracionPaises] = configuracionesPais;
        }

        List<ConfiguracionPaisModel> ISessionManager.GetConfiguracionesPaisModel()
        {
            return (List<ConfiguracionPaisModel>)HttpContext.Current.Session[Constantes.ConstSession.ConfiguracionPaises] ?? new List<ConfiguracionPaisModel>();
        }

        void ISessionManager.SetOfertaFinalModel(OfertaFinalModel ofertaFinalModel)
        {
            HttpContext.Current.Session[Constantes.ConstSession.OfertaFinal] = ofertaFinalModel;
        }

        OfertaFinalModel ISessionManager.GetOfertaFinalModel()
        {
            return (OfertaFinalModel)HttpContext.Current.Session[Constantes.ConstSession.OfertaFinal] ??
                   new OfertaFinalModel();
        }

        void ISessionManager.SetEventoFestivoDataModel(EventoFestivoDataModel eventoFestivoDataModel)
        {
            HttpContext.Current.Session[Constantes.ConstSession.EventoFestivo] = eventoFestivoDataModel;
        }

        EventoFestivoDataModel ISessionManager.GetEventoFestivoDataModel()
        {
            return (EventoFestivoDataModel)HttpContext.Current.Session[Constantes.ConstSession.EventoFestivo] ?? new EventoFestivoDataModel();
        }

        void ISessionManager.SetTieneLan(bool tieneLan)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneLan] = tieneLan;
        }

        bool ISessionManager.GetTieneLan()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneLan] ?? false);
        }

        void ISessionManager.SetTieneLanX1(bool tieneLanX1)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneLanX1] = tieneLanX1;
        }

        bool ISessionManager.GetTieneLanX1()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneLanX1] ?? false);
        }

        void ISessionManager.SetTieneOpt(bool tieneOpt)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneOpt] = tieneOpt;
        }

        bool ISessionManager.GetTieneOpt()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneOpt] ?? false);
        }

        void ISessionManager.SetTieneOpm(bool tieneOpm)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneOpm] = tieneOpm;
        }

        bool ISessionManager.GetTieneOpm()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneOpm] ?? false);
        }

        void ISessionManager.SetTieneOpmX1(bool tieneOpmX1)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneOpmX1] = tieneOpmX1;
        }

        bool ISessionManager.GetTieneOpmX1()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneOpmX1] ?? false);
        }

        public void SetTieneHv(bool tieneHv)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneHv] = tieneHv;
        }

        public bool GetTieneHv()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneHv] ?? false);
        }

        public void SetTieneHvX1(bool tieneHv)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneHvX1] = tieneHv;
        }

        public bool GetTieneHvX1()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneHvX1] ?? false);
        }

        void ISessionManager.SetUserData(UsuarioModel usuario)
        {
            HttpContext.Current.Session["UserData"] = usuario;
        }

        UsuarioModel ISessionManager.GetUserData()
        {
            return (UsuarioModel)HttpContext.Current.Session["UserData"];
        }

        void ISessionManager.SetMontosProl(List<ObjMontosProl> montosProl)
        {
            HttpContext.Current.Session[Constantes.ConstSession.PROL_CalculoMontosProl] = montosProl;
        }

        List<ObjMontosProl> ISessionManager.GetMontosProl()
        {
            return (List<ObjMontosProl>)HttpContext.Current.Session[Constantes.ConstSession.PROL_CalculoMontosProl];
        }

        void ISessionManager.SetMisCertificados(List<MiCertificadoModel> lista)
        {
            HttpContext.Current.Session[Constantes.ConstSession.MisCertificados] = lista;
        }

        List<MiCertificadoModel> ISessionManager.GetMisCertificados()
        {
            return (List<MiCertificadoModel>)HttpContext.Current.Session[Constantes.ConstSession.MisCertificados];
        }

        void ISessionManager.SetMisCertificadosData(List<BEMiCertificado> lista)
        {
            HttpContext.Current.Session[Constantes.ConstSession.MisCertificadosData] = lista;
        }

        List<BEMiCertificado> ISessionManager.GetMisCertificadosData()
        {
            return (List<BEMiCertificado>)HttpContext.Current.Session[Constantes.ConstSession.MisCertificadosData];
        }

        public void SetFlagLogCargaOfertas(bool habilitarLog)
        {
            HttpContext.Current.Session[Constantes.ConstSession.HabilidarLogCargaOferta] = habilitarLog;
        }

        public bool GetFlagLogCargaOfertas()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.HabilidarLogCargaOferta] ?? false);
        }

        void ISessionManager.SetMenuContenedorActivo(MenuContenedorModel menuContenedorActivo)
        {
            HttpContext.Current.Session[Constantes.ConstSession.MenuContenedorActivo] = menuContenedorActivo;
        }

        MenuContenedorModel ISessionManager.GetMenuContenedorActivo()
        {
            return (MenuContenedorModel)(HttpContext.Current.Session[Constantes.ConstSession.MenuContenedorActivo]) ?? new MenuContenedorModel();
        }

        void ISessionManager.SetMenuContenedor(List<ConfiguracionPaisModel> menuContenedor)
        {
            HttpContext.Current.Session[Constantes.ConstSession.MenuContenedor] = menuContenedor;
        }

        List<ConfiguracionPaisModel> ISessionManager.GetMenuContenedor()
        {
            return (List<ConfiguracionPaisModel>)(HttpContext.Current.Session[Constantes.ConstSession.MenuContenedor]) ?? new List<ConfiguracionPaisModel>();
        }

        void ISessionManager.SetSeccionesContenedor(int campaniaId, List<BEConfiguracionOfertasHome> seccionesContenedor)
        {
            string seccionesXCampaniaSessionKey = Constantes.ConstSession.ListadoSeccionPalanca + campaniaId;
            HttpContext.Current.Session[seccionesXCampaniaSessionKey] = seccionesContenedor;
        }

        List<BEConfiguracionOfertasHome> ISessionManager.GetSeccionesContenedor(int campaniaId)
        {
            string seccionesXCampaniaSessionKey = Constantes.ConstSession.ListadoSeccionPalanca + campaniaId;
            return (List<BEConfiguracionOfertasHome>)(HttpContext.Current.Session[seccionesXCampaniaSessionKey]);
        }

        void ISessionManager.SetListFiltersFAV(List<ServiceSAC.BETablaLogicaDatos> lista)
        {
            HttpContext.Current.Session["ListFiltersFAV"] = lista;
        }

        List<ServiceSAC.BETablaLogicaDatos> ISessionManager.GetListFiltersFAV()
        {
            return (List<ServiceSAC.BETablaLogicaDatos>)HttpContext.Current.Session["ListFiltersFAV"];
        }

        void ISessionManager.SetStartSession(DateTime fecha)
        {
            HttpContext.Current.Session["StartSession"] = fecha;
        }

        DateTime ISessionManager.GetStartSession()
        {
            return (DateTime)HttpContext.Current.Session["StartSession"];
        }

        void ISessionManager.SetDatosPagoVisa(PagoEnLineaModel model)
        {
            HttpContext.Current.Session[Constantes.ConstSession.DatosPagoVisa] = model;
        }

        PagoEnLineaModel ISessionManager.GetDatosPagoVisa()
        {
            return (PagoEnLineaModel)HttpContext.Current.Session[Constantes.ConstSession.DatosPagoVisa];
        }

        public void SetEstrategiaODD(Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia.DataModel data)
        {
            HttpContext.Current.Session["EstrategiaODD"] = data;
        }

        public Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia.DataModel GetEstrategiaODD()
        {
            return (Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia.DataModel)HttpContext.Current.Session["EstrategiaODD"];
        }

        public void SetEstrategiaSR(Portal.Consultoras.Web.Models.Estrategia.ShowRoom.ConfigModel data)
        {
            HttpContext.Current.Session["ConfigEstrategiaSR"] = data;
        }

        public Portal.Consultoras.Web.Models.Estrategia.ShowRoom.ConfigModel GetEstrategiaSR()
        {
            return (Portal.Consultoras.Web.Models.Estrategia.ShowRoom.ConfigModel)HttpContext.Current.Session["ConfigEstrategiaSR"];
        }

        void ISessionManager.SetPedidosFacturados(PedidoWebClientePrincipalMobilModel model)
        {
            HttpContext.Current.Session[Constantes.ConstSession.PedidosFacturados] = model;
        }

        PedidoWebClientePrincipalMobilModel ISessionManager.GetPedidosFacturados()
        {
            return (PedidoWebClientePrincipalMobilModel)HttpContext.Current.Session[Constantes.ConstSession.PedidosFacturados];
        }

        public void SetMiAcademia(int id)
        {
            HttpContext.Current.Session["MiAcademia"] = id;
        }

        public int GetMiAcademia()
        {
            return (int)HttpContext.Current.Session["MiAcademia"];
        }

        void ISessionManager.setBEUsuarioModel(List<ServiceUsuario.BEUsuario> model)
        {
            HttpContext.Current.Session["BEUsuarioModel"] = model;
        }

        List<ServiceUsuario.BEUsuario> ISessionManager.getBEUsuarioModel()
        {
            return (List<ServiceUsuario.BEUsuario>)HttpContext.Current.Session["BEUsuarioModel"];
        }

        EstrategiaPersonalizadaProductoModel ISessionManager.ProductoTemporal
        {
            get
            {
                return (EstrategiaPersonalizadaProductoModel)HttpContext.Current.Session[Constantes.ConstSession.ProductoTemporal];
            }

            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ProductoTemporal] = value;
            }
        }

        void ISessionManager.SetProductoTemporal(EstrategiaPersonalizadaProductoModel modelo)
        {
            HttpContext.Current.Session[Constantes.ConstSession.ProductoTemporal] = modelo;
        }

        EstrategiaPersonalizadaProductoModel ISessionManager.GetProductoTemporal()
        {
            return (EstrategiaPersonalizadaProductoModel)HttpContext.Current.Session[Constantes.ConstSession.ProductoTemporal];
        }
        

        public void SetPedidoValidado(bool validado)
        {
            HttpContext.Current.Session["PedidoValidado"] = validado;
        }

        public bool GetPedidoValidado()
        {
            return Convert.ToBoolean(HttpContext.Current.Session["PedidoValidado"]);
        }

        // -----------------------------------

        void ISessionManager.SetOcultarBannerApp(bool val) {
            HttpContext.Current.Session["OcultarBannerApp"] = val;
        }

        bool ISessionManager.GetOcultarBannerApp() {
            return Convert.ToBoolean(HttpContext.Current.Session["OcultarBannerApp"]);
        }

        void ISessionManager.SetBannerApp(dynamic val)
        {
            HttpContext.Current.Session["BannerApp"] = val;
        }

        dynamic ISessionManager.GetBannerApp()
        {
            return Convert.ToBoolean(HttpContext.Current.Session["BannerApp"]);
        }

        void ISessionManager.SetPrimeraVezSessionMobile(int val)
        {
            HttpContext.Current.Session["PrimeraVezSessionMobile"] = val;
        }

        int ISessionManager.GetPrimeraVezSessionMobile()
        {
            return (int)HttpContext.Current.Session["PrimeraVezSessionMobile"];
        }

        void ISessionManager.SetIngresoPortalConsultoras(bool val)
        {
            HttpContext.Current.Session[Constantes.ConstSession.IngresoPortalConsultoras] = val;
        }

        bool ISessionManager.GetIngresoPortalConsultoras()
        {
            return (bool)HttpContext.Current.Session[Constantes.ConstSession.IngresoPortalConsultoras];
        }

        void ISessionManager.SetConsultoraNuevaBannerAppMostrar(bool val)
        {
            HttpContext.Current.Session[Constantes.ConstSession.ConsultoraNuevaBannerAppMostrar] = val;
        }

        bool ISessionManager.GetConsultoraNuevaBannerAppMostrar()
        {
            var val = HttpContext.Current.Session[Constantes.ConstSession.ConsultoraNuevaBannerAppMostrar];
            if (val == null) { return false; }
            return (bool)val;
        }

        void ISessionManager.SetTipoPopUpMostrar(int val)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TipoPopUpMostrar] = val;
        }

        int ISessionManager.GetTipoPopUpMostrar()
        {
            var val = HttpContext.Current.Session[Constantes.ConstSession.TipoPopUpMostrar];
            if (val == null) { return 0; }
            return (int)val;
        }
        
        void ISessionManager.SetClientesByConsultora(dynamic val)
        {
            HttpContext.Current.Session[Constantes.ConstSession.ClientesByConsultora] = val;
        }

        dynamic ISessionManager.GetClientesByConsultora()
        {
            var val = HttpContext.Current.Session[Constantes.ConstSession.ClientesByConsultora];
            return val;
        }

        void ISessionManager.SetProductosCatalogoPersonalizado(List<ProductoModel> val)
        {
            HttpContext.Current.Session["ProductosCatalogoPersonalizado"] = val;
        }

        List<ProductoModel> ISessionManager.GetProductosCatalogoPersonalizado()
        {
            var val = HttpContext.Current.Session["ProductosCatalogoPersonalizado"];

            return (List<ProductoModel>)val;
        }

        void ISessionManager.SetobjMisPedidos(dynamic val)
        {
            HttpContext.Current.Session["objMisPedidos"] = val;
        }

        dynamic ISessionManager.GetobjMisPedidos()
        {
            var val = HttpContext.Current.Session["objMisPedidos"];

            return (dynamic)val;
        }

        void ISessionManager.SetobjMisPedidosDetalle(dynamic val)
        {
            HttpContext.Current.Session["objMisPedidosDetalle"] = val;
        }

        dynamic ISessionManager.GetobjMisPedidosDetalle()
        {
            var val = HttpContext.Current.Session["objMisPedidosDetalle"];

            return (dynamic)val;
        }

        void ISessionManager.SetobjMisPedidosDetalleVal(dynamic val)
        {
            HttpContext.Current.Session["objMisPedidosDetalleVal"] = val;
        }

        dynamic ISessionManager.GetobjMisPedidosDetalleVal()
        {
            var val = HttpContext.Current.Session["objMisPedidosDetalleVal"];

            return (dynamic)val;
        }

        void ISessionManager.SetkeyFechaGetCantidadPedidos(dynamic val)
        {
            HttpContext.Current.Session["keyFechaGetCantidadPedidos"] = val;
        }

        dynamic ISessionManager.GetkeyFechaGetCantidadPedidos()
        {
            var val = HttpContext.Current.Session["keyFechaGetCantidadPedidos"];

            return (dynamic)val;
        }

        void ISessionManager.SetkeyCantidadGetCantidadPedidos(dynamic val)
        {
            HttpContext.Current.Session["keyCantidadGetCantidadPedidos"] = val;
        }

        dynamic ISessionManager.GetkeyCantidadGetCantidadPedidos()
        {
            var val = HttpContext.Current.Session["keyCantidadGetCantidadPedidos"];

            return (dynamic)val;
        }

        void ISessionManager.SetFichaProductoTemporal(FichaProductoDetalleModel val)
        {
            HttpContext.Current.Session[Constantes.SessionNames.FichaProductoTemporal] = val;
        }

        FichaProductoDetalleModel ISessionManager.GetFichaProductoTemporal()
        {
            var val = HttpContext.Current.Session[Constantes.SessionNames.FichaProductoTemporal];

            return (FichaProductoDetalleModel)val;
        }
        void ISessionManager.SetCDRCampanias(List<CampaniaModel> val)
        {
            HttpContext.Current.Session[Constantes.ConstSession.CDRCampanias] = val;
        }

        List<CampaniaModel> ISessionManager.GetCDRCampanias()
        {
            var val = HttpContext.Current.Session[Constantes.ConstSession.CDRCampanias];

            return (List<CampaniaModel>)val;
        }

        void ISessionManager.SetListaCDRDetalle(dynamic val)
        {
            HttpContext.Current.Session["ListaCDRDetalle"] = val;
        }

        dynamic ISessionManager.GetListaCDRDetalle()
        {
            var val = HttpContext.Current.Session["ListaCDRDetalle"];

            return (dynamic)val;
        }

        void ISessionManager.SetCDRWebDetalle(dynamic val)
        {
            HttpContext.Current.Session["CDRWebDetalle"] = val;
        }

        dynamic ISessionManager.GetCDRWebDetalle()
        {
            var val = HttpContext.Current.Session["CDRWebDetalle"];

            return (dynamic)val;
        }

        void ISessionManager.SetfechaGetNotificacionesSinLeer(dynamic val)
        {
            HttpContext.Current.Session["fechaGetNotificacionesSinLeer"] = val;
        }

        dynamic ISessionManager.GetfechaGetNotificacionesSinLeer()
        {
            var val = HttpContext.Current.Session["fechaGetNotificacionesSinLeer"];

            return (dynamic)val;
        }

        void ISessionManager.SetcantidadGetNotificacionesSinLeer(dynamic val)
        {
            HttpContext.Current.Session["cantidadGetNotificacionesSinLeer"] = val;
        }

        dynamic ISessionManager.GetcantidadGetNotificacionesSinLeer()
        {
            var val = HttpContext.Current.Session["cantidadGetNotificacionesSinLeer"];

            return (dynamic)val;
        }

        void ISessionManager.SetPedidoFIC(dynamic val)
        {
            HttpContext.Current.Session["PedidoFIC"] = val;
        }

        dynamic ISessionManager.GetPedidoFIC()
        {
            var val = HttpContext.Current.Session["PedidoFIC"];

            return (dynamic)val;
        }

        void ISessionManager.SetListaProductoFaltantes(List<BEProductoFaltante> val)
        {
            HttpContext.Current.Session["ListaProductoFaltantes"] = val;
        }

        List<BEProductoFaltante> ISessionManager.GetListaProductoFaltantes()
        {
            var val = HttpContext.Current.Session["ListaProductoFaltantes"];

            return (List<BEProductoFaltante>)val;
        }

        void ISessionManager.SetPrimeraVezSession(dynamic val)
        {
            HttpContext.Current.Session["PrimeraVezSession"] = val;
        }

        dynamic ISessionManager.GetPrimeraVezSession()
        {
            var val = HttpContext.Current.Session["PrimeraVezSession"];

            return (dynamic)val;
        }

        void ISessionManager.SetTokenPedidoAutentico(string val)
        {
            HttpContext.Current.Session["TokenPedidoAutentico"] = val;
        }

        string ISessionManager.GetTokenPedidoAutentico()
        {
            var val = HttpContext.Current.Session["TokenPedidoAutentico"];
            if (val == null) { return ""; }
            return (string)val;
        }

        void ISessionManager.Setentradas(List<AdministrarFeErratasModel> val)
        {
            HttpContext.Current.Session["entradas"] = val;
        }

        List<AdministrarFeErratasModel> ISessionManager.Getentradas()
        {
            var val = HttpContext.Current.Session["entradas"];

            return (List<AdministrarFeErratasModel>)val;
        }

        void ISessionManager.SetcarpetaPais(string val)
        {
            HttpContext.Current.Session["carpetaPais"] = val;
        }

        string ISessionManager.GetcarpetaPais()
        {
            var val = HttpContext.Current.Session["carpetaPais"];
            if (val == null) { return ""; }
            return (string)val;
        }

        void ISessionManager.SetListadoEstadoCuenta(List<EstadoCuentaModel> val)
        {
            HttpContext.Current.Session["ListadoEstadoCuenta"] = val;
        }

        List<EstadoCuentaModel> ISessionManager.GetListadoEstadoCuenta()
        {
            var val = HttpContext.Current.Session["ListadoEstadoCuenta"];

            return (List<EstadoCuentaModel>)val;
        }

        void ISessionManager.SetCDRPedidosFacturado(List<BEPedidoWeb> val)
        {
            HttpContext.Current.Session["CDRPedidosFacturado"] = val;
        }

        List<BEPedidoWeb> ISessionManager.GetCDRPedidosFacturado()
        {
            var val = HttpContext.Current.Session["CDRPedidosFacturado"];

            return (List<BEPedidoWeb>)val;
        }

        void ISessionManager.SetCDRMotivoOperacion(List<BECDRWebMotivoOperacion> val)
        {
            HttpContext.Current.Session["CDRMotivoOperacion"] = val;
        }

        List<BECDRWebMotivoOperacion> ISessionManager.GetCDRMotivoOperacion()
        {
            var val = HttpContext.Current.Session["CDRMotivoOperacion"];

            return (List<BECDRWebMotivoOperacion>)val;
        }

        void ISessionManager.SetCDRWebDatos(List<BECDRWebDatos> val)
        {
            HttpContext.Current.Session["CDRWebDatos"] = val;
        }

        List<BECDRWebDatos> ISessionManager.GetCDRWebDatos()
        {
            var val = HttpContext.Current.Session["CDRWebDatos"];

            return (List<BECDRWebDatos>)val;
        }

        void ISessionManager.SetCDRDescripcion(List<BECDRWebDescripcion> val)
        {
            HttpContext.Current.Session["CDRDescripcion"] = val;
        }

        List<BECDRWebDescripcion> ISessionManager.GetCDRDescripcion()
        {
            var val = HttpContext.Current.Session["CDRDescripcion"];

            return (List<BECDRWebDescripcion>)val;
        }

        void ISessionManager.SetCDRWeb(dynamic val)
        {
            HttpContext.Current.Session["CDRWeb"] = val;
        }

        dynamic ISessionManager.GetCDRWeb()
        {
            var val = HttpContext.Current.Session["CDRWeb"];

            return (dynamic)val;
        }

        void ISessionManager.SetCDRParametria(List<BECDRParametria> val)
        {
            HttpContext.Current.Session["CDRParametria"] = val;
        }

        List<BECDRParametria> ISessionManager.GetCDRParametria()
        {
            var val = HttpContext.Current.Session["CDRParametria"];

            return (List<BECDRParametria>)val;
        }

        void ISessionManager.SetListaProductoShowRoom(List<BEShowRoomOferta> val)
        {
            HttpContext.Current.Session["ListaProductoShowRoom"] = val;
        }

        List<BEShowRoomOferta> ISessionManager.GetListaProductoShowRoom()
        {
            var val = HttpContext.Current.Session["ListaProductoShowRoom"];

            return (List<BEShowRoomOferta>)val;
        }

        void ISessionManager.SetResultadoZona(dynamic val)
        {
            HttpContext.Current.Session["ResultadoZona"] = val;
        }

        dynamic ISessionManager.GetResultadoZona()
        {
            var val = HttpContext.Current.Session["ResultadoZona"];

            return (dynamic)val;
        }

        void ISessionManager.SetListaEstrategia(dynamic val)
        {
            HttpContext.Current.Session["ListaEstrategia"] = val;
        }

        dynamic ISessionManager.GetListaEstrategia()
        {
            var val = HttpContext.Current.Session["ListaEstrategia"];

            return (dynamic)val;
        }

        void ISessionManager.SetListaProductoShowRoomCpc(List<BEShowRoomOferta> val)
        {
            HttpContext.Current.Session["ListaProductoShowRoomCpc"] = val;
        }

        List<BEShowRoomOferta> ISessionManager.GetListaProductoShowRoomCpc()
        {
            var val = HttpContext.Current.Session["ListaProductoShowRoomCpc"];

            return (List<BEShowRoomOferta>)val;
        }

        void ISessionManager.SetActualizarDatosConsultora(bool val)
        {
            HttpContext.Current.Session["ActualizarDatosConsultora"] = val;
        }

        bool ISessionManager.GetActualizarDatosConsultora()
        {
            var val = HttpContext.Current.Session["ActualizarDatosConsultora"];
            if (val == null) { return false; }
            return (bool)val;
        }

        void ISessionManager.SetSuenioNavidad(int val)
        {
            HttpContext.Current.Session["SuenioNavidad"] = val;
        }

        int ISessionManager.GetSuenioNavidad()
        {
            var val = HttpContext.Current.Session["SuenioNavidad"];
            if (val == null) { return 0; }
            return (int)val;
        }

        void ISessionManager.SetUserFiltersFAV(dynamic val)
        {
            HttpContext.Current.Session["UserFiltersFAV"] = val;
        }

        dynamic ISessionManager.GetUserFiltersFAV()
        {
            var val = HttpContext.Current.Session["UserFiltersFAV"];

            return (dynamic)val;
        }

        void ISessionManager.SetProductosCatalogoPersonalizadoFilter(dynamic val)
        {
            HttpContext.Current.Session["ProductosCatalogoPersonalizadoFilter"] = val;
        }

        dynamic ISessionManager.GetProductosCatalogoPersonalizadoFilter()
        {
            var val = HttpContext.Current.Session["ProductosCatalogoPersonalizadoFilter"];

            return (dynamic)val;
        }

        void ISessionManager.SetPaisID(int val)
        {
            HttpContext.Current.Session["PaisID"] = val;
        }

        int ISessionManager.GetPaisID()
        {
            var val = HttpContext.Current.Session["PaisID"];
            if (val == null) { return 0; }
            return (int)val;
        }

        void ISessionManager.SetlstZonasActivas(List<ZonaModel> val)
        {
            HttpContext.Current.Session["lstZonasActivas"] = val;
        }

        List<ZonaModel> ISessionManager.GetlstZonasActivas()
        {
            var val = HttpContext.Current.Session["lstZonasActivas"];

            return (List<ZonaModel>)val;
        }

        void ISessionManager.SetlstZonasInactivas(List<ZonaModel> val)
        {
            HttpContext.Current.Session["lstZonasInactivas"] = val;
        }

        List<ZonaModel> ISessionManager.GetlstZonasInactivas()
        {
            var val = HttpContext.Current.Session["lstZonasInactivas"];

            return (List<ZonaModel>)val;
        }

        void ISessionManager.SetZonaCodigoEliminar(string val)
        {
            HttpContext.Current.Session["ZonaCodigoEliminar"] = val;
        }

        string ISessionManager.GetZonaCodigoEliminar()
        {
            var val = HttpContext.Current.Session["ZonaCodigoEliminar"];
            if (val == null) { return ""; }
            return (string)val;
        }

        void ISessionManager.SetIngresoPortalLideres(bool val)
        {
            HttpContext.Current.Session["IngresoPortalLideres"] = val;
        }

        bool ISessionManager.GetIngresoPortalLideres()
        {
            var val = HttpContext.Current.Session["IngresoPortalLideres"];
            if (val == null) { return false; }
            return (bool)val;
        }

        void ISessionManager.Seterrores(List<MatrizCampaniaModel> val)
        {
            HttpContext.Current.Session["errores"] = val;
        }

        List<MatrizCampaniaModel> ISessionManager.Geterrores()
        {
            var val = HttpContext.Current.Session["errores"];

            return (List<MatrizCampaniaModel>)val;
        }

        void ISessionManager.SetMisPedidosDetallePorCampania(dynamic val)
        {
            HttpContext.Current.Session["MisPedidosDetallePorCampania"] = val;
        }

        dynamic ISessionManager.GetMisPedidosDetallePorCampania()
        {
            var val = HttpContext.Current.Session["MisPedidosDetallePorCampania"];
            if (val == null) { return ""; }
            return (string)val;
        }

        void ISessionManager.SetMisPedidosDetallePorCampaniaCampania(string val)
        {
            HttpContext.Current.Session["MisPedidosDetallePorCampaniaCampania"] = val;
        }

        string ISessionManager.GetMisPedidosDetallePorCampaniaCampania()
        {
            var val = HttpContext.Current.Session["MisPedidosDetallePorCampaniaCampania"];
            if (val == null) { return ""; }
            return (string)val;
        }

        void ISessionManager.SetMisPedidosDetallePorCampaniaEstado(string val)
        {
            HttpContext.Current.Session["MisPedidosDetallePorCampaniaEstado"] = val;
        }

        string ISessionManager.GetMisPedidosDetallePorCampaniaEstado()
        {
            var val = HttpContext.Current.Session["MisPedidosDetallePorCampaniaEstado"];
            if (val == null) { return ""; }
            return (string)val;
        }

        void ISessionManager.SetMisPedidosDetallePorCampaniaPedidoId(int val)
        {
            HttpContext.Current.Session["MisPedidosDetallePorCampaniaPedidoId"] = val;
        }

        int ISessionManager.GetMisPedidosDetallePorCampaniaPedidoId()
        {
            var val = HttpContext.Current.Session["MisPedidosDetallePorCampaniaPedidoId"];
            if (val == null) { return 0; }
            return (int)val;
        }

        void ISessionManager.SetCDRExpressMensajes(List<BETablaLogicaDatos> val)
        {
            HttpContext.Current.Session["CDRExpressMensajes"] = val;
        }

        List<BETablaLogicaDatos> ISessionManager.GetCDRExpressMensajes()
        {
            var val = HttpContext.Current.Session["CDRExpressMensajes"];

            return (List<BETablaLogicaDatos>)val;
        }

        void ISessionManager.SetCuvEsProgramaNuevas(bool val)
        {
            HttpContext.Current.Session["CuvEsProgramaNuevas"] = val;
        }

        bool ISessionManager.GetCuvEsProgramaNuevas()
        {
            var val = HttpContext.Current.Session["CuvEsProgramaNuevas"];
            if (val == null) { return false; }
            return (bool)val;
        }

        void ISessionManager.SetConfiguracionProgramaNuevas(BEConfiguracionProgramaNuevas val)
        {
            HttpContext.Current.Session["ConfiguracionProgramaNuevas"] = val;
        }

        BEConfiguracionProgramaNuevas ISessionManager.GetConfiguracionProgramaNuevas()
        {
            var val = HttpContext.Current.Session["ConfiguracionProgramaNuevas"];

            return (BEConfiguracionProgramaNuevas)val;
        }

        void ISessionManager.SetOcultarBannerTop(bool val)
        {
            HttpContext.Current.Session["OcultarBannerTop"] = val;
        }

        bool ISessionManager.GetOcultarBannerTop()
        {
            var val = HttpContext.Current.Session["OcultarBannerTop"];
            if (val == null) { return false; }
            return (bool)val;
        }

        void ISessionManager.SetPedidosWebDDConf(dynamic val)
        {
            HttpContext.Current.Session["PedidosWebDDConf"] = val;
        }

        dynamic ISessionManager.GetPedidosWebDDConf()
        {
            var val = HttpContext.Current.Session["PedidosWebDDConf"];

            return (dynamic)val;
        }

        void ISessionManager.SetPedidosWebDD(dynamic val)
        {
            HttpContext.Current.Session["PedidosWebDD"] = val;
        }

        dynamic ISessionManager.GetPedidosWebDD()
        {
            var val = HttpContext.Current.Session["PedidosWebDD"];

            return (dynamic)val;
        }

        void ISessionManager.SetPedidoWebDDDetalle(List<BEPedidoDDWeb> val)
        {
            HttpContext.Current.Session["PedidoWebDDDetalle"] = val;
        }

        List<BEPedidoDDWeb> ISessionManager.GetPedidoWebDDDetalle()
        {
            var val = HttpContext.Current.Session["PedidoWebDDDetalle"];

            return (List<BEPedidoDDWeb>)val;
        }

        void ISessionManager.SetPedidoWebDDDetalleConf(string val)
        {
            HttpContext.Current.Session["PedidoWebDDDetalleConf"] = val;
        }

        string ISessionManager.GetPedidoWebDDDetalleConf()
        {
            var val = HttpContext.Current.Session["PedidoWebDDDetalleConf"];
            if (val == null) { return ""; }
            return (string)val;
        }

        void ISessionManager.SetListaIndividual(List<List<BEEstadoServicio>> val)
        {
            HttpContext.Current.Session["ListaIndividual"] = val;
        }

        List<List<BEEstadoServicio>> ISessionManager.GetListaIndividual()
        {
            var val = HttpContext.Current.Session["ListaIndividual"];

            return (List<List<BEEstadoServicio>>)val;
        }

        void ISessionManager.SetListaRango(List<List<BEEstadoServicio>> val)
        {
            HttpContext.Current.Session["ListaRango"] = val;
        }

        List<List<BEEstadoServicio>> ISessionManager.GetListaRango()
        {
            var val = HttpContext.Current.Session["ListaRango"];

            return (List<List<BEEstadoServicio>>)val;
        }













    }
}