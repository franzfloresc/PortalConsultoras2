using Portal.Consultoras.Entities;
using Portal.Consultoras.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.BizLogic
{
    public class BLReporteValidacion
    {
        public IList<BEReporteValidacion> GetReporteValidacion(int paisID, string paisISO, int campaniaID, int tipoEstrategia)
        {
            var reporteValidaciones = new List<BEReporteValidacion>();
            var DAReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = DAReporteValidacion.GetReporteValidacion(paisISO, campaniaID, tipoEstrategia))
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacion(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }

            return reporteValidaciones;
        }
    }
}
