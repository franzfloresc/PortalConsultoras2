using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DABelcorpNoticia : DataAccess
    {
        public DABelcorpNoticia(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader SelectBelcorpNoticia(int paisID, int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBelcorpNoticiaPaisCampania");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetBelcorpNoticiaById(int BelcorpNoticiaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBelcorpNoticiaID");
            Context.Database.AddInParameter(command, "@BelcorpNoticiaID", DbType.Int32, BelcorpNoticiaID);
            return Context.ExecuteReader(command);
        }

        public int Insert(BEBelcorpNoticia entidad)
        {
            SqlCommand cmd = new SqlCommand("InsBelcorpNoticia");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@Titulo", SqlDbType.VarChar).Value = entidad.Titulo;
            cmd.Parameters.Add("@ArchivoPortada", SqlDbType.VarChar).Value = entidad.ArchivoPortada;
            cmd.Parameters.Add("@UrlPDF", SqlDbType.VarChar).Value = entidad.UrlPDF;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Update(BEBelcorpNoticia entidad)
        {
            SqlCommand cmd = new SqlCommand("UpdBelcorpNoticia");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BelcorpNoticiaID", SqlDbType.Int).Value = entidad.BelcorpNoticiaID;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@Titulo", SqlDbType.VarChar).Value = entidad.Titulo;
            cmd.Parameters.Add("@ArchivoPortada", SqlDbType.VarChar).Value = entidad.ArchivoPortada;
            cmd.Parameters.Add("@UrlPDF", SqlDbType.VarChar).Value = entidad.UrlPDF;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Delete(int BelcorpNoticiaID)
        {
            SqlCommand cmd = new SqlCommand("DelBelcorpNoticia");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BelcorpNoticiaID", SqlDbType.Int).Value = BelcorpNoticiaID;

            return Context.ExecuteNonQuery(cmd);
        }

    }
}