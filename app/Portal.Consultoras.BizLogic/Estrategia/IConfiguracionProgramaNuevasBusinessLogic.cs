using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionProgramaNuevasBusinessLogic
    {
        BEConfiguracionProgramaNuevas Get(BEProgramaNuevas programaNuevas);
        string GetCuvKitNuevas(BEProgramaNuevas programaNuevas, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetRegaloProgramaNuevas(BEProgramaNuevas programaNuevas, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva);
        string GetCodigoNivel(BEProgramaNuevas programaNuevas);

        #region ConfiguracionApp
        List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        #endregion
    }
}