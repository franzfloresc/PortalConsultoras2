using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAReporteValidacion : DataAccess
    {
        public DAReporteValidacion(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetReporteValidacion(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacion");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetReporteValidacionODD(int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacionODD");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);

            return Context.ExecuteReader(command);
        }
    }
}
