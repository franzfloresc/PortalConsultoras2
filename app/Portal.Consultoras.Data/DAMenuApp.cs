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
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, menuApp.CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, menuApp.CodigoZona);
            Context.Database.AddInParameter(command, "@CodigoSeccion", DbType.String, menuApp.CodigoSeccion);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, menuApp.CodigoConsultora);
            return Context.ExecuteReader(command);
        }
    }
}