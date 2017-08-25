﻿using Portal.Consultoras.Entities;
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
    }
}
