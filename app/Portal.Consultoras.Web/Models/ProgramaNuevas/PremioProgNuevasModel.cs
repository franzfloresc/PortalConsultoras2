using System;

namespace Portal.Consultoras.Web.Models.ProgramaNuevas
{
    [Serializable]
    public class PremioProgNuevasModel
    {
        public string Cuv { get; set; }
        public string CodigoSap { get; set; }
        public string DescripcionPremio { get; set; }
        public decimal PrecioValorizado { get; set; }
    }
}