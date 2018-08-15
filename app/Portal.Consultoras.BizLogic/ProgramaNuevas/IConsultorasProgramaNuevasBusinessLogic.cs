using Portal.Consultoras.Entities.ProgramaNuevas;

namespace Portal.Consultoras.BizLogic
{
    public interface IConsultorasProgramaNuevasBusinessLogic
    {
        BEProgramaNuevas GetByConsultoraIdAndCampania(int paisID, long consultoraId, string campania);
    }
}