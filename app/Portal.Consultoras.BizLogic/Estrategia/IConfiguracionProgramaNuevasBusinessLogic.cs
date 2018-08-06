using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionProgramaNuevasBusinessLogic
    {
        BEConfiguracionProgramaNuevas Get(BEProgramaNuevas usuario);
        string GetCuvKitNuevas(BEProgramaNuevas usuario, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetRegaloProgramaNuevas(BEProgramaNuevas usuario, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva);
        string GetCodigoNivel(BEProgramaNuevas usuario);

        #region ConfiguracionApp
        List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        #endregion
    }
}