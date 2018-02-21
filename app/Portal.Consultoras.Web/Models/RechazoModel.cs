using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class RechazoModel
    {
        public string CodigoISO { get; set; }
        [Required(ErrorMessage = "Campo obligatorio")]
        public string TipoRechazo { get; set; }
        public string MotivoRechazo { get; set; }
        public int SolicitudPostulanteID { get; set; }

        public string NombreCompleto { get; set; }
    }
}