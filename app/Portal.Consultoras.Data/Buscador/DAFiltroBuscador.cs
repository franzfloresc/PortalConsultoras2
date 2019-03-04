using System.Data;

namespace Portal.Consultoras.Data.Buscador
{
    public class DAFiltroBuscador : DataAccess
    {
        public DAFiltroBuscador(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetFiltroBuscador(int tablaLogicaDatosID)
        {
            using (var command = Context.Database.GetStoredProcCommand("dbo.GetFiltroBuscador"))
            {
                Context.Database.AddInParameter(command, "@TablaLogicaDatosID", DbType.Int32, tablaLogicaDatosID);
                return Context.ExecuteReader(command);
            }
        }
    }
}
