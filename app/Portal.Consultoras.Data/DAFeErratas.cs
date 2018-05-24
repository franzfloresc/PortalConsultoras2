using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAFeErratas : DataAccess
    {
        public DAFeErratas(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader SelectFeErratas(int paisID, int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFeErratasPaisCampania");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            return Context.ExecuteReader(command);
        }

        public int Insert(BEFeErratas entidad)
        {
            SqlCommand cmd = new SqlCommand("InsFeErratas");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@Titulo", SqlDbType.VarChar).Value = entidad.Titulo;
            cmd.Parameters.Add("@Pagina", SqlDbType.Int).Value = entidad.Pagina;
            cmd.Parameters.Add("@Dice", SqlDbType.VarChar).Value = entidad.Dice;
            cmd.Parameters.Add("@DebeDecir", SqlDbType.VarChar).Value = entidad.DebeDecir;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Update(BEFeErratas entidad)
        {
            SqlCommand cmd = new SqlCommand("UpdFeErratas");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@FeErratasID", SqlDbType.Int).Value = entidad.FeErratasID;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@Titulo", SqlDbType.VarChar).Value = entidad.Titulo;
            cmd.Parameters.Add("@Pagina", SqlDbType.Int).Value = entidad.Pagina;
            cmd.Parameters.Add("@Dice", SqlDbType.VarChar).Value = entidad.Dice;
            cmd.Parameters.Add("@DebeDecir", SqlDbType.VarChar).Value = entidad.DebeDecir;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Delete(int feErratasID)
        {
            SqlCommand cmd = new SqlCommand("DelFeErratas");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@FeErratasID", SqlDbType.Int).Value = feErratasID;

            return Context.ExecuteNonQuery(cmd);
        }

        public IDataReader SelectFeErratasEntradas(int paisID, int campaniaID, string titulo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFeErratasEntradas");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            Context.Database.AddInParameter(command, "@Titulo", DbType.String, titulo);
            return Context.ExecuteReader(command);
        }
    }
}