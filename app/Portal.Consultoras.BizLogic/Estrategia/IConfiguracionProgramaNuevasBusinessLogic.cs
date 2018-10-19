using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionProgramaNuevasBusinessLogic
    {
        BEConfiguracionProgramaNuevas Get(BEConsultoraProgramaNuevas consultoraNuevas);
        string GetCuvKitNuevas(BEConsultoraProgramaNuevas consultoraNuevas, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetRegaloProgramaNuevas(BEConsultoraProgramaNuevas consultoraNuevas, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva);
        string GetCodigoNivel(BEConsultoraProgramaNuevas consultoraNuevas);

        #region ConfiguracionApp
        List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        #endregion
    }
}