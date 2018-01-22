using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAOfertaWeb : DataAccess
    {
        public DAOfertaWeb(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetOfertaWebByCampania(int CampaniaID, int PedidoID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOfertaWebByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@PedidoID", DbType.Int32, PedidoID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }
    }
}
