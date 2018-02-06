using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPaqueteDocumentario : DataAccess
    {
        public DAPaqueteDocumentario(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int ActualizarEstadoPaqueteDocumentario(string codigo,int campania)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ActualizarEstadoPaqueteDocumentario");
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, codigo);
            Context.Database.AddInParameter(command, "@Campania", DbType.Int32, campania);
            return Context.ExecuteNonQuery(command);
        }

        public IDataReader ValidarInvitacionPaqueteDocumentario(string codigo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ValidarInvitacionPaqueteDocumentario");
            Context.Database.AddInParameter(command, "@Codigo", DbType.String, codigo);

            return Context.ExecuteReader(command);
        }

        public IDataReader GetPaqueteDocumentario()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetPaqueteDocumentario");
            return Context.ExecuteReader(command);
        }
    }
}
