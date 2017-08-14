using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionOfertasHome : DataAccess
    {

        public DAConfiguracionOfertasHome(int OfertasHomeID)
            : base(OfertasHomeID, EDbSource.Portal)
        {

        }

        public IDataReader GetList()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionOfertasHomeList");
            //Context.Database.AddInParameter(command, "TienePerfil", DbType.Boolean, tienePerfil);
            return Context.ExecuteReader(command);
        }

        public IDataReader Get(int configuracionOfertasHomeId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionOfertasHomeGet");
            Context.Database.AddInParameter(command, "ConfiguracionOfertasHomeID", DbType.Int32, configuracionOfertasHomeId);
            return Context.ExecuteReader(command);
        }

        public IDataReader Update(BEConfiguracionOfertasHome entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionOfertasHomeUpdate");
            Context.Database.AddInParameter(command, "ConfiguracionOfertasHomeID", DbType.Int32, entity.ConfiguracionOfertasHomeID);

            return Context.ExecuteReader(command);
        }
    }
}
