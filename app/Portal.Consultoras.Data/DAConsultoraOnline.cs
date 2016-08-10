using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraOnline : DataAccess
    {
        public DAConsultoraOnline(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetMisPedidosConsultoraOnline(long ConsultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetNotificacionesConsultoraOnline");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);

            return Context.ExecuteReader(command);
        }
		
		public IDataReader GetCantidadPedidosConsultoraOnline(long ConsultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCantidadPedidosConsultoraOnline");
            Context.Database.AddInParameter(command, "@ConsultoraId", DbType.Int64, ConsultoraId);

            return Context.ExecuteReader(command);
        }
    }
}
