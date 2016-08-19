using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionCampania : DataAccess
    {
        public DAConfiguracionCampania(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionCampania(int PaisID, int ZonaID, int RegionID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionCampania");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConfiguracionCampaniaZona(int PaisID, int ZonaID, int RegionID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionCampaniaZona");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCampaniaActualByZona(string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniaActualByZona");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCampaniaByConsultoraHabilitarPedido(int PaisID, int ZonaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniaByConsultoraHabilitarPedido");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

    }
}
