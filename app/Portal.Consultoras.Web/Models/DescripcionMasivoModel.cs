using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class DescripcionMasivoModel
    {
        public string Pais { get; set; }
        public string CampaniaId { get; set; }
        public string TipoEstrategia { get; set; }
        public HttpPostedFileBase Documento { get; set; }
        public string TipoEstrategiaCodigo { get; set; }
    }
}