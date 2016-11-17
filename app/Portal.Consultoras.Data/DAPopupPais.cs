using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPopupPais : DataAccess
    {
        public DAPopupPais()
            : base()
        {

        }
        public IDataReader ObtenerOrdenPopUpMostrar()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerOrdenPopUpMostrar");
            return Context.ExecuteReader(command);
        }
    }
}
