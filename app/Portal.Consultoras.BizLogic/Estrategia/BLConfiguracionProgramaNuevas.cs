using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using Estrategia = Portal.Consultoras.Entities.Estrategia;

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

        #region ConfiguracionApp
        public List<Estrategia.BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(int paisID, string CodigoPrograma)
        {
            using (IDataReader reader = new DAConfiguracionProgramaNuevas(paisID).GetConfiguracionProgramaNuevasApp(CodigoPrograma))
            {
                return reader.MapToCollection<Estrategia.BEConfiguracionProgramaNuevasApp>();
            }
        }
        public string InsConfiguracionProgramaNuevasApp(int paisID, Estrategia.BEConfiguracionProgramaNuevasApp entidad)
        {
            return new DAConfiguracionProgramaNuevas(paisID).InsConfiguracionProgramaNuevasApp(entidad);
        }
        #endregion
    }
}
