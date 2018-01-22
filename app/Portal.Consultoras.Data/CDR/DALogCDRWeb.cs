using Portal.Consultoras.Entities.CDR;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DALogCDRWeb : DataAccess
    {
        public DALogCDRWeb(int paisID)
            : base(paisID, EDbSource.Portal)
        { }

        public BELogCDRWeb GetByLogCDRWebId(long logCDRWebId)
        {
            BELogCDRWeb entity = null;
            DbCommand command = Context.Database.GetStoredProcCommand("interfaces.GetLogCDRWebByLogCDRWebId");
            Context.Database.AddInParameter(command, "@LogCDRWebId", DbType.Int64, logCDRWebId);

            using (IDataReader reader = Context.ExecuteReader(command))
            {
                if (reader.Read()) entity = new BELogCDRWeb(reader);
            }
            return entity;
        }

        public int UpdateVisualizado(long logCDRWebId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("interfaces.UpdLogCDRWebVisualizado");
            Context.Database.AddInParameter(command, "@LogCDRWebId", DbType.Int64, logCDRWebId);
            return Context.ExecuteNonQuery(command);
        }
    }
}
