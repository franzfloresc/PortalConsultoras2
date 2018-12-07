using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.LimiteVenta
{
    public class DAGestionStock : DataAccess
    {
        public DAGestionStock(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public int GetLimMaxByCampaniaAndCuv(string campania, string cuv, string codigoRegion, string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetGestionStockLimMaxByCampaniaAndCuv");
            Context.Database.AddInParameter(command, "@Campania", DbType.String, campania);
            Context.Database.AddInParameter(command, "@Cuv", DbType.String, cuv);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, codigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);
            return (int)Context.ExecuteScalar(command);
        }
    }
}
