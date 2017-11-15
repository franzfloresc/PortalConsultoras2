using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionPaisDatos : DataAccess
    {
        public DAConfiguracionPaisDatos(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetList(BEConfiguracionPaisDatos entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisDatos_GetAll");
            Context.Database.AddInParameter(command, "CampaniaID", DbType.Int32, entity.CampaniaID);
            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.String, entity.ConfiguracionPaisID);

            Context.Database.AddInParameter(command, "CodigoRegion", DbType.String, entity.ConfiguracionPais.Detalle.CodigoRegion);
            Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.ConfiguracionPais.Detalle.CodigoZona);
            Context.Database.AddInParameter(command, "CodigoSeccion", DbType.String, entity.ConfiguracionPais.Detalle.CodigoSeccion);
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.ConfiguracionPais.Detalle.CodigoConsultora);


            return Context.ExecuteReader(command);
        }
        
    }
}
