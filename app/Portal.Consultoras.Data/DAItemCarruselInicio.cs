using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAItemCarruselInicio : DataAccess
    {
        public DAItemCarruselInicio(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetItemsCarruselInicio()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetItemsCarruselInicio");

            return Context.ExecuteReader(command);
        }
    }
}