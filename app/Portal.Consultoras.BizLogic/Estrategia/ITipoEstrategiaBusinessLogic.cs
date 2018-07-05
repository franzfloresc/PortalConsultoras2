using System.Collections.Generic;

using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface ITipoEstrategiaBusinessLogic
    {
        int DeleteTipoEstrategia(BETipoEstrategia entidad);
        List<BETipoEstrategia> GetTipoEstrategias(BETipoEstrategia entidad);
        int InsertTipoEstrategia(BETipoEstrategia entidad);
    }
}