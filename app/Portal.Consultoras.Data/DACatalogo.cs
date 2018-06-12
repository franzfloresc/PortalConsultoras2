using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DACatalogo : DataAccess
    {
        public DACatalogo(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetCatalogosByCampania(int CampaniaID)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCatalogosByCampania");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, CampaniaID);
            return Context.ExecuteReader(command);
        }

        public IDataReader GetCatalogoConfiguracion()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetCatalogoConfiguracion");
            return Context.ExecuteReader(command);
        }

        public IDataReader GetCatalogoRevistas_ODS()
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GETCATALOGO_REVISTA_ODS");
            return Context.ExecuteReader(command);
        }
    }
}