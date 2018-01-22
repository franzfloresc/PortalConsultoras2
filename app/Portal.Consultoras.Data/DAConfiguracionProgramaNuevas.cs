using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;
using Estrategia = Portal.Consultoras.Entities.Estrategia;

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
        public IDataReader GetConfiguracionProgramaNuevasApp(string CodigoPrograma)
        {
            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionProgramaNuevasApp"))
            {
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, CodigoPrograma);

                return Context.ExecuteReader(command);
            }
        }
        public string InsConfiguracionProgramaNuevasApp(Estrategia.BEConfiguracionProgramaNuevasApp entidad)
        {
            string result;

            using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConfiguracionProgramaNuevasApp"))
            {
                Context.Database.AddInParameter(command, "@ConfiguracionProgramaNuevasAppID", DbType.Int32, entidad.ConfiguracionProgramaNuevasAppID);
                Context.Database.AddInParameter(command, "@CodigoPrograma", DbType.String, entidad.CodigoPrograma);
                Context.Database.AddInParameter(command, "@TextoCupon", DbType.String, entidad.TextoCupon);
                Context.Database.AddInParameter(command, "@TextoCuponIndependiente", DbType.String, entidad.TextoCuponIndependiente);
                Context.Database.AddOutParameter(command, "@MensajeValidacion", DbType.String, 200);

                Context.ExecuteNonQuery(command);

                result = Convert.ToString(command.Parameters["@MensajeValidacion"].Value);
            }
            return result;
        }
        #endregion
    }
}
