using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DATerminosCondiciones : DataAccess
    {
        public DATerminosCondiciones(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public bool InsertTerminosCondiciones(BETerminosCondiciones terminos)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsTerminosCondiciones");

            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, terminos.CodigoConsultora);
            Context.Database.AddInParameter(command, "@Aceptado", DbType.Boolean, terminos.Aceptado);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Int16, terminos.Tipo);

            return Context.ExecuteNonQuery(command) > 0;
        }

        public IDataReader GetTerminosCondiciones(string CodigoConsultora, short Tipo)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetTerminosCondiciones");
            Context.Database.AddInParameter(command, "@CodigoConsultora", DbType.String, CodigoConsultora);
            Context.Database.AddInParameter(command, "@Tipo", DbType.Int16, Tipo);

            return Context.ExecuteReader(command);
        }
    }
}