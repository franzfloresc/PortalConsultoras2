namespace Portal.Consultoras.Web.Models
{
    public class HojaInscripcionMailModel
    {
        public string NombreCandidata { get; set; }
        public string NombreCompleto { get; set; }
        public string FechaNacimiento { get; set; }
        public string Direccion { get; set; }
        public string Telefono { get; set; }
        public string CorreoElectronico { get; set; }
        public string Edad { get; set; }
        public string TieneExperiencia { get; set; }
        public string EvaluacionCrediticia { get; set; }
        public bool ContactoUnete { get; set; }
        public string CodigoSeccion { get; set; }
        public string NombreDestinatario { get; set; }
        public string CorreoElectronicoDestinatario { get; set; }
        public bool ParaGZ { get; set; }
    }
}