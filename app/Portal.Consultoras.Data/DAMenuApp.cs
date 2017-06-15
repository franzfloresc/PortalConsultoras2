using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAMenuApp : DataAccess
    {
        public DAMenuApp(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetMenusApp()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMenusApp");
            command.CommandTimeout = 0;
            return Context.ExecuteReader(command);
        }
    }
}