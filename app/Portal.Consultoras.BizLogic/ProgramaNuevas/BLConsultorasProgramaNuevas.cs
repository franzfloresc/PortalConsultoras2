using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultorasProgramaNuevas : IConsultorasProgramaNuevasBusinessLogic
    {
        public BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(int paisID, BEConsultorasProgramaNuevas entidad)
        {
            using (var reader = new DAConsultorasProgramaNuevas(paisID).GetConsultorasProgramaNuevas(entidad))
            {
                return reader.MapToObject<BEConsultorasProgramaNuevas>(true);
            }
        }
    }
}
