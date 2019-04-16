using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic {
        BEPeriodoCaminoBrillante GetPeriodo(int paisId, int campaniaId);
        List<BENivelCaminoBrillante> GetNiveles(int paisId);
        BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad);
        List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillante(int paisId, int campaniaId);
        List<BEKitCaminoBrillante> GetKit(BEUsuario entidad, int nivelId);
    }
}