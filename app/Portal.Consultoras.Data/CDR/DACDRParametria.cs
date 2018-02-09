using Portal.Consultoras.Entities.CDR;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRParametria : DataAccess
    {
        public DACDRParametria(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCDRParametria(BECDRParametria entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCDRParametria");
            Context.Database.AddInParameter(command, "CodigoParametria", DbType.String, entity.CodigoParametria);

            return Context.ExecuteReader(command);
        }
    }
}
