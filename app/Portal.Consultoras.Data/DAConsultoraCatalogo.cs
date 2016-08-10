using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAConsultoraCatalogo : DataAccess
    {
        public DAConsultoraCatalogo(int paisID)
            : base(paisID, EDbSource.Portal)
        {
            //
        }

        public IDataReader GetConsultoraCatalogo(int pais, string codigoConsultora, bool parametroEsDocumento)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetConsultoraCatalogo");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int64, pais);
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.AnsiString, codigoConsultora);
            Context.Database.AddInParameter(command, "@ParametroEsDocumento", DbType.Boolean, parametroEsDocumento);
            return Context.ExecuteReader(command);
        }
    }
}
