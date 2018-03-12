using System.Data;

namespace Portal.Consultoras.Data
{
    public class DAMenuMobile : DataAccess
    {
        public DAMenuMobile(int paisID)
            : base(paisID, EDbSource.Portal)
        {
        }

        public IDataReader GetItems()
        {
            var command = Context.Database.GetStoredProcCommand("dbo.GetMenuMobile_SB2");
            return Context.ExecuteReader(command);
        }
    }
}