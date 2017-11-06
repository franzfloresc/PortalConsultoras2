﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.Models;

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

        void SetTieneRdr(bool tieneRdr);

        bool GetTieneRdr();
        
        void SetUserData(UsuarioModel usuario);

        UsuarioModel GetUserData();
    }
}
