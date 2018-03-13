namespace Portal.Consultoras.Web.Models
{
    public class EstrategiaIncentivosModel
    {
        public int EstrategiaID { get; set; }
        public string CodigoConcurso { get; set; }
        public int CampaniaInicio { get; set; }
        public int CampaniaFin { get; set; }
        public string CUV { get; set; }
        public string DescripcionCUV { get; set; }
        public string CodigoSAP { get; set; }
        public bool Activo { get; set; }
        public string ImageUrl { get; set; }
        public int Orden { get; set; }
    }
}