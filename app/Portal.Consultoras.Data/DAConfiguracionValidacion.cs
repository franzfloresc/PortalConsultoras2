using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionValidacion : DataAccess
    {
        public DAConfiguracionValidacion(int paisID) : base(paisID, EDbSource.Portal) {}

        public IDataReader GetConfiguracionValidacion()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionValidacion");
            return Context.ExecuteReader(command);
        }

        public int Insert(BEConfiguracionValidacion entidad)
        {
            SqlCommand cmd = new SqlCommand("InsConfiguracionValidacion");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@DiasAntes", SqlDbType.Int).Value = entidad.DiasAntes;
            cmd.Parameters.Add("@HoraInicio", SqlDbType.Time).Value = entidad.HoraInicio;
            cmd.Parameters.Add("@HoraFin", SqlDbType.Time).Value = entidad.HoraFin;
            cmd.Parameters.Add("@HoraInicioNoFacturable", SqlDbType.Time).Value = entidad.HoraInicioNoFacturable;
            cmd.Parameters.Add("@HoraCierreNoFacturable", SqlDbType.Time).Value = entidad.HoraCierreNoFacturable;
            cmd.Parameters.Add("@FlagNoValidados", SqlDbType.Bit).Value = entidad.FlagNoValidados;
            cmd.Parameters.Add("@ProcesoRegular", SqlDbType.SmallInt).Value = entidad.ProcesoRegular;
            cmd.Parameters.Add("@ProcesoDA", SqlDbType.SmallInt).Value = entidad.ProcesoDA;
            cmd.Parameters.Add("@ProcesoDAPRD", SqlDbType.SmallInt).Value = entidad.ProcesoDAPRD;
            cmd.Parameters.Add("@HabilitarRestriccionHoraria", SqlDbType.Bit).Value = entidad.HabilitarRestriccionHoraria;
            cmd.Parameters.Add("@CodigoUsuarioModificacion", SqlDbType.VarChar).Value = entidad.CodigoUsuarioModificacion;

            return Context.ExecuteNonQuery(cmd);
        }

        public int Update(BEConfiguracionValidacion entidad)
        {
            SqlCommand cmd = new SqlCommand("UpdConfiguracionValidacion");

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CampaniaID", SqlDbType.Int).Value = entidad.CampaniaID;
            cmd.Parameters.Add("@PaisID", SqlDbType.Int).Value = entidad.PaisID;
            cmd.Parameters.Add("@DiasAntes", SqlDbType.Int).Value = entidad.DiasAntes;
            cmd.Parameters.Add("@HoraInicio", SqlDbType.Time).Value = entidad.HoraInicio;
            cmd.Parameters.Add("@HoraFin", SqlDbType.Time).Value = entidad.HoraFin;
            cmd.Parameters.Add("@HoraInicioNoFacturable", SqlDbType.Time).Value = entidad.HoraInicioNoFacturable;
            cmd.Parameters.Add("@HoraCierreNoFacturable", SqlDbType.Time).Value = entidad.HoraCierreNoFacturable;
            cmd.Parameters.Add("@FlagNoValidados", SqlDbType.Bit).Value = entidad.FlagNoValidados;
            cmd.Parameters.Add("@ProcesoRegular", SqlDbType.SmallInt).Value = entidad.ProcesoRegular;
            cmd.Parameters.Add("@ProcesoDA", SqlDbType.SmallInt).Value = entidad.ProcesoDA;
            cmd.Parameters.Add("@ProcesoDAPRD", SqlDbType.SmallInt).Value = entidad.ProcesoDAPRD;
            cmd.Parameters.Add("@HabilitarRestriccionHoraria", SqlDbType.Bit).Value = entidad.HabilitarRestriccionHoraria;
            cmd.Parameters.Add("@CodigoUsuarioModificacion", SqlDbType.VarChar).Value = entidad.CodigoUsuarioModificacion;

            return Context.ExecuteNonQuery(cmd);
        }
    }
}
