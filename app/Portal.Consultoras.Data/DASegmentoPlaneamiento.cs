using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Entities;
using System.Data.SqlClient;
using OpenSource.Library.DataAccess;
namespace Portal.Consultoras.Data
{
    public class DASegmentoPlaneamiento : DataAccess
    {
        public DASegmentoPlaneamiento(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader GetSegmentoPlaneamiento(int campaniaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.GetSegmentoPlaneamiento");
            Context.Database.AddInParameter(command, "@CampaniaID", DbType.Int32, campaniaId);
            return Context.ExecuteReader(command);
        }
    }
}
