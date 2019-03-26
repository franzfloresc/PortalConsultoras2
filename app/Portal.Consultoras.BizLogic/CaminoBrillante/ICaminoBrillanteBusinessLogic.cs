using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.CaminoBrillante;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CaminoBrillante
{
    public interface ICaminoBrillanteBusinessLogic {

        //Get Consultora Nivel
        List<BENivelCaminoBrillante> GetNiveles(int paisId);
        //Get Consultora Nivel
        BEConsultoraCaminoBrillante GetConsultoraNivel(int paisId, BEUsuario entidad);
        //Get Consultora Logros Resumen
        //void GetConsultoraLogrosResumen(int paisId, BEUsuario entidad);
        //Get Consultora Logros
        List<BELogroCaminoBrillante> GetConsultoraLogros(int paisId, BEUsuario entidad);
        //Get Ofertas
        void GetConsultoraOfertas(int paisId, BEUsuario entidad);
        //Get Kits
        void GetConsultoraKits(int paisId, BEUsuario entidad);

    }
}
