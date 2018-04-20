using Portal.Consultoras.Entities;
using Portal.Consultoras.Entities.AsesoraOnline;
using System.ServiceModel;

namespace Portal.Consultoras.ServiceContracts
{
    [ServiceContract]
    public interface IAsesoraOnlineService
    {
        [OperationContract]
        int EnviarFormulario(string paisISO, BEAsesoraOnline entidad);

        [OperationContract]
        BEUsuario GetUsuarioByCodigoConsultora(string paisISO, string codigoConsultora);

        [OperationContract]
        int ExisteConsultoraEnAsesoraOnline(string paisISO, string codigoConsultora);

        [OperationContract]
        int ActualizarEstadoConfiguracionPaisDetalle(string paisISO, string codigoConsultora, int estado);

        [OperationContract]
        int ValidarAsesoraOnlineConfiguracionPais(string paisISO, string codigoConsultora);

        [OperationContract]
        void EnviarMailBienvenidaAsesoraOnline(string emailFrom, string emailTo, string titulo, string displayname, string nombreConsultora);

        [OperationContract]
        string CancelarSuscripcion(string paisISO, string codigoConsultora);

        [OperationContract]
        int VuelveASuscripcion(string paisISO, string codigoConsultora);
    }
}