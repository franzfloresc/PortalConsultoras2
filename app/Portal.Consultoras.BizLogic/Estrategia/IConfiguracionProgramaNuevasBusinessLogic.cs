using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.Estrategia;
using System.Collections.Generic;

namespace Portal.Consultoras.BizLogic
{
    public interface IConfiguracionProgramaNuevasBusinessLogic
    {
        BEConfiguracionProgramaNuevas GetConfiguracionProgramaNuevas(int paisID, BEConfiguracionProgramaNuevas entidad);
        BEConfiguracionProgramaNuevas GetConfiguracionProgramaDespuesPrimerPedido(int paisID, BEConfiguracionProgramaNuevas entidad);

        #region ConfiguracionApp
        List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        #endregion
    }
}