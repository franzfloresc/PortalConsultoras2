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
        string GetMensajeKitNuevas(string codigoISO, bool esConsultoraNueva, int consecutivoNueva);
        BEConsultoraRegaloProgramaNuevas GetPremioAutomatico(int paisID, int campaniaId, string codigoPrograma, string codigoNivel);
        List<BEConsultoraRegaloProgramaNuevas> GetListPremioElectivo(int paisID, int campaniaId, string codigoPrograma, string codigoNivel);
        string GetCodigoNivel(BEConsultoraProgramaNuevas consultoraNuevas);

        #region ConfiguracionApp
        List<BEConfiguracionProgramaNuevasApp> GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad);
        #endregion
    }
}