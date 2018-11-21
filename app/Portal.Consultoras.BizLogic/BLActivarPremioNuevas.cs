using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLActivarPremioNuevas
    {
        public BEActivarPremioNuevas GetActivarPremioNuevas(int paisID, string codigoPrograma, int anioCampana, string codigoNivel)
        {
            BEActivarPremioNuevas data = new BEActivarPremioNuevas();
            var da = new DAActivarPremioNuevas(paisID);
            using (IDataReader reader = da.GetActivarPremioNuevas(codigoPrograma, anioCampana, codigoNivel))
                if (reader.Read())
                    data = new BEActivarPremioNuevas(reader);

            return data;
        }
    }
}
