using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DALogGPRValidacionDetalle : DataAccess
    {
        public DALogGPRValidacionDetalle(int paisID)
            : base(paisID, EDbSource.Portal) { }

        public List<BELogGPRValidacionDetalle> GetListByLogGPRValidacionId(long logGPRValidacionId)
        {
            List<BELogGPRValidacionDetalle> list = new List<BELogGPRValidacionDetalle>();
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId");
            Context.Database.AddInParameter(command, "@LogGPRValidacionId", DbType.Int64, logGPRValidacionId);

            using (IDataReader reader = Context.ExecuteReader(command))
            {
                while (reader.Read()) list.Add(new BELogGPRValidacionDetalle(reader));
            }
            return list;
        }
    }
}