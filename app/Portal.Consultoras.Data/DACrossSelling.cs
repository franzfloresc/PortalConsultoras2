using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACrossSelling : DataAccess
    {
        public DACrossSelling(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsConfiguracionCrossSelling(BEConfiguracionCrossSelling entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.AdministrarConfiguracionCrossSelling");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "@HabilitarDiasValidacion", DbType.Int32, entity.HabilitarDiasValidacion);

            return Context.ExecuteNonQuery(command);
        }

        public int ValidarConfiguracionCrossSelling(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConfiguracionCrossSellingByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return int.Parse(Context.ExecuteScalar(command).ToString());
        }
        
        public IDataReader GetCampaniasPorPais(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerConfiguracionCrossSelling");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }
    }
}
