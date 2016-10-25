using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace Portal.Consultoras.Data
{
    public class DALogGPRValidacion : DataAccess
    {
        public DALogGPRValidacion(int paisID)
            : base(paisID, EDbSource.Portal) { }

        public BELogGPRValidacion GetByLogGPRValidacionId(long logGPRValidacionId)
        {
            BELogGPRValidacion entity = null;
            DbCommand command = Context.Database.GetStoredProcCommand("GPR.GetLogGPRValidacionByLogGPRValidacionId");
            Context.Database.AddInParameter(command, "@LogGPRValidacionId", DbType.Int64, logGPRValidacionId);

            using (IDataReader reader = Context.ExecuteReader(command))
            {
                if (reader.Read()) entity = new BELogGPRValidacion(reader);
            }
            return entity;
        }
    }
}
