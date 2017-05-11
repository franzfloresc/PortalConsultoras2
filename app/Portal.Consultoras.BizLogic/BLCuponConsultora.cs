using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.Cupon;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLCuponConsultora
    {
        public BECuponConsultora GetCuponConsultoraByCodigoConsultoraCampaniaId(int paisID, BECuponConsultora cuponConsultora)
        {
            BECuponConsultora entidad = null;
            var DACuponConsultora = new DACuponConsultora(paisID);

            using (IDataReader reader = DACuponConsultora.GetCuponConsultoraByCodigoConsultoraCampaniaId(cuponConsultora))
                if (reader.Read())
                {
                    entidad = new BECuponConsultora(reader);
                }
            return entidad;
        }

        public void UpdateCuponConsultoraEstadoCupon(int paisId, BECuponConsultora cuponConsultora)
        {
            var DACuponConsultora = new DACuponConsultora(paisId);
            DACuponConsultora.UpdateCuponConsultoraEstadoCupon(cuponConsultora);
        }
    }
}
