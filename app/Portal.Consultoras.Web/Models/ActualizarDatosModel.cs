using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class ActualizarDatosModel
    {
        public string NombreCompleto { get; set; }
        public string EMail { get; set; }
        public string Telefono { get; set; }
        public string Celular { get; set; }
        public string m_Apellidos { get; set; }
        public string m_Nombre { get; set; }
    }

    public class ActualizaContrasenia
    {

        public string PrimerNombre { get; set; }
        public string CodigoIso { get; set; }
        public string CodigoUsuario { get; set; }
        public bool EsMobile { get; set; }
        [Required(ErrorMessage = "La nueva contraseña es requerida")]
        [Display(Name = "Nueva Contraseña")]
        [DataType(DataType.Password)]
        [RegularExpression("^(?=.*[0-9])(?=.*[a-zA-Z]).{6,80}$", ErrorMessage = "La contraseña debe tener 6 o más caracteres combinado con letras y números"),]
        [StringLength(80, MinimumLength = 6, ErrorMessage = "La contraseña debe tener 6 o más caracteres")]
        public string Contrasenia { get; set; }

        [Required(ErrorMessage = "Confirme la contraseña")]
        [DataType(DataType.Password)]
        [System.Web.Mvc.Compare("Contrasenia", ErrorMessage = "Las contraseñas no coinciden")]
        [Display(Name = "Connfirmar Contraseña")]
        public string ConfirmaContrasenia { get; set; }
    }
}
