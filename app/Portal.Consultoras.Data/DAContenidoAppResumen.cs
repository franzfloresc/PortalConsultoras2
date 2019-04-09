using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAContenidoAppResumen : DataAccess
    {
        public DAContenidoAppResumen()
            : base()
        {

        }

        public IDataReader GetContenidoAppResumen()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.Lista_BannerAPP");
            
            return Context.ExecuteReader(command);
        }
    }
}
