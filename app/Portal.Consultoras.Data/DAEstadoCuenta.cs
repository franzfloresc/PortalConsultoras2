using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAEstadoCuenta : DataAccess
    {
        public DAEstadoCuenta(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetEstadoCuentaConsultora(long consultoraId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetEstadoCuentaConsultora_SB2");
            Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraId);
            return Context.ExecuteReader(command);
        }

        public string GetDeudaActualConsultora(long consultoraId)
        {
            try
            {
                DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetDeudaActualConsultora");
                Context.Database.AddInParameter(command, "@ConsultoraID", DbType.Int32, consultoraId);
                return Convert.ToString(Context.ExecuteScalar(command));
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
}