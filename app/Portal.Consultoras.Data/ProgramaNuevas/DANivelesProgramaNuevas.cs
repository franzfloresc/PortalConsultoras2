using Portal.Consultoras.Entities.ProgramaNuevas;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.ProgramaNuevas
{
    public class DANivelesProgramaNuevas : DataAccess
    {
        public DANivelesProgramaNuevas(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader Get(BENivelesProgramaNuevas nivel)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNivelesProgramaNuevas");
            Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, nivel.CodigoPrograma);
            Context.Database.AddInParameter(command, "@Campania", DbType.String, nivel.Campania);
            Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, nivel.CodigoNivel);
            return Context.ExecuteReader(command);
        }
    }
}
