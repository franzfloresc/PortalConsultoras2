using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAItemCarruselInicio : DataAccess
    {
        public DAItemCarruselInicio(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetItemsCarruselInicio()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetItemsCarruselInicio");

            return Context.ExecuteReader(command);
        }
    }
}
