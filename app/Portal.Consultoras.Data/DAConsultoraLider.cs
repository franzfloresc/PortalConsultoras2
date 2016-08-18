using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraLiderODS : DataAccess
    {
        public DAConsultoraLiderODS(int paisID)
            : base(paisID, EDbSource.ODS)
        {

        }

        //2397 CampaniaLider
        public IDataReader GetLiderCampaniaActual(long ConsultoraID, string CodigoPais)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.SP_GET_LIDER_CAMPANIA_ACTUAL");
            Context.Database.AddInParameter(command, "@ConsultoraLiderID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@CodigoPais", DbType.AnsiString, CodigoPais);
            return Context.ExecuteReader(command);
        }
    }

    public class DAConsultoraLider : DataAccess
    {
        public DAConsultoraLider(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        //2397 FlgProyecta
        public IDataReader GetFlgProyecta(long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFlgProyecta");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            return Context.ExecuteReader(command);
        }
        //2397 - control de cambios
        public DataSet ObtenerParametrosSuperateLider(long ConsultoraID, int CampaniaVenta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerParametrosSuperateLider");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.Database.AddInParameter(command, "@CampaniaVenta", DbType.Int32, CampaniaVenta);
            return Context.ExecuteDataSet(command);
        }
    }
}
