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
            Context.Database.AddInParameter(command, "Codigo", DbType.Int64, entity.Codigo);
            Context.Database.AddInParameter(command, "CodigoRegion", DbType.Int64, entity.Detalle.CodigoRegion);
            Context.Database.AddInParameter(command, "CodigoZona", DbType.Int64, entity.Detalle.CodigoZona);
            Context.Database.AddInParameter(command, "CodigoSeccion", DbType.Int64, entity.Detalle.CodigoSeccion);
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.Int64, entity.Detalle.CodigoConsultora);

            return Context.ExecuteReader(command);
        }
    }
}
