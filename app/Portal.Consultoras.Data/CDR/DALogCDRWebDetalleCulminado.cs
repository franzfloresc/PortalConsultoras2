using Portal.Consultoras.Entities.CDR;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DALogCDRWebDetalleCulminado : DataAccess
    {
        public DALogCDRWebDetalleCulminado(int paisID)
            : base(paisID, EDbSource.Portal)
        { }

        public List<BECDRWebDetalle> GetByLogCDRWebCulminadoId(long logCDRWebCulminadoId)
        {
            List<BECDRWebDetalle> list = new List<BECDRWebDetalle>();
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebDetalleByLogCDRWebCulminadoId");
            Context.Database.AddInParameter(command, "@LogCDRWebCulminadoId", DbType.Int64, logCDRWebCulminadoId);

            using (IDataReader reader = Context.ExecuteReader(command))
            {
                while (reader.Read()) list.Add(new BECDRWebDetalle(reader));
            }
            return list;
        }
    }
}