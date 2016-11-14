using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionProgramaNuevas
    {
        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            BEConfiguracionProgramaNuevas data = null;

            var BLPais = new BLPais();

            if (!BLPais.EsPaisHana(paisID)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var da = new DAConfiguracionProgramaNuevas(paisID);
                using (IDataReader reader = da.GetConfiguracionProgramaNuevas(entidad))
                    if (reader.Read())
                        data = new BEConfiguracionProgramaNuevas(reader);
            }
            else
            {
                var DAHConfiguracionProgramaNuevas = new DAHConfiguracionProgramaNuevas();

                data = DAHConfiguracionProgramaNuevas.GetConfiguracionProgramaNuevas(paisID, entidad);
            }

            return data;
        }

    }
}
