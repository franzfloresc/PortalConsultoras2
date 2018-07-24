using System;
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

            using (IDataReader reader = daReporteValidacion.GetReporteValidacionUnificado(campaniaID, tipoEstrategia))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacion(reader);
                    reporteValidaciones.Add(reporteValidacion);
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
            List<BEReporteValidacionSROferta> reporteValidaciones = new List<BEReporteValidacionSROferta>();
            DAReporteValidacion daReporteValidacion = new DAReporteValidacion(paisID);
            using (IDataReader reader = daReporteValidacion.GetReporteValidacionSROferta(campaniaID))
            {
                while (reader.Read())
                {
                    BEReporteValidacionSROferta reporteValidacion = new BEReporteValidacionSROferta(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }
            return reporteValidaciones;
        }

        public IList<BEReporteValidacionSRComponentes> GetReporteShowRoomComponentes(int paisID, int campaniaID)
        {
            List<BEReporteValidacionSRComponentes> reporteValidaciones = new List<BEReporteValidacionSRComponentes>();
            DAReporteValidacion daReporteValidacion = new DAReporteValidacion(paisID);
            using (IDataReader reader = daReporteValidacion.GetReporteValidacionSRComponentes(campaniaID))
            {
                while (reader.Read())
                {
                    BEReporteValidacionSRComponentes reporteValidacion = new BEReporteValidacionSRComponentes(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }
            return reporteValidaciones;
        }
    }
}
