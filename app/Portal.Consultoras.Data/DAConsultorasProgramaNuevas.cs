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

        public IDataReader GetConsultorasProgramaNuevasByConsultoraIdAndCampania(long consultoraId, string campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraProgramaNueva");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraId);
            Context.Database.AddInParameter(command, "@Campania", DbType.String, campania);

            return Context.ExecuteReader(command);
        }
    }
}