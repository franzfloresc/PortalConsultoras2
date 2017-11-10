using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Estrategia = Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Common;

using System.Data;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionProgramaNuevas : IConfiguracionProgramaNuevasBusinessLogic
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
        public bool DelConfiguracionProgramaNuevasApp(int paisID, int ConfiguracionProgramaNuevasAppID)
        {
            return new DAConfiguracionProgramaNuevas(paisID).DelConfiguracionProgramaNuevasApp(ConfiguracionProgramaNuevasAppID);
        }
        #endregion
    }
}
