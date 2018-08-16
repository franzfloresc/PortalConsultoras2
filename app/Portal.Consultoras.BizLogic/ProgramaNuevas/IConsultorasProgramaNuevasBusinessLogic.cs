using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IConsultorasProgramaNuevasBusinessLogic
    {
        BEConsultorasProgramaNuevas Get(int paisID, BEConsultorasProgramaNuevas entidad);
        BEConsultorasProgramaNuevas GetByConsultoraIdAndCampania(int paisID, long consultoraId, string campania);
    }
}