using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DALogGPRValidacion : DataAccess
    {
        public DALogGPRValidacion(int paisID)
            : base(paisID, EDbSource.Portal) { }

        public List<BELogGPRValidacion> GetByLogGPRValidacionId(long logGPRValidacionId, long ConsultoraID)
        {
            List<BELogGPRValidacion> list = new List<BELogGPRValidacion>();
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.GetLogGPRValidacionByLogGPRValidacionId");
            Context.Database.AddInParameter(command, "@ProcesoValidacionPedidoRechazadoID", DbType.Int64, logGPRValidacionId);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);


            using (IDataReader reader = Context.ExecuteReader(command))
            {
                while (reader.Read()) list.Add(new BELogGPRValidacion(reader));
            }
            return list;
        }
    }
}