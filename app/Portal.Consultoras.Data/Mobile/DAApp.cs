using Portal.Consultoras.Entities.Mobile;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Mobile
{
    public class DAApp : DataAccess
    {
        public DAApp(int paisID) : base(paisID, EDbSource.Portal)
        { }

        public IDataReader ObtenerAps()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBannerByCampania");
            //Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

    }
}
