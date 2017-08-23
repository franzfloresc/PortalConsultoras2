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
            Context.Database.AddInParameter(command, "@Origen", DbType.String, entidad.Origen);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetUsuarioByCodigoConsultora(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetUsuarioByCodigoConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);

            return Context.ExecuteReader(command);
        }
    }
}
