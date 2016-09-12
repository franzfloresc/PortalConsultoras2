using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Common;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Entities;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DALugarPago : DataAccess
    {
        public DALugarPago(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader SelectLugarPago(int paisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLugarPagoPaisCampania");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            //Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetLugarPagoById(int lugarPagoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetLugarPagoID");
            Context.Database.AddInParameter(command, "@LugarPagoID", DbType.Int32, lugarPagoID);
            return Context.ExecuteReader(command);
        }

        public int Insert(BELugarPago entidad)
        {
            SqlCommand cmd = new SqlCommand("InsLugarPago");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            //cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@Nombre", SqlDbType.VarChar).Value = entidad.Nombre;
            cmd.Parameters.Add("@UrlSitio", SqlDbType.VarChar).Value = entidad.UrlSitio;
            cmd.Parameters.Add("@ArchivoLogo", SqlDbType.VarChar).Value = entidad.ArchivoLogo;
            cmd.Parameters.Add("@ArchivoInstructivo", SqlDbType.VarChar).Value = entidad.ArchivoInstructivo;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Update(BELugarPago entidad)
        {
            SqlCommand cmd = new SqlCommand("UpdLugarPago");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@LugarPagoID", SqlDbType.Int).Value = entidad.LugarPagoID;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            //cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@ConsultoraID", SqlDbType.BigInt).Value = entidad.ConsultoraID;
            cmd.Parameters.Add("@Nombre", SqlDbType.VarChar).Value = entidad.Nombre;
            cmd.Parameters.Add("@UrlSitio", SqlDbType.VarChar).Value = entidad.UrlSitio;
            cmd.Parameters.Add("@ArchivoLogo", SqlDbType.VarChar).Value = entidad.ArchivoLogo;
            cmd.Parameters.Add("@ArchivoInstructivo", SqlDbType.VarChar).Value = entidad.ArchivoInstructivo;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Delete(int lugarPagoID)
        {
            SqlCommand cmd = new SqlCommand("DelLugarPago");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@LugarPagoID", SqlDbType.Int).Value = lugarPagoID;

            return Context.ExecuteNonQuery(cmd);
        }

    }
}
