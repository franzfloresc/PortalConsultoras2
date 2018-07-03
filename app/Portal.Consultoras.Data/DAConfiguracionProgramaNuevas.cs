using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;
using Portal.Consultoras.Entities.Estrategia;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionProgramaNuevas : DataAccess
    {
        public DAConfiguracionProgramaNuevas(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetConfiguracionProgramaNuevas(BEConfiguracionProgramaNuevas entidad)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionProgramaNuevas_SB2"))
            {
                Context.Database.AddInParameter(command, "@Campania", DbType.String, entidad.CampaniaInicio);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.CodigoConsultora);

                return Context.ExecuteReader(command);
            }
        }

        public IDataReader GetConfiguracionProgramaDespuesPrimerPedido(BEConfiguracionProgramaNuevas entidad)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2"))
            {
                Context.Database.AddInParameter(command, "@Campania", DbType.String, entidad.CampaniaInicio);
                Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, entidad.CodigoConsultora);
                Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, entidad.CodigoNivel);

                return Context.ExecuteReader(command);
            }
        }

        #region ConfiguracionApp
        public IDataReader GetConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionProgramaNuevasApp"))
            {
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, entidad.CodigoNivel);

                return Context.ExecuteReader(command);
            }
        }

        public bool InsConfiguracionProgramaNuevasApp(BEConfiguracionProgramaNuevasApp entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConfiguracionProgramaNuevasApp"))
            {
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@TextoCupon", DbType.String, entidad.TextoCupon);
                Context.Database.AddInParameter(command, "@TextoCuponIndependiente", DbType.String, entidad.TextoCuponIndependiente);
                Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, entidad.CodigoNivel);
                Context.Database.AddInParameter(command, "@ArchivoBannerCupon", DbType.String, entidad.ArchivoBannerCupon);
                Context.Database.AddInParameter(command, "@ArchivoBannerPremio", DbType.String, entidad.ArchivoBannerPremio);

                Context.ExecuteNonQuery(command);

                return true;
            }
        }
        #endregion
    }
}