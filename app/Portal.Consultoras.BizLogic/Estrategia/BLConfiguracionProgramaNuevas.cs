using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Data.Hana;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLConfiguracionProgramaNuevas : IConfiguracionProgramaNuevasBusinessLogic
    {
        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            if (!new BLPais().EsPaisHana(paisID)) // Validar si informacion de pais es de origen Normal o Hana
            {
                using (var reader = new DAConfiguracionProgramaNuevas(paisID).GetConfiguracionProgramaNuevas(entidad))
                {
                    return reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
                }
            }
            else
            {
                return new DAHConfiguracionProgramaNuevas().GetConfiguracionProgramaNuevas(paisID, entidad);
            }
        }

        public BEConfiguracionProgramaNuevas GetConfiguracionProgramaDespuesPrimerPedido(int paisID, BEConfiguracionProgramaNuevas entidad)
        {
            using (var reader = new DAConfiguracionProgramaNuevas(paisID).GetConfiguracionProgramaDespuesPrimerPedido(entidad))
            {
                return reader.MapToObject<BEConfiguracionProgramaNuevas>(true);
            }
        }

        #region ConfiguracionApp
        public List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad)
        {
            using (var reader = new DAConfiguracionProgramaNuevas(entidad.PaisID).GetConfiguracionProgramaNuevasApp(entidad))
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