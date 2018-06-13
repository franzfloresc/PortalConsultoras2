using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
   public class DACategoria : DataAccess
    {
        public DACategoria(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetCategorias()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GETCATEGORIA");
            return Context.ExecuteReader(command);
        }
    }
}
