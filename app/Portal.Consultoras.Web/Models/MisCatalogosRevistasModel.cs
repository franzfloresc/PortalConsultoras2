namespace Portal.Consultoras.Web.Models
{
    public class MisCatalogosRevistasModel
    {
        public string PaisNombre { get; set; }

        public string CampaniaAnterior { get; set; }
        public string CampaniaActual { get; set; }
        public string CampaniaSiguiente { get; set; }

        public string CodigoRevistaAnterior { get; set; }
        public string CodigoRevistaActual { get; set; }
        public string CodigoRevistaSiguiente { get; set; }

        public string NombreClasefb { get; set; }
        public string NombreClasews { get; set; }

        public bool MostrarTab { get; set; }
        public bool MostrarRevistaDigital { get; set; }
        public bool TieneGND { get; set; }
        
        public PartialSectionBpt PartialSectionBpt { get; set; }
    }
}