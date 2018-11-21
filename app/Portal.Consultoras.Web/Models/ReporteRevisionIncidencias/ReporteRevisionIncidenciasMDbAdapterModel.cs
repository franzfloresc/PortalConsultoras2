using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Models.ReporteRevisionIncidencias
{
    public class ReporteRevisionIncidenciasMDbAdapterModel
    {
        public string _id { get; set; }
        public bool FlagConfig { get; set; }
        public BEReporteCuvResumido BEReporteCuvResumido { get; set; }
        public BEReporteCuvDetallado BEReporteCuvDetallado { get; set; }
        public BEReporteEstrategiasPorConsultora BEReporteEstrategiasPorConsultora { get; set; }
        public BEReporteMovimientosPedido BEReporteMovimientosPedido { get; set; }
    }
}