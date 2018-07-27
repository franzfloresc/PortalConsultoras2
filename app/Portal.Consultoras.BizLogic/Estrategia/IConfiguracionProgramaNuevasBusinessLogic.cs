using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionProgramaNuevasBusinessLogic
    {
        BEConfiguracionProgramaNuevas Get(BEUsuario usuario);
        string GetCuvKitNuevas(BEUsuario usuario, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetRegaloProgramaNuevas(BEUsuario usuario, BEConfiguracionProgramaNuevas confProgNuevas);
        BEConsultoraRegaloProgramaNuevas GetConsultoraRegaloProgramaNuevas(int paisID, int campaniaId, string codigoConsultora, int consecutivoNueva);
        string GetCodigoNivel(BEUsuario usuario);

        #region ConfiguracionApp
        List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        #endregion
    }
}