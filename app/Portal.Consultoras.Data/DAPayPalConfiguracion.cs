using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPayPalConfiguracion : DataAccess
    {
        public DAPayPalConfiguracion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionPayPal()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerParametrosPayPal");

            return Context.ExecuteReader(command);
        }
    }
}
