using Portal.Consultoras.Entities;

namespace Portal.Consultoras.BizLogic
{
    public interface IConsultorasProgramaNuevasBusinessLogic
    {
        BEConsultorasProgramaNuevas GetConsultorasProgramaNuevas(int paisID, BEConsultorasProgramaNuevas entidad);
    }
}