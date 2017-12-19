using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAVisaConfiguracion : DataAccess
    {
        public DAVisaConfiguracion(int paisID) : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionVisa()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerParametrosVisa");
            return Context.ExecuteReader(command);
        }
    }
}