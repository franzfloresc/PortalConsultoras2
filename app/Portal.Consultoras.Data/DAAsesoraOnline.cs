using Portal.Consultoras.Entities.AsesoraOnline;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAAsesoraOnline : DataAccess
    {
        public DAAsesoraOnline(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int EnviarFormulario(BEAsesoraOnline entidad)
        {
            /*DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsProductoCompartido");
            Context.Database.AddInParameter(command, "@ProductoCompCampaniaID", DbType.Int32, ProComp.PcCampaniaID);


            Context.ExecuteNonQuery(command);
            int id = Convert.ToInt32(command.Parameters["@ProductoCompID"].Value);
            return id;*/
            return 1;
        }
    }
}
