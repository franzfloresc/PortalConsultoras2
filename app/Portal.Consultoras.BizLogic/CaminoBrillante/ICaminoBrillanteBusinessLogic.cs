﻿using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Portal.Consultoras.Entities.Pedido;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic
    {
        List<BENivelCaminoBrillante> GetNiveles(int paisId);
        BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad);
        BEDemostradoresPaginado GetDemostradores(BEUsuario entidad, string ordenar, int filtro, int cantMostrados, int cantidad);
        List<BEKitCaminoBrillante> GetKits(BEUsuario entidad);
        void UpdFlagsKitsOrDemostradores(BEPedidoWebDetalle bEPedidoWebDetalle, int paisId, int campaniaId, int nivelId);
        bool UpdEstragiaCaminiBrillante(BEEstrategia estrategia, int paisId, int campaniaId, int nivelId, string cuv);
        string ValAgregarCaminiBrillante(BEEstrategia estrategia, BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle);
        BEValidacionCaminoBrillante ValidarBusquedaCaminoBrillante(BEUsuario entidad, string cuv);
    }
}