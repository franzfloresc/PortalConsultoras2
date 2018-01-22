using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAMiAcademia : DataAccess
    {
        public DAMiAcademia(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public DataSet GetInformacionCursoLiderDescarga(int LetCursoDescargaId, string FechaProceso)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("miacademia.GetInformacionCursoLiderDescarga");
            Context.Database.AddInParameter(command, "@LetCursoDescargaId", DbType.Int32, LetCursoDescargaId);
            Context.Database.AddInParameter(command, "@FechaProceso", DbType.AnsiString, FechaProceso);

            return Context.ExecuteDataSet(command);
        }

        public int InsLetCursoDescarga(string FechaProceso, string Usuario)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("miacademia.InsLetCursoDescarga");
            Context.Database.AddInParameter(command, "@FechaProceso", DbType.AnsiString, FechaProceso);
            Context.Database.AddInParameter(command, "@Usuario", DbType.AnsiString, Usuario);

            return Convert.ToInt32(Context.ExecuteScalar(command));
        }

        public void UpdLetCursoDescarga(int LetCursoDescargaId, int Estado, string ErrorProceso, string ErrorLog, string NombreArchivo, string NombreServer)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("miacademia.UpdLetCursoDescarga");
            Context.Database.AddInParameter(command, "@LetCursoDescargaId", DbType.Int32, LetCursoDescargaId);
            Context.Database.AddInParameter(command, "@Estado", DbType.Int32, Estado);
            Context.Database.AddInParameter(command, "@ErrorProceso", DbType.AnsiString, ErrorProceso);
            Context.Database.AddInParameter(command, "@ErrorLog", DbType.AnsiString, ErrorLog);
            Context.Database.AddInParameter(command, "@NombreArchivo", DbType.AnsiString, NombreArchivo);
            Context.Database.AddInParameter(command, "@NombreServer", DbType.AnsiString, NombreServer);

            Context.ExecuteNonQuery(command);
        }

    }
}
