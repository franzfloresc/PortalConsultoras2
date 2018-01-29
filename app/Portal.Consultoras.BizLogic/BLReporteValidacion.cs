using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLReporteValidacion
    {
        public IList<BEReporteValidacion> GetReporteValidacion(int paisID, int campaniaID, int tipoEstrategia)
        {
            var reporteValidaciones = new List<BEReporteValidacion>();
            var daReporteValidacion = new DAReporteValidacion(paisID);
            if (tipoEstrategia == 4)
            {
                using (IDataReader reader = daReporteValidacion.GetReporteValidacion(campaniaID))
                {
                    while (reader.Read())
                    {
                        var reporteValidacion = new BEReporteValidacion(reader);
                        reporteValidaciones.Add(reporteValidacion);
                    }
                }
            }
            if (tipoEstrategia == 7)
            {
                using (IDataReader reader = daReporteValidacion.GetReporteValidacionODD(campaniaID))
                {
                    while (reader.Read())
                    {
                        var reporteValidacion = new BEReporteValidacion(reader);
                        reporteValidaciones.Add(reporteValidacion);
                    }
                }
            }

            return reporteValidaciones;
        }

        public IList<BEReporteValidacionSRCampania> GetReporteShowRoomCampania(int paisID, int campaniaID)
        {
            var reporteValidaciones = new List<BEReporteValidacionSRCampania>();
            var daReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = daReporteValidacion.GetReporteValidacionSRCampania(campaniaID))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacionSRCampania(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }

        public IList<BEReporteValidacionSRPersonalizacion> GetReporteShowRoomPersonalizacion(int paisID, int campaniaID)
        {
            var reporteValidaciones = new List<BEReporteValidacionSRPersonalizacion>();
            var daReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = daReporteValidacion.GetReporteValidacionSRPersonalizacion(campaniaID))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacionSRPersonalizacion(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }

        public IList<BEReporteValidacionSROferta> GetReporteShowRoomOferta(int paisID, int campaniaID)
        {
            var reporteValidaciones = new List<BEReporteValidacionSROferta>();
            var daReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = daReporteValidacion.GetReporteValidacionSROferta(campaniaID))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacionSROferta(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }

        public IList<BEReporteValidacionSRComponentes> GetReporteShowRoomComponentes(int paisID, int campaniaID)
        {
            var reporteValidaciones = new List<BEReporteValidacionSRComponentes>();
            var daReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = daReporteValidacion.GetReporteValidacionSRComponentes(campaniaID))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacionSRComponentes(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }
    }
}
