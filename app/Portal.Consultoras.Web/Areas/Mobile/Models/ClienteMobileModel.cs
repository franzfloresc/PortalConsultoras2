using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class ClienteMobileModel
    {
        public long ConsultoraID { get; set; }

        public int ClienteID { get; set; }

        public int PaisID { get; set; }

        public int FlagValidate { get; set; }

        public string Nombre { get; set; }

        [Display(Name = "Correo")]
        [RegularExpression(@"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$", ErrorMessage = "Debe ingresar un email válido")]
        [StringLength(50, ErrorMessage = "No se puede ingresar más de 50 caracteres")]
        public string Email { get; set; }

        [Display(Name = "Teléfono Fijo")]
        public string Telefono { get; set; }

        public string CampaniaAnterior { get; set; }

        public string CampaniaActual { get; set; }

        public string CampaniaSiguiente { get; set; }

        public string CodigoZona { get; set; }

        [Display(Name = "Celular")]
        public string Celular { get; set; }

        public long CodigoCliente { get; set; }

        public short TieneTelefono { get; set; }

        [Required(ErrorMessage = "Debe ingresar el Nombre del Cliente")]
        [StringLength(100, ErrorMessage = "No puede ingresar mas de 100 caracteres", MinimumLength = 1)]
        public string NombreCliente { get; set; }

        [StringLength(100, ErrorMessage = "No puede ingresar mas de 100 caracteres", MinimumLength = 0)]
        public string ApellidoCliente { get; set; }
    }
}