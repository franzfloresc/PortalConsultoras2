using Portal.Consultoras.Entities.Encuesta;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Data.Encuesta
{
    public class DAEncuesta :DataAccess
    {
        public DAEncuesta(int paisID)
            : base(paisID, EDbSource.Portal)
        {

        }

        public IDataReader ObtenerDataEncuesta(int encuestaId)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.ListarDataConfigEncuesta");
            Context.Database.AddInParameter(command, "@EncuestaId", DbType.Int32, encuestaId);

            return Context.ExecuteReader(command);
        }
    }
}
