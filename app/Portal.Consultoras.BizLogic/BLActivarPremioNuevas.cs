using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLActivarPremioNuevas
    {
        public BEActivarPremioNuevas GetActivarPremioNuevas(int paisID, string codigoPrograma, int anioCampana, string codigoNivel)
        {
            using (IDataReader reader = new DAActivarPremioNuevas(paisID).GetActivarPremioNuevas(codigoPrograma, anioCampana, codigoNivel))
            {
                return reader.MapToObject<BEActivarPremioNuevas>(false, true);
            }
        }
    }
}
