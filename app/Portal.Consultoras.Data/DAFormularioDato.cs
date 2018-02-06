using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAFormularioDato : DataAccess
    {
        public DAFormularioDato()
            : base()
        {

        }

        public int DelFormularioDato(int PaisID, int TipoFormularioID, int FormularioDatoID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.DelFormularioDato");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@TipoFormularioID", DbType.Int32, TipoFormularioID);
            Context.Database.AddInParameter(command, "@FormularioDatoID", DbType.Int32, FormularioDatoID);

            return Context.ExecuteNonQuery(command);
        }

        public IDataReader GetFormularioDatoAll(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetFormularioDatoAll");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }

        public int UpdFormularioDato(BEFormularioDato formularioDato)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdFormularioDato");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, formularioDato.PaisID);
            Context.Database.AddInParameter(command, "@TipoFormularioID", DbType.Int32, formularioDato.TipoFormularioID);
            Context.Database.AddInParameter(command, "@FormularioDatoID", DbType.Int32, formularioDato.FormularioDatoID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, formularioDato.Descripcion);
            Context.Database.AddInParameter(command, "@Archivo", DbType.AnsiString, formularioDato.Archivo);
            Context.Database.AddInParameter(command, "@URL", DbType.AnsiString, formularioDato.URL);

            return Context.ExecuteNonQuery(command);
        }

        public int InsFormularioDato(BEFormularioDato formularioDato)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsFormularioDato");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, formularioDato.PaisID);
            Context.Database.AddInParameter(command, "@TipoFormularioID", DbType.Int32, formularioDato.TipoFormularioID);
            Context.Database.AddInParameter(command, "@FormularioDatoID", DbType.Int32, formularioDato.FormularioDatoID);
            Context.Database.AddInParameter(command, "@Descripcion", DbType.AnsiString, formularioDato.Descripcion);
            Context.Database.AddInParameter(command, "@Archivo", DbType.AnsiString, formularioDato.Archivo);
            Context.Database.AddInParameter(command, "@URL", DbType.AnsiString, formularioDato.URL);

            return Context.ExecuteNonQuery(command);
        }
    }
}