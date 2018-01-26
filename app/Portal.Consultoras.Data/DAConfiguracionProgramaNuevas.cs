using Portal.Consultoras.Entities;
using Estrategia = Portal.Consultoras.Entities.Estrategia;

using System;
using System.Data;
using System.Data.Common;

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
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionProgramaNuevas_SB2");
            Context.Database.AddInParameter(command, "@Campania", DbType.String, entidad.CampaniaInicio);
            Context.Database.AddInParameter(command, "@CodigoRegion", DbType.String, entidad.CodigoRegion);
            Context.Database.AddInParameter(command, "@CodigoZona", DbType.String, entidad.CodigoZona);

            return Context.ExecuteReader(command);
        }

        #region ConfiguracionApp
        public IDataReader GetConfiguracionProgramaNuevasApp(Estrategia.BEConfiguracionProgramaNuevasApp entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionProgramaNuevasApp"))
            {
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, entidad.CodigoNivel);

                return Context.ExecuteReader(command);
            }
        }
        public string InsConfiguracionProgramaNuevasApp(Estrategia.BEConfiguracionProgramaNuevasApp entidad)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConfiguracionProgramaNuevasApp"))
            {
                Context.Database.AddInParameter(command, "@ConfiguracionProgramaNuevasAppID", DbType.Int32, entidad.ConfiguracionProgramaNuevasAppID);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@TextoCupon", DbType.String, entidad.TextoCupon);
                Context.Database.AddInParameter(command, "@TextoCuponIndependiente", DbType.String, entidad.TextoCuponIndependiente);
                Context.Database.AddInParameter(command, "@CodigoNivel", DbType.String, entidad.CodigoNivel);
                Context.Database.AddInParameter(command, "@ArchivoBannerCupon", DbType.String, entidad.ArchivoBannerCupon);
                Context.Database.AddInParameter(command, "@ArchivoBannerPremio", DbType.String, entidad.ArchivoBannerPremio);
                Context.Database.AddOutParameter(command, "@MensajeValidacion", DbType.String, 200);

                Context.ExecuteNonQuery(command);

                return Convert.ToString(command.Parameters["@MensajeValidacion"].Value);
            }
        }
        #endregion
    }
}
