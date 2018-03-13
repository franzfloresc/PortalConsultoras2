using Portal.Consultoras.Entities.AsesoraOnline;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAAsesoraOnline : DataAccess
    {
        public DAAsesoraOnline(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int EnviarFormulario(BEAsesoraOnline entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarAsesoraOnline");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.CodigoConsultora);
            Context.Database.AddInParameter(command, "@ConfirmacionInscripcion", DbType.Int16, entidad.ConfirmacionInscripcion);
            Context.Database.AddInParameter(command, "@Respuesta1", DbType.Int16, entidad.Respuesta1);
            Context.Database.AddInParameter(command, "@Respuesta2", DbType.Int16, entidad.Respuesta2);
            Context.Database.AddInParameter(command, "@Respuesta3", DbType.Int16, entidad.Respuesta3);
            Context.Database.AddInParameter(command, "@Respuesta4", DbType.Int16, entidad.Respuesta4);
            Context.Database.AddInParameter(command, "@Respuesta5", DbType.Int16, entidad.Respuesta5);
            Context.Database.AddInParameter(command, "@Origen", DbType.String, entidad.Origen);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetUsuarioByCodigoConsultora(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioByCodigoConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);

            return Context.ExecuteReader(command);
        }

        public int ExisteConsultoraEnAsesoraOnline(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ExisteConsultoraEnAsesoraOnline");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            return (int)Context.ExecuteScalar(command);
        }

        public int ActualizarEstadoConfiguracionPaisDetalle(string codigoConsultora, int estado)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarEstadoConfiguracionPaisDetalle");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, estado);
            return Context.ExecuteNonQuery(command);
        }

        public int ValidarAsesoraOnlineConfiguracionPais(string codigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarAsesoraOnlineConfiguracionPais");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, codigoConsultora);
            return (int)Context.ExecuteScalar(command);
        }
    }
}