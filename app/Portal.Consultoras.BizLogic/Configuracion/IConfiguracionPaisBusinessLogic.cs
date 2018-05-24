using Portal.Consultoras.Entities;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionPaisBusinessLogic
    {
        BEConfiguracionPais Get(int paisId, int configuracionPaisId);
        BEConfiguracionPais Get(int paisId, string codigo);
        List<BEConfiguracionPais> GetList(BEConfiguracionPais entidad);
        List<BEConfiguracionPais> GetList(int paisId, bool tienePerfil);
        void Update(BEConfiguracionPais entidad);
    }
}