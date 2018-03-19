using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DABannerPedido : DataAccess
    {
        public DABannerPedido(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader SelectBannerPedido(int paisID, int campaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBannerPedidoPaisCampania");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            return Context.ExecuteReader(command);
        }

        public int Insert(BEBannerPedido entidad)
        {
            SqlCommand cmd = new SqlCommand("InsBannerPedido");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaIDInicio", SqlDbType.Int).Value = entidad.CampaniaIDInicio;
            cmd.Parameters.Add("@CampaniaIDFin", SqlDbType.Int).Value = entidad.CampaniaIDFin;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@ArchivoPortada", SqlDbType.VarChar).Value = entidad.ArchivoPortada;
            cmd.Parameters.Add("@Archivo", SqlDbType.VarChar).Value = entidad.Archivo;
            cmd.Parameters.Add("@Url", SqlDbType.VarChar).Value = entidad.Url;
            cmd.Parameters.Add("@Posicion", SqlDbType.Int).Value = entidad.Posicion;
            cmd.Parameters.Add("@TipoUrl", SqlDbType.VarChar).Value = entidad.TipoUrl;
            cmd.Parameters.Add("@UsuarioCreacion", SqlDbType.VarChar).Value = entidad.UsuarioCreacion;
            return Context.ExecuteNonQuery(cmd);
        }

        public int Update(BEBannerPedido entidad)
        {
            SqlCommand cmd = new SqlCommand("UpdBannerPedido");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BannerPedidoID", SqlDbType.Int).Value = entidad.BannerPedidoID;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@CampaniaIDInicio", SqlDbType.Int).Value = entidad.CampaniaIDInicio;
            cmd.Parameters.Add("@CampaniaIDFin", SqlDbType.Int).Value = entidad.CampaniaIDFin;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@ArchivoPortada", SqlDbType.VarChar).Value = entidad.ArchivoPortada;
            cmd.Parameters.Add("@ArchivoPDF", SqlDbType.VarChar).Value = entidad.Archivo;
            cmd.Parameters.Add("@Url", SqlDbType.VarChar).Value = entidad.Url;
            cmd.Parameters.Add("@Posicion", SqlDbType.Int).Value = entidad.Posicion;
            cmd.Parameters.Add("@TipoUrl", SqlDbType.VarChar).Value = entidad.TipoUrl;
            cmd.Parameters.Add("@UsuarioModificacion", SqlDbType.VarChar).Value = entidad.UsuarioModificacion;
            return Context.ExecuteNonQuery(cmd);
        }

        public int Delete(int BannerPedidoID)
        {
            SqlCommand cmd = new SqlCommand("DelBannerPedido");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BannerPedidoID", SqlDbType.Int).Value = BannerPedidoID;

            return Context.ExecuteNonQuery(cmd);
        }

    }
}