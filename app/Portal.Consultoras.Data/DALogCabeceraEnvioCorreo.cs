using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DALogCabeceraEnvioCorreo : DataAccess
    {
        public DALogCabeceraEnvioCorreo(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int InsLogCabeceraEnvioCorreo(BELogCabeceraEnvioCorreo entidad)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsLogCabeceraEnvioCorreo");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int64, entidad.ConsultoraID);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, entidad.CodigoConsultora);
            Context.Database.AddInParameter(command, "@FechaFacturacion", DbType.DateTime, entidad.FechaFacturacion);
            Context.Database.AddInParameter(command, "@Email", DbType.AnsiString, entidad.Email);
            Context.Database.AddInParameter(command, "@Asunto", DbType.AnsiString, entidad.Asunto);
            Context.Database.AddInParameter(command, "@FechaEnvio", DbType.DateTime, entidad.FechaEnvio);
            Context.Database.AddOutParameter(command, "@CabeceraID", DbType.Int32, 10);
            Context.ExecuteNonQuery(command);

            return (int)Context.Database.GetParameterValue(command, "@CabeceraID");

        }

    }
}