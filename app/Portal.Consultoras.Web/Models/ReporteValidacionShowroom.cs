namespace Portal.Consultoras.Web.Models
{
    using Portal.Consultoras.Web.ServicePedido;
    using System.Collections.Generic;

    public class ReporteValidacionShowroom
    {
        public List<ReporteValidacionSRModel> ListaCampania { get; set; }
        public List<ReporteValidacionSRModel> ListaPersonalizacion { get; set; }
        public List<ReporteValidacionSRModel> ListaOferta { get; set; }
        public List<ReporteValidacionSRModel> ListaComponente { get; set; }
    }
}