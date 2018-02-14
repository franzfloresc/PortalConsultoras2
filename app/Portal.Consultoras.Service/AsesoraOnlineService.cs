using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.AsesoraOnline;
using Portal.Consultoras.ServiceContracts;

namespace Portal.Consultoras.Service
{
    public class AsesoraOnlineService : IAsesoraOnlineService
    {
        public int EnviarFormulario(string paisISO, BEAsesoraOnline entidad)
        {
            return new BLAsesoraOnline().EnviarFormulario(paisISO, entidad);
        }

        public BEUsuario GetUsuarioByCodigoConsultora(string paisISO, string codigoConsultora)
        {
            return new BLAsesoraOnline().GetUsuarioByCodigoConsultora(paisISO, codigoConsultora);
        }

        public int ExisteConsultoraEnAsesoraOnline(string paisISO, string codigoConsultora)
        {
            return new BLAsesoraOnline().ExisteConsultoraEnAsesoraOnline(paisISO, codigoConsultora);
        }

        public int ActualizarEstadoConfiguracionPaisDetalle(string paisISO, string codigoConsultora, int estado)
        {
            return new BLAsesoraOnline().ActualizarEstadoConfiguracionPaisDetalle(paisISO, codigoConsultora, estado);
        }

        public int ValidarAsesoraOnlineConfiguracionPais(string paisISO, string codigoConsultora)
        {
            return new BLAsesoraOnline().ValidarAsesoraOnlineConfiguracionPais(paisISO, codigoConsultora);
        }

        public void EnviarMailBienvenidaAsesoraOnline(string emailFrom, string emailTo, string titulo, string displayname, string nombreConsultora)
        {
           new BLAsesoraOnline().EnviarMailBienvenidaAsesoraOnline(emailFrom, emailTo, titulo, displayname, nombreConsultora);
        }
    }
}
