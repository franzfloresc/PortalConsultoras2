using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAIncentivo : DataAccess
    {
        public DAIncentivo(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader SelectIncentivo(int paisID, int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetIncentivoPaisCampania");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            return Context.ExecuteReader(command);
        }

        public int Insert(BEIncentivo entidad)
        {
            SqlCommand cmd = new SqlCommand("InsIncentivo");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaIDInicio", SqlDbType.Int).Value = entidad.CampaniaIDInicio;
            cmd.Parameters.Add("@CampaniaIDFin", SqlDbType.Int).Value = entidad.CampaniaIDFin;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@Titulo", SqlDbType.VarChar).Value = entidad.Titulo;
            cmd.Parameters.Add("@Subtitulo", SqlDbType.VarChar).Value = entidad.Subtitulo;
            cmd.Parameters.Add("@ArchivoPortada", SqlDbType.VarChar).Value = entidad.ArchivoPortada;
            cmd.Parameters.Add("@ArchivoPDF", SqlDbType.VarChar).Value = entidad.ArchivoPDF;
            cmd.Parameters.Add("@Url", SqlDbType.VarChar).Value = entidad.Url;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Update(BEIncentivo entidad)
        {
            SqlCommand cmd = new SqlCommand("UpdIncentivo");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@IncentivoID", SqlDbType.Int).Value = entidad.IncentivoID;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaIDInicio", SqlDbType.Int).Value = entidad.CampaniaIDInicio;
            cmd.Parameters.Add("@CampaniaIDFin", SqlDbType.Int).Value = entidad.CampaniaIDFin;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@Titulo", SqlDbType.VarChar).Value = entidad.Titulo;
            cmd.Parameters.Add("@Subtitulo", SqlDbType.VarChar).Value = entidad.Subtitulo;
            cmd.Parameters.Add("@ArchivoPortada", SqlDbType.VarChar).Value = entidad.ArchivoPortada;
            cmd.Parameters.Add("@ArchivoPDF", SqlDbType.VarChar).Value = entidad.ArchivoPDF;
            cmd.Parameters.Add("@Url", SqlDbType.VarChar).Value = entidad.Url;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Delete(int IncentivoID)
        {
            SqlCommand cmd = new SqlCommand("DelIncentivo");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@IncentivoID", SqlDbType.Int).Value = IncentivoID;

            return Context.ExecuteNonQuery(cmd);
        }

    }
}
