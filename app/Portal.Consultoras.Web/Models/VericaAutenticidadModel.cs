namespace Portal.Consultoras.Web.Models
{
    public class VericaAutenticidadModel
    {        
        public string PrimerNombre { get; set; }
        public string CorreoEnmascarado { get; set; }
        public string CelularEnmascarado { get; set; }
        public string OpcionCorreoActiva { get; set; }
        public string OpcionSmsActiva { get; set; }
        public int HoraRestanteCorreo { get; set; }
        public int HoraRestanteSms { get; set; }
        public string DescripcionHorario { get; set; }
        public string TelefonoCentral { get; set; }
        public string MensajeSaludo { get; set; }        
    }
}