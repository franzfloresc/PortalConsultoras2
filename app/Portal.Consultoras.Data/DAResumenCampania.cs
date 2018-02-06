using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAResumenCampania : DataAccess
    {
        public DAResumenCampania(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetPedidoWebAcumulado(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPedidoWebAcumulado");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetSaldoPendiente(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSaldoPendiente");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetProductosSolicitados(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetProductosSolicitados");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetValorAPagar(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetValorAPagar");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetFlexipago(int CampaniaID, int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFlexipago");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetDeudaTotal(int ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDeudaTotal");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, ConsultoraID);
            return Context.ExecuteReader(command);
        }
    }
}
