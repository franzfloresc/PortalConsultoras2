using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPopupPais : DataAccess
    {
        public DAPopupPais(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }
        public IDataReader ObtenerOrdenPopUpMostrar()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerOrdenPopUpMostrar");
            return Context.ExecuteReader(command);
        }
    }
}