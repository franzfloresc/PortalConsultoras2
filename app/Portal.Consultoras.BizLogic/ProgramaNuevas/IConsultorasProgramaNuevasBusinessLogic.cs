using Portal.Consultoras.Entities.ProgramaNuevas;

namespace Portal.Consultoras.BizLogic
{
    public interface IConsultorasProgramaNuevasBusinessLogic
    {
        BEConsultoraProgramaNuevas GetByConsultoraIdAndCampania(int paisID, long consultoraId, string campania);
    }
}