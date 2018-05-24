using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPedidoWebAnteriores : DataAccess
    {
        public DAPedidoWebAnteriores(int paisID)
            : base(paisID, EDbSource.ODS)
        {

        }

        public IDataReader GetPedidosWebAnterioresByConsultora(long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebAnterioresByConsultora");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPedidoProductosByCampania(int CampaniaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidosWebAnterioresByCampania");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }
    }
}