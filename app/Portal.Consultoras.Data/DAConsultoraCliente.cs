using System.Data;
using System.Data.Common;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraCliente : DataAccess
    {
        public DAConsultoraCliente(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public bool InsertConsultoraCliente(BEConsultoraCliente consultoraCliente)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.InsertConsultoraCliente");

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraCliente.ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, consultoraCliente.ClienteID);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public bool DeleteConsultoraCliente(long ConsultoraID, long ClienteID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.DeleteConsultoraCliente");

            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@ClienteID", DbType.Int64, ClienteID);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public IDataReader GetConsultoraCliente(long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("Cliente.GetConsultoraCliente");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }
    }
}
