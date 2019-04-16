using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic
    {
        BEPeriodoCaminoBrillante GetPeriodo(int paisId, int campaniaId);
        List<BENivelCaminoBrillante> GetNiveles(int paisId);
        BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad);
        List<BEDesmostradoresCaminoBrillante> GetDemostradores(int paisId, int campaniaId);
        List<BEKitCaminoBrillante> GetKits(BEUsuario entidad, int nivelId);
        void UpdFlagsKitsOrDemostradores(BEPedidoWebDetalle bEPedidoWebDetalle, int paisId, int campaniaId);
        void UpdEstragiaCaminiBrillante(BEEstrategia estrategia, int paisId, int campaniaId, string cuv);
    }
}