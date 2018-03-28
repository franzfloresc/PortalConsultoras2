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
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, menuApp.CodigoConsultora);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, menuApp.ZonaID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, menuApp.CampaniaID);
            return Context.ExecuteReader(command);
        }
    }
}