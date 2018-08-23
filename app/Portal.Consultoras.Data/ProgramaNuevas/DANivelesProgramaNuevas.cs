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

        public IDataReader GetByCampania(string campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNivelesProgramaNuevasByCampania");
            Context.Database.AddInParameter(command, "@Campania", DbType.String, campania);
            return Context.ExecuteReader(command);
        }
    }
}
