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
    public class DAActivarPremioNuevas : DataAccess
    {
        public DAActivarPremioNuevas(int paisID) : base(paisID, EDbSource.Portal) { }

        public IDataReader GetActivarPremioNuevas(string codigoPrograma, int anioCampana, string codigoNivel)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetActivarPremioNuevas");
            Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, codigoPrograma);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, anioCampana);
            Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, codigoNivel);
            return Context.ExecuteReader(command);
        }
    }
}
