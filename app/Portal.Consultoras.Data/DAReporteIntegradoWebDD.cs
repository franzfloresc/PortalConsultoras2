using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAReporteIntegradoWebDD : DataAccess
    {
        public DAReporteIntegradoWebDD(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public DataSet GetReporteIntegradoWebDD(int CampaniaIDInicio, int CampaniaIDFin)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteIntegradoWebDD");
            Context.Database.AddInParameter(command, "@CampaniaIDInicio", DbType.Int32, CampaniaIDInicio);
            Context.Database.AddInParameter(command, "@CampaniaIDFin", DbType.Int32, CampaniaIDFin);

            return Context.ExecuteDataSet(command);
        }
    }
}
