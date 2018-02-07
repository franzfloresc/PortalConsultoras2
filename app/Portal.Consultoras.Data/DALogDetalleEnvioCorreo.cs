using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DALogDetalleEnvioCorreo : DataAccess
    {
        public DALogDetalleEnvioCorreo(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsLogDetalleEnvioCorreo(int CabeceraID, BELogDetalleEnvioCorreo entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogDetalleEnvioCorreo");
            Context.Database.AddInParameter(command, "@CabeceraID", DbType.Int32, CabeceraID);
            Context.Database.AddInParameter(command, "@CUV", DbType.String, entidad.CUV);
            Context.Database.AddInParameter(command, "@Cantidad", DbType.Int32, entidad.Cantidad);
            Context.Database.AddInParameter(command, "@PrecioUnitario", DbType.Currency, entidad.PrecioUnitario);
            return Context.ExecuteNonQuery(command);
        }

    }
}
