using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Portal.Consultoras.Data
{
    public class DAPayPalConfiguracion : DataAccess
    {
        public DAPayPalConfiguracion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionPayPal()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerParametrosPayPal");

            return Context.ExecuteReader(command);
        }
    }
}
