using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionValidacionNuevoPROL : DataAccess
    {
        public DAConfiguracionValidacionNuevoPROL(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionValidacionNuevoPROL(int TipoPROL)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionValidacionNuevoPROL");
            Context.Database.AddInParameter(command, "@TipoPROL", DbType.Int32, TipoPROL);

            return Context.ExecuteReader(command);
        }

        public int InsConfiguracionValidacionNuevoPROL(string Usuario, IEnumerable<BEConfiguracionValidacionNuevoPROL> ZonasNuevoPROL)
        {
            var zonasNuevoProlReader = new GenericDataReader<BEConfiguracionValidacionNuevoPROL>(ZonasNuevoPROL);

            var command = new SqlCommand("dbo.InsConfiguracionValidacionNuevoPROL");
            command.CommandType = CommandType.StoredProcedure;

            var parameter = new SqlParameter("@ZonasNuevoPROL", SqlDbType.Structured);
            parameter.TypeName = "dbo.ZonaType";
            parameter.Value = zonasNuevoProlReader;
            command.Parameters.Add(parameter);
            var parameter2 = new SqlParameter("@UsuarioCreacion", SqlDbType.VarChar);
            parameter2.Value = Usuario;
            command.Parameters.Add(parameter2);

            return Context.ExecuteNonQuery(command);
        }
    }
}
