using Portal.Consultoras.Entities;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAContenidoDato : DataAccess
    {
        public DAContenidoDato()
            : base()
        {

        }

        public IDataReader GetContenidoDato(int PaisID, int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetContenidoDato");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);

            return Context.ExecuteReader(command);
        }

        public int InsContenidoDato(BEContenidoDato contenidodato)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.InsContenidoDato");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, contenidodato.PaisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, contenidodato.CampaniaID);
            Context.Database.AddInParameter(command, "@ImagenFondo", DbType.String, contenidodato.ImagenFondo);
            Context.Database.AddInParameter(command, "@ImagenLogo", DbType.String, contenidodato.ImagenLogo);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public int UpdContenidoDato(BEContenidoDato contenidodato)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.UpdContenidoDato");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, contenidodato.PaisID);
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, contenidodato.CampaniaID);
            Context.Database.AddInParameter(command, "@ImagenFondo", DbType.String, contenidodato.ImagenFondo);
            Context.Database.AddInParameter(command, "@ImagenLogo", DbType.String, contenidodato.ImagenLogo);
            int result = Context.ExecuteNonQuery(command);
            return result;
        }

        public IDataReader GetLinksPorPais(int PaisID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ObtenerLinksxPais");
            Context.Database.AddInParameter(command, "@PaisID", DbType.Int32, PaisID);

            return Context.ExecuteReader(command);
        }
    }
}