using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLLogCDRWebDetalleCulminado
    {
        public List<BECDRWebDetalle> GetByLogCDRWebCulminadoId(int paisId, long logCDRWebCulminadoId)
        {
            return new DALogCDRWebDetalleCulminado(paisId).GetByLogCDRWebCulminadoId(logCDRWebCulminadoId);
        }
    }
}