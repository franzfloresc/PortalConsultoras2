using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DATablaLogicaDatos : DataAccess
    {
        public DATablaLogicaDatos(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetTablaLogicaDatos(Int16 TablaLogicaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTablaLogicaDatos");
            Context.Database.AddInParameter(command, "@TablaLogicaID", DbType.Int16, TablaLogicaID);
            return Context.ExecuteReader(command);
        }
    }
}
