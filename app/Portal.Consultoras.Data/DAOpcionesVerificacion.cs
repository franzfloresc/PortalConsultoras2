using System.Data;
using System.Data.Common;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAOpcionesVerificacion : DataAccess
    {
        public DAOpcionesVerificacion(int paisID)
            : base(paisID, EDbSource.Portal)
        {}

        public IDataReader GetOpcionesVerificacion(int origenID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetOpcionesVerificacion");
            Context.Database.AddInParameter(command, "@OrigenID", DbType.Int32, origenID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetZonasOpcionesVerificacion(int regionID, int zonaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetZonasOpcionesVerificacion");
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, regionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, zonaID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetFiltrosOpcionesVerificacion(int origenID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFiltrosOpcionesVerificacion");
            Context.Database.AddInParameter(command, "@OrigenID", DbType.Int32, origenID);
            return Context.ExecuteReader(command);
        }
    }
}
