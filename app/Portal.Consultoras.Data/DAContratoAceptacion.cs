using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAContratoAceptacion : DataAccess
    {
        public DAContratoAceptacion(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public int AceptarContratoAceptacion(long consultoraid, string codigoconsultora, string origen, string direccionIP, string InformacionSOMobile)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsContrato");
            Context.Database.AddInParameter(command, "@consultoraid", DbType.Int32, consultoraid);
            Context.Database.AddInParameter(command, "@codigoconsultora", DbType.AnsiString, codigoconsultora);
            Context.Database.AddInParameter(command, "@origen", DbType.String, origen);
            Context.Database.AddInParameter(command, "@direccionIP", DbType.String, direccionIP);
            Context.Database.AddInParameter(command, "@InformacionSOMobile", DbType.String, InformacionSOMobile);
            return Context.ExecuteNonQuery(command);
        }
    }
}