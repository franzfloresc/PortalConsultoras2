using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DADatosBelcorp : DataAccess
    {
        public DADatosBelcorp(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetDatosBelcorp()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDatosBelcorp");

            return Context.ExecuteReader(command);
        }
    }
}
