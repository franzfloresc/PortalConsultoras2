using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAParticipantesDemandaAnticipada : DataAccess
    {
        public DAParticipantesDemandaAnticipada(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetParticipantesConfiguracionConsultoraDA(string CodigoCampania, string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SP_GetParticipantesConfiguracionConsultoraDA");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, CodigoCampania);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);

            return Context.ExecuteReader(command);
        }

        public int InsParticipantesDemandaAnticipada(BEParticipantesDemandaAnticipada participantesDemandaAnticipada)
        {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsParticipantesDemandaAnticipada");
            Context.Database.AddInParameter(command, "@ConfiguracionConsultoraDAID", DbType.Int32, participantesDemandaAnticipada.ConfiguracionConsultoraDAID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, participantesDemandaAnticipada.ZonaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, participantesDemandaAnticipada.ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, participantesDemandaAnticipada.CodigoCampania);
            Context.Database.AddInParameter(command, "@Fecha", DbType.DateTime, participantesDemandaAnticipada.Fecha);
            Context.Database.AddInParameter(command, "@TipoConfiguracion", DbType.Byte, participantesDemandaAnticipada.TipoConfiguracion);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, participantesDemandaAnticipada.CodigoUsuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));

        }

        public IDataReader GetConsultoraByCodigo(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SP_GetConsultoraByCodigo");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);

            return Context.ExecuteReader(command);
        }
    }
}
