using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic {

        //Get Consultora Nivel
        List<BENivelCaminoBrillante> GetNiveles(int paisId, bool isWeb);
        //Get Consultora Nivel
        BEConsultoraCaminoBrillante GetConsultoraNivel(int paisId, BEUsuario entidad, bool isWeb);
        //Get Consultora Logros Resumen
        //void GetConsultoraLogrosResumen(int paisId, BEUsuario entidad);
        //Get Consultora Logros
        List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad, bool isWeb);
        //Get Ofertas
        void GetConsultoraOfertas(int paisId, BEUsuario entidad, bool isWeb);
        //Get Kits
        void GetConsultoraKits(int paisId, BEUsuario entidad, bool isWeb);
        //Get Desmostradores
        List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillante(int paisID, string campaniaID);

        List<BEKitCaminoBrillante> GetKit(int paisID, BEUsuario entidad, int periodoId);
    }
}
