using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class ClienteMobileModel
    {
        public long ConsultoraID { get; set; }

        public int ClienteID { get; set; }

        public int PaisID { get; set; }

        public int FlagValidate { get; set; }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Debe ingresar el Nombre del Cliente")]
        [StringLength(150, ErrorMessage = "No puede ingresar mas de 150 caracteres", MinimumLength = 1)]
        public string Nombre { get; set; }

        [Display(Name = "Correo")]
        [RegularExpression(@"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$", ErrorMessage = "Debe ingresar un email válido")]
        [StringLength(50, ErrorMessage = "No se puede ingresar más de 50 caracteres")]
        public string Email { get; set; }

        [Display(Name = "Celular")]
        [RegularExpression(@"^\d+$", ErrorMessage = "Debe ingresar un nro. celular válido")]
        public string Telefono { get; set; }

        public string CampaniaAnterior { get; set; }

        public string CampaniaActual { get; set; }

        public string CampaniaSiguiente { get; set; }

        public string CodigoZona { get; set; } //R20160204        
    }
}