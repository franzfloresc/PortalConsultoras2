using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic {

        //Get Consultora Nivel
        List<BENivelCaminoBrillante> GetNiveles(int paisId);
        //Get Consultora Nivel
        BEConsultoraCaminoBrillante GetConsultoraNivel(BEUsuario entidad);
        //Get Consultora Logros Resumen
        //void GetConsultoraLogrosResumen(int paisId, BEUsuario entidad);
        //Get Consultora Logros
        //List<BELogroCaminoBrillante> GetConsultoraLogros(BEUsuario entidad);
        
        //Get Ofertas
        //void GetConsultoraOfertas(BEUsuario entidad);
        //Get Kits
        //void GetConsultoraKits(BEUsuario entidad);
        
            //Get Desmostradores
        List<BEDesmostradoresCaminoBrillante> GetDemostradoresCaminoBrillante(int paisID, string campaniaID);
        //Get Kits
        List<BEKitCaminoBrillante> GetKit(BEUsuario entidad, int periodoId, int nivelId);
    }
}
