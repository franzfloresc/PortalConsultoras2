using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLLogCDRWebDetalle
    {
        public List<BELogCDRWebDetalle> GetByLogCDRWebId(int paisId, long logCDRWebId)
        {
            return new DALogCDRWebDetalle(paisId).GetByLogCDRWebId(logCDRWebId);
        }
    }
}