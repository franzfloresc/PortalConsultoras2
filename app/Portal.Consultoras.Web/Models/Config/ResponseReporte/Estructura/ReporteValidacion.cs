namespace Portal.Consultoras.Web.Models.Config.ResponseReporte.Estructura
{
    using System.Collections.Generic;

    public class ReporteValidacion
    {
        public List<ReporteValidacionCampania> ReporteValidacionCampania { get; set; }
        public List<ReporteValidacionOferta> ReporteValidacionOferta { get; set; }
        public List<ReporteValidacionComponente> ReporteValidacionComponente { get; set; }
        public List<ReporteValidacionPersonalizacion> ReporteValidacionPersonalizacion { get; set; }
    }
}