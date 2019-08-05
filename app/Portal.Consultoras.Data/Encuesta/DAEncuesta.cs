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

        public IDataReader GetReporteEncuestaSatisfaccion(BEEncuestaReporte bEncuesta)
        {
            DbCommand command = Context.Database.GetStoredProcCommand("dbo.EncuestaResultadoDetalle_List");
            Context.Database.AddInParameter(command, "@CodigoCampania", DbType.String, bEncuesta.CodigoCampania);
            Context.Database.AddInParameter(command, "@RegionID", DbType.Int32, bEncuesta.RegionID);
            Context.Database.AddInParameter(command, "@ZonaID", DbType.Int32, bEncuesta.ZonaID);
            return Context.ExecuteReader(command);
        }

    }
}
