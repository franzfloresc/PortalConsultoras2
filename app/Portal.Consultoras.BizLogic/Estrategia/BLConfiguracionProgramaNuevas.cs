using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionProgramaNuevas : IConfiguracionProgramaNuevasBusinessLogic
    {
        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            BEConfiguracionProgramaNuevas data = null;

            var blPais = new BLPais();

            if (!blPais.EsPaisHana(paisID)) // Validar si informacion de pais es de origen Normal o Hana
            {
                var da = new DAConfiguracionProgramaNuevas(paisID);
                using (IDataReader reader = da.GetConfiguracionProgramaNuevas(entidad))
                    if (reader.Read())
                        data = new BEConfiguracionProgramaNuevas(reader);
            }
            else
            {
                var dahConfiguracionProgramaNuevas = new DAHConfiguracionProgramaNuevas();

                data = dahConfiguracionProgramaNuevas.GetConfiguracionProgramaNuevas(paisID, entidad);
            }

            return data;
        }

        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaDespuesPrimerPedido(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            BEConfiguracionProgramaNuevas data = null;
            var da = new DAConfiguracionProgramaNuevas(paisID);
            using (IDataReader reader = da.GetConfiguracionProgramaDespuesPrimerPedido(entidad))
            {
                if (reader.Read())
                    data = new BEConfiguracionProgramaNuevas(reader);
            }

            return data;
        }

        #region ConfiguracionApp
        public List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad)
        {
            using (IDataReader reader = new DAConfiguracionProgramaNuevas(entidad.PaisID).GetConfiguracionProgramaNuevasApp(entidad))
            {
                return reader.MapToCollection<BEConfiguracionProgramaNuevasApp>();
            }
        }
        public bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad)
        {
            return new DAConfiguracionProgramaNuevas(entidad.PaisID).InsConfiguracionProgramaNuevasApp(entidad);
        }
        #endregion
    }
}
