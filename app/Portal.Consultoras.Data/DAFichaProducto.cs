using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAFichaProducto : DataAccess
    {
        public DAFichaProducto(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetFichaProducto(BEFichaProducto entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarFichaProducto_SB2"))
            {
                Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entidad.CampaniaID);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, entidad.ConsultoraID);
                Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV2);
                return Context.ExecuteReader(command);
            }
        }

    }
}