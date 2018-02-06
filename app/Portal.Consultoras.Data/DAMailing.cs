using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Portal.Consultoras.Data
{
    public class DAMailing: DataAccess
    {
        public DAMailing()
            : base()
        {

        }

        public DAMailing(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader ObtenerPlantillasEmailingSE()
        { 
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPlantillasEmailingSE");
            return Context.ExecuteReader(command);

        }

        public int AgregarPaisPlantillaEmailingSE(int PaisID, int PlantillaID, string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.AgregarPaisPlantillaEmailingSE");
            Context.Database.AddInParameter(command, "@PlantillaID", DbType.Int32, PlantillaID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, CodigoUsuario);
            return Context.ExecuteNonQuery(command);
        }

        public int QuitarPaisPlantillaEmailingSE(int PaisID, int PlantillaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.QuitarPaisPlantillaEmailingSE");
            Context.Database.AddInParameter(command, "@PlantillaID", DbType.Int32, PlantillaID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            return  Context.ExecuteNonQuery(command);
        }

        public int CopiarPaisPlantillaEmailingSE(int PaisID, int PlantillaID,int PaisDestinoID,string CodigoUsuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CopiarPlantillaEmailingSE");
            Context.Database.AddInParameter(command, "@PlantillaID", DbType.Int32, PlantillaID);
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@PaisDestinoID", DbType.Int32, PaisDestinoID);
            Context.Database.AddInParameter(command, "@UsuarioCreacion", DbType.String, CodigoUsuario);
            return Context.ExecuteNonQuery(command);
        }

        public IDataReader CargarPaisesPlantillaEmailing(int PlantillaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.CargarPaisesPlantillaEmailing");
            Context.Database.AddInParameter(command, "@PlantillaID", DbType.Int32, PlantillaID);

            return Context.ExecuteReader(command);
        }

        public void RegistrarContenidoEmailingSE(BEMailing BEMailing)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RegistrarContenidoEmailingSE");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, BEMailing.PaisID);
            Context.Database.AddInParameter(command, "@PlantillaID", DbType.Int32, BEMailing.PlantillaID);
            Context.Database.AddInParameter(command, "@PlantillaDetalle", DbType.String, BEMailing.PlantillaDetalle);
            Context.Database.AddInParameter(command, "@CodigoUsuario", DbType.String, BEMailing.UsuarioCreacion);
            Context.ExecuteNonQuery(command);
        }

        public IDataReader ListaLogEmailingAutomaticoSE (int PaisID) 
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListaLogEmailingAutomaticoSE");
            Context.Database.AddInParameter(command, "@PaisID", DbType.String, PaisID);
            return  Context.ExecuteReader(command);
        }

        public IDataReader CondicionesConsultoraSE(DataTable lista)
        {
            using (SqlConnection conn = new SqlConnection(Context.Database.ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("dbo.CondicionesConsultoraSE", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter tvparam = cmd.Parameters.AddWithValue("@ListaLogEmailingAutomaticoSE", lista);
                tvparam.SqlDbType = SqlDbType.Structured;

                conn.Open();
                return cmd.ExecuteReader();
            }
        }

        public void RegistrarLogEnvioAutomatico(string CodigoConsultora, string Correo, int PaisID, int CampaniaID,
            int RegionID, int ZonaID, int SeccionID, string Plantilla, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.RegistrarLogEnvioAutomatico");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@Correo", DbType.String, Correo);
            Context.Database.AddInParameter(command, "@PaisID", DbType.String, PaisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.String, CampaniaID);
            Context.Database.AddInParameter(command, "@RegionID", DbType.String, RegionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.String, ZonaID);
            Context.Database.AddInParameter(command, "@SeccionID", DbType.String, SeccionID);
            Context.Database.AddInParameter(command, "@Plantilla", DbType.String, Plantilla);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);
            Context.ExecuteReader(command);
        }

        public DateTime GetPaisZonaHoraria() {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFechaHoraPais");
          
            return Convert.ToDateTime(Context.ExecuteScalar(command));

        }

        public IDataReader GetPlantillasPais(int PaisID) {

            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerPlantillasPais");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int64, PaisID);

            return Context.ExecuteReader(command);

        }
        
        public IDataReader ObtenerCorreoEmisor(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerCorreoEmisor");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }
    }
}
