using Portal.Consultoras.Common;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities.ProgramaNuevas;

namespace Portal.Consultoras.BizLogic
{
    public class BLConsultorasProgramaNuevas : IConsultorasProgramaNuevasBusinessLogic
    {
        public BEConsultoraProgramaNuevas GetByConsultoraIdAndCampania(int paisID, long consultoraId, string campania)
        {
            using (var reader = new DAConsultorasProgramaNuevas(paisID).GetConsultorasProgramaNuevasByConsultoraIdAndCampania(consultoraId, campania))
            {
                return reader.MapToObject<BEConsultoraProgramaNuevas>(true, true);
            }
        }
    }
}
