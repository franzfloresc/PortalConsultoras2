using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.CertificadoComercial;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.SessionManager
{
    public class SessionManager : ISessionManager
    {
        private static ISessionManager _instance;

        public static ISessionManager Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new SessionManager();

                return _instance;
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
            return (RevistaDigitalModel)HttpContext.Current.Session[Constantes.ConstSession.RevistaDigital];
        }

        void ISessionManager.SetCertificadoComercial(List<CertificadoComercialModel> lista)
        {
            HttpContext.Current.Session[Constantes.ConstSession.CertificadoComercial] = lista;
        }

        List<CertificadoComercialModel> ISessionManager.GetCertificadoComercial()
        {
            return (List<CertificadoComercialModel>)HttpContext.Current.Session[Constantes.ConstSession.CertificadoComercial];
        }
    }
}