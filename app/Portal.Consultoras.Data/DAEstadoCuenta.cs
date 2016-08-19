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

        public IDataReader GetEstadoCuentaConsultora(string CodigoConsultora)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoCuentaConsultora");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, CodigoConsultora);
            return Context.ExecuteReader(command);
        }
    }
}
