using System.Collections.Generic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionProgramaNuevasBusinessLogic
    {
        BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisID, BEConfiguracionProgramaNuevas entidad);

        #region ConfiguracionApp
        List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(int paisID, string CodigoPrograma);
        string InsConfiguracionProgramaNuevasApp(int paisID, BEConfiguracionProgramaNuevasApp entidad);
        #endregion
    }
}