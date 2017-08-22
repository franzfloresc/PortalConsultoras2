using Portal.Consultoras.Entities.AsesoraOnline;
using System;
using System.Collections.Generic;
using System.Data;
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
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsertarAsesoraOnline");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.CodigoConsultora);
            Context.Database.AddInParameter(command, "@TipsGestionClientes", DbType.Int16, entidad.TipsGestionClientes);
            Context.Database.AddInParameter(command, "@TipsMasClientes", DbType.Int16, entidad.TipsMasClientes);
            Context.Database.AddInParameter(command, "@TipsVentas", DbType.Int16, entidad.TipsVentas);
            Context.Database.AddInParameter(command, "@MasCatalogos", DbType.Int16, entidad.MasCatalogos);
            Context.Database.AddInParameter(command, "@Origen", DbType.String, entidad.Origen);

            return Context.ExecuteNonQuery(command);
        }
    }
}
