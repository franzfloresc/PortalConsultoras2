using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.MisCertificados;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServicesCalculosPROL;
using System.Collections.Generic;

using System;
using System.Web;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;

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

        void ISessionManager.SetTiposEstrategia(List<BETipoEstrategia> tiposEstrategia)
        {
            HttpContext.Current.Session["ListaTipoEstrategia"] = tiposEstrategia;
        }

        List<BETipoEstrategia> ISessionManager.GetTiposEstrategia()
        {
            return (List<BETipoEstrategia>)HttpContext.Current.Session["ListaTipoEstrategia"];
        }

        void ISessionManager.SetRevistaDigital(RevistaDigitalModel revistaDigital)
        {
            HttpContext.Current.Session[Constantes.ConstSession.RevistaDigital] = revistaDigital;
        }

        RevistaDigitalModel ISessionManager.GetRevistaDigital()
        {
            return ((RevistaDigitalModel)HttpContext.Current.Session[Constantes.ConstSession.RevistaDigital]) ?? new RevistaDigitalModel();
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
            return (List<ConfiguracionPaisModel>)HttpContext.Current.Session[Constantes.ConstSession.ConfiguracionPaises];
        }

        void ISessionManager.SetOfertaFinalModel(OfertaFinalModel ofertaFinalModel)
        {
            HttpContext.Current.Session[Constantes.ConstSession.OfertaFinal] = ofertaFinalModel;
        }

        OfertaFinalModel ISessionManager.GetOfertaFinalModel()
        {
            return (OfertaFinalModel)HttpContext.Current.Session[Constantes.ConstSession.OfertaFinal];
        }

        void ISessionManager.SetEventoFestivoDataModel(EventoFestivoDataModel eventoFestivoDataModel)
        {
            HttpContext.Current.Session[Constantes.ConstSession.EventoFestivo] = eventoFestivoDataModel;
        }

        EventoFestivoDataModel ISessionManager.GetEventoFestivoDataModel()
        {
            return (EventoFestivoDataModel)HttpContext.Current.Session[Constantes.ConstSession.EventoFestivo];
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

        public void SetTieneRdr(bool tieneRdr)
        {
            HttpContext.Current.Session[Constantes.ConstSession.TieneRdr] = tieneRdr;
        }

        public bool GetTieneRdr()
        {
            return (bool)(HttpContext.Current.Session[Constantes.ConstSession.TieneRdr] ?? false);
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
    }
}