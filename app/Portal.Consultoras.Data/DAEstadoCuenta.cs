using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

// R2073 - Toda la clase
namespace Portal.Consultoras.Data
{
    public class DAEstadoCuenta:DataAccess
    {
        public DAEstadoCuenta(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetEstadoCuentaConsultora(long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoCuentaConsultora_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraId);
            return Context.ExecuteReader(command);
        }
    }
}
