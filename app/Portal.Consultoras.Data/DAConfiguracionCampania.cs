using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionCampania : DataAccess
    {
        public DAConfiguracionCampania(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionCampania(int PaisID, int ZonaID, int RegionID, long ConsultoraID)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionCampania"))
            {
                Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
                Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
                Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetConfiguracionCampaniaNoConsultora(int PaisID, int ZonaID, int RegionID)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionCampaniaNoConsultora"))
            {
                Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
                Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
                Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);

                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetConfiguracionByUsuarioAndCampania(int paisID, long consultoraID, int campania, bool usuarioPrueba, int aceptacionConsultoraDA)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionByUsuarioAndCampania");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, paisID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, consultoraID);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, campania);
            Context.Database.AddInParameter(command, "@UsuarioPrueba", DbType.Boolean, usuarioPrueba);
            Context.Database.AddInParameter(command, "@AceptacionConsultoraDA", DbType.Int32, aceptacionConsultoraDA);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetConfiguracionCampaniaZona(int PaisID, int ZonaID, int RegionID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionCampaniaZona");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, RegionID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCampaniaActualByZona(string codigoZona)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniaActualByZona");
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, codigoZona);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetCampaniaByConsultoraHabilitarPedido(int PaisID, int ZonaID, long ConsultoraID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCampaniaByConsultoraHabilitarPedido");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, ZonaID);
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, ConsultoraID);

            return Context.ExecuteReader(command);
        }

    }
}