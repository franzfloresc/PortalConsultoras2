using Portal.Consultoras.Data.CDR;
using Portal.Consultoras.Entities.CDR;

namespace Portal.Consultoras.BizLogic.CDR
{
    public class BLLogCDRWeb
    {
        public BELogCDRWeb GetByLogCDRWebId(int paisId, long logCDRWebId)
        {
            return new DALogCDRWeb(paisId).GetByLogCDRWebId(logCDRWebId);
        }

        public int UpdateVisualizado(int paisId, long logCDRWebId)
        {
            return new DALogCDRWeb(paisId).UpdateVisualizado(logCDRWebId);
        }
    }
}