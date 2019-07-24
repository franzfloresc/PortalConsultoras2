using Portal.Consultoras.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionPaisFFVV : DataAccess
    {
        public DAConfiguracionPaisFFVV(int paisID)
           : base(paisID, EDbSource.Portal)
        {

        }


        public IDataReader GetList(BEConfiguracionPaisFFVVDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListConfiguracionPaisesFFVV");
            Context.Database.AddInParameter(command, "CodigoISO", DbType.String, entity.CodigoISO);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetListZonasUnete()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListZonasUnete");            
            return Context.ExecuteReader(command);
        }

    }
}
