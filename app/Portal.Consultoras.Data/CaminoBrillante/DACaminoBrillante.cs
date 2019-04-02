using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data.CaminoBrillante
{
    public class DACaminoBrillante : DataAccess
    {
        public DACaminoBrillante(int paisID): base(paisID, EDbSource.Portal) {

        }

        public IDataReader GetBeneficiosCaminoBrillante()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetBeneficioCaminoBrillante");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetConfiguracionMedallaCaminoBrillante()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionMedallaCaminoBrillante");
            return Context.ExecuteReader(command);
        }

    }
}