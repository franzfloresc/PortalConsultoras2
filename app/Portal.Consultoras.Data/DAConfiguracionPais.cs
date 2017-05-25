using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionPais : DataAccess
    {
        public DAConfiguracionPais(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetList(BEConfiguracionPais entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPais_GetAll");
            Context.Database.AddInParameter(command, "Codigo", DbType.String, entity.Codigo);
            Context.Database.AddInParameter(command, "CodigoRegion", DbType.String, entity.Detalle.CodigoRegion);
            Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.Detalle.CodigoZona);
            Context.Database.AddInParameter(command, "CodigoSeccion", DbType.String, entity.Detalle.CodigoSeccion);
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.Detalle.CodigoConsultora);

            return Context.ExecuteReader(command);
        }
    }
}
