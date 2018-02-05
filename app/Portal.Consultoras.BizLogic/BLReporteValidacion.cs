﻿using Portal.Consultoras.Entities;
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
        public IList<BEReporteValidacion> GetReporteValidacion(int paisID, int campaniaID, int tipoEstrategia)
        {
            var reporteValidaciones = new List<BEReporteValidacion>();
            var DAReporteValidacion = new DAReporteValidacion(paisID);
            if (tipoEstrategia == 4)
            {
                using (IDataReader reader = DAReporteValidacion.GetReporteValidacion(campaniaID))
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
                using (IDataReader reader = DAReporteValidacion.GetReporteValidacionODD(campaniaID))
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
            var DAReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = DAReporteValidacion.GetReporteValidacionSRCampania(campaniaID))
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
            var DAReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = DAReporteValidacion.GetReporteValidacionSRPersonalizacion(campaniaID))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacionSRPersonalizacion(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }

        [Obsolete("Migrado PL50-50")]
        public IList<BEReporteValidacionSROferta> GetReporteShowRoomOferta(int paisID, int campaniaID)
        {
            var reporteValidaciones = new List<BEReporteValidacionSROferta>();
            var DAReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = DAReporteValidacion.GetReporteValidacionSROferta(campaniaID))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteValidacionSROferta(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }

        [Obsolete("Migrado PL50-50")]
        public IList<BEReporteValidacionSRComponentes> GetReporteShowRoomComponentes(int paisID, int campaniaID)
        {
            var reporteValidaciones = new List<BEReporteValidacionSRComponentes>();
            var DAReporteValidacion = new DAReporteValidacion(paisID);

            using (IDataReader reader = DAReporteValidacion.GetReporteValidacionSRComponentes(campaniaID))
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
