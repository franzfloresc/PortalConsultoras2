using Portal.Consultoras.Entities.CDR;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DALogCDRWebCulminado : DataAccess
    {
        public DALogCDRWebCulminado(int paisID)
            : base(paisID, EDbSource.Portal)
        { }

        public void CreateLogCDRWebCulminadoFromCDRWeb(int cDRWebId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CreateLogCDRWebCulminadoFromCDRWeb");
            Context.Database.AddInParameter(command, "@CDRWebId", DbType.Int32, cDRWebId);
            Context.ExecuteNonQuery(command);
        }

        public int UpdateVisualizado(long logCDRWebCulminadoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdLogCDRWebCulminadoVisualizado");
            Context.Database.AddInParameter(command, "@LogCDRWebCulminadoId", DbType.Int64, logCDRWebCulminadoId);
            return Context.ExecuteNonQuery(command);
        }

        public BECDRWeb GetByLogCDRWebCulminadoId(long logCDRWebCulminadoId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebByLogCDRWebCulminadoId");
            Context.Database.AddInParameter(command, "@LogCDRWebCulminadoId", DbType.Int64, logCDRWebCulminadoId);

            using (IDataReader reader = Context.ExecuteReader(command))
            {
                if (reader.Read()) return new BECDRWeb(reader);
            }
            return null;
        }
    }
}