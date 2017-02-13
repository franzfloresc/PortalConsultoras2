namespace Portal.Consultoras.Web.Models
{
    public class MisCatalogosRevistasModel
    {
        public int PaisID { get; set; }
        public string CodigoZona { get; set; }

        public string CampaniaAnterior { get; set; }
        public string CampaniaActual { get; set; }
        public string CampaniaSiguiente { get; set; }

        public string CodigoRevistaAnterior { get; set; }
        public string CodigoRevistaActual { get; set; }
        public string CodigoRevistaSiguiente { get; set; }
    }
}