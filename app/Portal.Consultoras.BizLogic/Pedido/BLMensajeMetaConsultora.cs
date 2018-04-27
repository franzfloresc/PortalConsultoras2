using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLMensajeMetaConsultora : IMensajeMetaConsultoraBusinessLogic
    {
        public List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(int paisID, BEMensajeMetaConsultora entidad)
        {
            List<BEMensajeMetaConsultora> data = new List<BEMensajeMetaConsultora>();
            var da = new DAMensajeMetaConsultora(paisID);
            using (IDataReader reader = da.GetMensajeMetaConsultora(entidad))
                while (reader.Read())
                    data.Add(new BEMensajeMetaConsultora(reader));

            return data;
        }
    }
}
