using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class ReporteRevisionIncidenciasModel : EstrategiaModel
    {
        public int TipoReporteID { get; set; }
        public IEnumerable<BETipoReporte> listaTipoReporte { get; set; }
    }
}