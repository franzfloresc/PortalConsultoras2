using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.Mobile
{
    public class DAApp : DataAccess
    {
        public DAApp(int paisID) : base(paisID, EDbSource.Portal)
        { }

        public IDataReader ObtenerAps()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.AppVersion_listar");

            return Context.ExecuteReader(command);
        }
    }
}