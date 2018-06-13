using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public class BLMensajeMetaConsultora : IMensajeMetaConsultoraBusinessLogic
    {
        public List<BEMensajeMetaConsultora> GetMensajeMetaConsultora(int paisID, BEMensajeMetaConsultora entidad)
        {
            using (var reader = new DAMensajeMetaConsultora(paisID).GetMensajeMetaConsultora(entidad))
            {
                return reader.MapToCollection<BEMensajeMetaConsultora>();
            }
        }
    }
}
