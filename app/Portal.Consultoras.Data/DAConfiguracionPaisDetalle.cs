using Portal.Consultoras.Entities;
using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConfiguracionPaisDetalle : DataAccess
    {

        public DAConfiguracionPaisDetalle(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public bool Validar(BEConfiguracionPaisDetalle entity)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ConfiguracionPaisDetalle_Validar");

            Context.Database.AddInParameter(command, "ConfiguracionPaisID", DbType.Int32, entity.ConfiguracionPaisID);
            Context.Database.AddInParameter(command, "CodigoRegion", DbType.String, entity.CodigoRegion);
            Context.Database.AddInParameter(command, "CodigoZona", DbType.String, entity.CodigoZona);
            Context.Database.AddInParameter(command, "CodigoSeccion", DbType.String, entity.CodigoSeccion);
            Context.Database.AddInParameter(command, "CodigoConsultora", DbType.String, entity.CodigoConsultora);
            Context.Database.AddOutParameter(command, "RetornoID", DbType.Int32, 10);

            Context.ExecuteNonQuery(command);

            var retorno = Convert.ToInt32(command.Parameters["@RetornoID"].Value);
            return retorno > 0;
        }
    }
}