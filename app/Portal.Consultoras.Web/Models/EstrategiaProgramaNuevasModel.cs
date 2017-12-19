namespace Portal.Consultoras.Web.Models
{
    public class EstrategiaProgramaNuevasModel
    {
        public int EstrategiaID { get; set; }
        public string CodigoPrograma { get; set; }
        public int CampaniaInicio { get; set; }
        public int CampaniaFin { get; set; }
        public string CUV { get; set; }
        public string DescripcionCUV { get; set; }
        public string CodigoSAP { get; set; }
        public decimal Precio { get; set; }
        public decimal Valorizado { get; set; }
        public decimal Ganancia { get; set; }
        public string Mensaje { get; set; }
        public int Orden { get; set; }
        public bool Activo { get; set; }
        public string ImageUrl { get; set; }
    }
}