using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class PremioProgNuevasOFModel
    {
        public string Cuv { get; set; }
        public string DescripcionPremio { get; set; }
        public decimal PrecioValorizado { get; set; }
        public string UrlImagenRegalo { get; set; }
    }
}