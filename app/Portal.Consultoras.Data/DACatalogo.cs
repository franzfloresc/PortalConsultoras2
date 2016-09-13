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
    public class DACatalogo : DataAccess
    {
        public DACatalogo(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCatalogosByCampania(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCatalogosByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        // RQ 2295 Mejoras en Catalogos Belcorp
        public IDataReader GetCatalogoConfiguracion()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCatalogoConfiguracion");

            return Context.ExecuteReader(command);
        }

    }
}
