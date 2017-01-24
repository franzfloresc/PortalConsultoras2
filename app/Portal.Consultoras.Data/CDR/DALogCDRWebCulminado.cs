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
    }
}
