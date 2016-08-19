using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;


namespace Portal.Consultoras.Data
{
    public class DAComprobantePercepcion : DataAccess
    {
        public DAComprobantePercepcion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetComprobantePercepcion(int paisID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetComprobantePercepcion");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }
        public IDataReader GetComprobantePercepcionDetalle(int IdComprobantePercepcion)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetComprobantePercepcionDetalle");
            Context.Database.AddInParameter(command, "@IdComprobantePercepcion", DbType.Int32, IdComprobantePercepcion);

            return Context.ExecuteReader(command);
        }
    }
}
