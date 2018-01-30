using System;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DAPais : DataAccess
    {
        public DAPais(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader EsPaisHana(int paisId)
        {
            try
            {
                using (DbCommand command = Context.Database.GetStoredProcCommand("dbo.EsPaisHana"))
                {
                    Context.Database.AddInParameter(command, "@PaisId", DbType.Int32, paisId);
                    return Context.ExecuteReader(command);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
