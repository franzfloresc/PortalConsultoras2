using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultorasProgramaNuevas : IConsultorasProgramaNuevasBusinessLogic
    {
        public BEConsultorasProgramaNuevas Get(int paisID, BEConsultorasProgramaNuevas entidad)
        {
            using (var reader = new DAConsultorasProgramaNuevas(paisID).GetConsultorasProgramaNuevas(entidad))
            {
                return reader.MapToObject<BEConsultorasProgramaNuevas>(true);
            }
        }
        public BEConsultorasProgramaNuevas GetByConsultoraIdAndCampania(int paisID, long consultoraId, string campania)
        {
            using (var reader = new DAConsultorasProgramaNuevas(paisID).GetConsultorasProgramaNuevasByConsultoraIdAndCampania(consultoraId, campania))
            {
                return reader.MapToObject<BEConsultorasProgramaNuevas>(true, true);
            }
        }
    }
}
