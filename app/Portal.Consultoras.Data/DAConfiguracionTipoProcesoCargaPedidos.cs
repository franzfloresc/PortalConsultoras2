using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionTipoProcesoCargaPedidos : DataAccess
    {
                public DAConfiguracionTipoProcesoCargaPedidos(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionTipoProcesoCargaPedidos(int TipoPROL)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionTipoProcesoCargaPedidos");
            Context.Database.AddInParameter(command, "@TipoPROL", DbType.Int32, TipoPROL);

            return Context.ExecuteReader(command);
        }

        public int InsConfiguracionTipoProcesoCargaPedidos(string Usuario, IEnumerable<BEConfiguracionTipoProcesoCargaPedidos> ZonasNuevoPROL)
        {
            var ZonasNuevoPROLReader = new GenericDataReader<BEConfiguracionTipoProcesoCargaPedidos>(ZonasNuevoPROL);

            var command = new SqlCommand("dbo.InsConfiguracionTipoProcesoCargaPedidos");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@ZonasNuevoPROL", SqlDbType.Structured);
            parameter.TypeName = "dbo.ZonaType";
            parameter.Value = ZonasNuevoPROLReader;
            command.Parameters.Add(parameter);
            var parameter2 = new SqlParameter("@UsuarioCreacion", SqlDbType.VarChar);
            parameter2.Value = Usuario;
            command.Parameters.Add(parameter2);

            return Context.ExecuteNonQuery(command);
        }

    
    
    }
}
