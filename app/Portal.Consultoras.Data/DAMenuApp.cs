using System.Data;
using System.Data.Common;

using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAMenuApp : DataAccess
    {
        public DAMenuApp(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetMenusApp(BEMenuApp menuApp)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetMenusApp");
            Context.Database.AddInParameter(command, "@RevistaDigitalSuscripcion", DbType.Int16, menuApp.RevistaDigitalSuscripcion);
            Context.Database.AddInParameter(command, "@VersionMenu", DbType.Int16, menuApp.VersionMenu);
            return Context.ExecuteReader(command);
        }
    }
}