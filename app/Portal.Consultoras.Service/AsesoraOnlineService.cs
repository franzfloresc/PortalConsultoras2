﻿using Portal.Consultoras.ServiceContracts;
using Portal.Consultoras.Entities.AsesoraOnline;
using Portal.Consultoras.BizLogic;
using Portal.Consultoras.Entities;

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
    }
}
