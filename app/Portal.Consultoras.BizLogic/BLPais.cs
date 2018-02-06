using Portal.Consultoras.Data;
using System;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLPais
    {
        public bool EsPaisHana(int paisId)
        {
            var daPais = new DAPais(paisId);
            bool tieneHana = false;
            using (IDataReader reader = daPais.EsPaisHana(paisId))
                if (reader.Read())
                {
                    tieneHana = Convert.ToBoolean(reader["TieneHana"]);
                }

            return tieneHana;
        }
    }
}
