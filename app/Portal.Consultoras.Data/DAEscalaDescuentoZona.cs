using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAEscalaDescuentoZona : DataAccess
    {
        public DAEscalaDescuentoZona(int paisID)
          : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader ListarEscalaDescuentoZona(int campaniaID, string region, string zona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEscalaDescuentoZona");
            Context.Database.AddInParameter(command, "CampaniaId", DbType.String, campaniaID);
            Context.Database.AddInParameter(command, "CodRegion", DbType.String, region);
            Context.Database.AddInParameter(command, "CodZona", DbType.String, zona);
            return Context.ExecuteReader(command);
        }
    }
}
