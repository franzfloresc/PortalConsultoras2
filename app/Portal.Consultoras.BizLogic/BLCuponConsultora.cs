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
            var DAPedidoWeb = new DACuponConsultora(paisID);

            using (IDataReader reader = DAPedidoWeb.GetCuponConsultoraByCodigoConsultoraCampaniaId(cuponConsultora))
                if (reader.Read())
                {
                    entidad = new BECuponConsultora(reader);
                }
            return entidad;
        }
    }
}
