using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using Portal.Consultoras.Entities.Pedido;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic
    {
        BEPeriodoCaminoBrillante GetPeriodo(int paisId, int campaniaId);
        List<BENivelCaminoBrillante> GetNiveles(int paisId);
        BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad);
        List<BEDesmostradoresCaminoBrillante> GetDemostradores(BEUsuario entidad, int nivelId);
        List<BEKitCaminoBrillante> GetKits(BEUsuario entidad, int nivelId);
        void UpdFlagsKitsOrDemostradores(BEPedidoWebDetalle bEPedidoWebDetalle, int paisId, int campaniaId);
        bool UpdEstragiaCaminiBrillante(BEEstrategia estrategia, int paisId, int campaniaId, string cuv);
        string ValAgregarCaminiBrillante(BEEstrategia estrategia, BEUsuario usuario, BEPedidoDetalle pedidoDetalle, List<BEPedidoWebDetalle> lstDetalle);
    }
}