using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DACuponesProgramaNuevas : DataAccess
    {
        public DACuponesProgramaNuevas(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader ObtenerListadoCuvCupon(int campaniaId)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCuponesProgramaNuevas"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
                return Context.ExecuteReader(command);
            }
        }
    }
}
