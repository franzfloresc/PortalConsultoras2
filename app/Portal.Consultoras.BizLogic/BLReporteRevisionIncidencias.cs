using System;
using Portal.Consultoras.Data;
using Portal.Consultoras.Entities;
using System.Collections.Generic;
using System.Data;

namespace Portal.Consultoras.BizLogic
{
    public class BLReporteRevisionIncidencias
    {
        public IList<BEReporteCuvResumido> GetReporteCuvResumido(int paisID, int campaniaID, string cuv)
        {
            var reporteValidaciones = new List<BEReporteCuvResumido>();
            var daReporteValidacion = new DAReporteRevisionIncidencias(paisID);

            using (IDataReader reader = daReporteValidacion.GetReporteCuvResumido(campaniaID, cuv))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteCuvResumido(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }

        public IList<BEReporteCuvDetallado> GetReporteCuvDetallado(int paisID, int campaniaID, string cuv)
        {
            try
            {
                var reporteValidaciones = new List<BEReporteCuvDetallado>();
                var daReporteValidacion = new DAReporteRevisionIncidencias(paisID);

                using (IDataReader reader = daReporteValidacion.GetReporteCuvDetallado(campaniaID, cuv))
                {
                    while (reader.Read())
                    {
                        var reporteValidacion = new BEReporteCuvDetallado(reader);
                        reporteValidaciones.Add(reporteValidacion);
                    }
                }

                return reporteValidaciones;
            }
            catch (Exception ex)
            {
                throw new Exception(Common.LogManager.GetMensajeError(ex));
            }
        }

        public IList<BEReporteMovimientosPedido> GetReporteMovimientosPedido(int paisID, int campaniaID, string codigoConsultora)
        {
            var reporteValidaciones = new List<BEReporteMovimientosPedido>();
            var daReporteValidacion = new DAReporteRevisionIncidencias(paisID);

            using (IDataReader reader = daReporteValidacion.GetReporteMovimientosPedido(campaniaID, codigoConsultora))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteMovimientosPedido(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }

        public IList<BEReporteEstrategiasPorConsultora> GetReporteEstrategiasPorConsultora(int paisID, int campaniaID, string codigoConsultora, int palanca, DateTime fechaConsulta)
        {
            var reporteValidaciones = new List<BEReporteEstrategiasPorConsultora>();
            var daReporteValidacion = new DAReporteRevisionIncidencias(paisID);

            using (IDataReader reader = daReporteValidacion.GetReporteEstrategiasPorConsultora(campaniaID, codigoConsultora, palanca, fechaConsulta))
            {
                while (reader.Read())
                {
                    var reporteValidacion = new BEReporteEstrategiasPorConsultora(reader);
                    reporteValidaciones.Add(reporteValidacion);
                }
            }

            return reporteValidaciones;
        }
    }
}
