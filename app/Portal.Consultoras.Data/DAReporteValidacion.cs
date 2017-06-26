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

        public IDataReader GetReporteValidacion(string paisISO, int campaniaID, int tipoEstrategia)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetReporteValidacion");
            Context.Database.AddInParameter(command, "@PaisISO", DbType.String, paisISO);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@TipoEstrategia", DbType.Int64, tipoEstrategia);

            return Context.ExecuteReader(command);
        }
    }
}
