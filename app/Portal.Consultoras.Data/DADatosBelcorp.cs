using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DADatosBelcorp : DataAccess
    {
        public DADatosBelcorp(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetDatosBelcorp()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDatosBelcorp");

            return Context.ExecuteReader(command);
        }
    }
}