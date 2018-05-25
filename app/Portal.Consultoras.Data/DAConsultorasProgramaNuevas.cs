using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConsultorasProgramaNuevas : DataAccess
    {
        public DAConsultorasProgramaNuevas(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetConsultorasProgramaNuevas(BEConsultorasProgramaNuevas entidad)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetConsultorasProgramaNuevas_SB2"))
            {
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.CodigoConsultora);
                Context.Database.AddInParameter(command, "@Campania", DbType.String, entidad.Campania);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);

                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetConsultorasProgramaNuevasByConsultoraId(long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraProgramaNueva");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);

            return Context.ExecuteReader(command);
        }
    }
}