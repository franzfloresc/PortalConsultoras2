using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities.CDR;

namespace Portal.Consultoras.Data.CDR
{
    public class DACDRWebDatos: DataAccess
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
