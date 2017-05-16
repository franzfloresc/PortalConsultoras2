using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class CuponEnviarCorreoConfirmacion
    {
        [Required]
        public string EMailNuevo { get; set; }
        [Required]
        public string Celular { get; set; }
    }
}