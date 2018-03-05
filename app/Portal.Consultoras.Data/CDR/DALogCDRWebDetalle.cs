using Portal.Consultoras.Entities.CDR;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DALogCDRWebDetalle : DataAccess
    {
        public DALogCDRWebDetalle(int paisID)
            : base(paisID, EDbSource.Portal)
        { }

        public List<BELogCDRWebDetalle> GetByLogCDRWebId(long logCDRWebId)
        {
            List<BELogCDRWebDetalle> list = new List<BELogCDRWebDetalle>();
            DbCommand command = Context.Database.GetStoredProcCommand("interfaces.GetLogCDRWebDetalleByLogCDRWebId");
            Context.Database.AddInParameter(command, "@LogCDRWebId", DbType.Int64, logCDRWebId);

            using (IDataReader reader = Context.ExecuteReader(command))
            {
                while (reader.Read()) list.Add(new BELogCDRWebDetalle(reader));
            }
            return list;
        }
    }
}