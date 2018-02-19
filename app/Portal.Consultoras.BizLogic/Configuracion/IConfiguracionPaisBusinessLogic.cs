using System.Collections.Generic;

using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionPaisBusinessLogic
    {
        BEConfiguracionPais Get(int paisId, int configuracionPaisId);
        List<BEConfiguracionPais> GetList(BEConfiguracionPais entidad);
        List<BEConfiguracionPais> GetList(int paisId, bool tienePerfil);
        void Update(BEConfiguracionPais entidad);
    }
}