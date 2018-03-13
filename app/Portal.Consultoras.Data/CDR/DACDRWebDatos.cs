using Portal.Consultoras.Entities.CDR;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRWebDatos : DataAccess
    {
        public DACDRWebDatos(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCDRWebDatos(BECDRWebDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRWebDatos");
            Context.Database.AddInParameter(command, "Codigo", DbType.String, entity.Codigo);

            return Context.ExecuteReader(command);
        }
    }
}