using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraDigitales : DataAccess
    {
        public DAConsultoraDigitales(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public DataSet GetConsultoraDigitalesDescarga()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraDigitales");

            return Context.ExecuteDataSet(command);
        }

        public int InsConsultoraDigitales(string FechaProceso, string Usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsConsultoraDigitalesDescarga");
            Context.Database.AddInParameter(command, "@FechaProceso", DbType.AnsiString, FechaProceso);
            Context.Database.AddInParameter(command, "@Usuario", DbType.AnsiString, Usuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public void UpdConsultoraDigitales(int ConsultoraDigitalesId, int Estado, string ErrorProceso, string ErrorLog, string NombreArchivo, string NombreServer)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdConsultoraDigitalesDescarga");
            Context.Database.AddInParameter(command, "@ConsultoraDigitalesDescargaId ", DbType.Int32, ConsultoraDigitalesId);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, Estado);
            Context.Database.AddInParameter(command, "@ErrorProceso", DbType.AnsiString, ErrorProceso);
            Context.Database.AddInParameter(command, "@ErrorLog", DbType.AnsiString, ErrorLog);
            Context.Database.AddInParameter(command, "@NombreArchivo", DbType.AnsiString, NombreArchivo);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.AnsiString, NombreServer);

            Context.ExecuteNonQuery(command);
        }

    }
}