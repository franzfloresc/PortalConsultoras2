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
    public class DAPremiosProgramaNuevas : DataAccess
    {
        public DAPremiosProgramaNuevas(int paisID) : base(paisID, EDbSource.Portal) { }

        public IDataReader GetPremiosProgramaNuevas(BEPremiosProgramaNuevas entidad )
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPremiosProgramaNuevas");
            Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.AnioCampana);
            Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, entidad.CodigoNivel);
            return Context.ExecuteReader(command);
        }


    }
}
