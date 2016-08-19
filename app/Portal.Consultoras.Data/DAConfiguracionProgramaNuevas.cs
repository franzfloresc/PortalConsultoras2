
using Portal.Consultoras.Entities;
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
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionProgramaNuevas");
            Context.Database.AddInParameter(command, "@Campania", DbType.String, entidad.CampaniaInicio);

            return Context.ExecuteReader(command);
        }


    }
}
