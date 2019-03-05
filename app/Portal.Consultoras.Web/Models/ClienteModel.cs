using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class ClienteModel
    {
        public long ConsultoraID { get; set; }

        public int ClienteID { get; set; }

        public int PaisID { get; set; }

        public int FlagValidate { get; set; }

        [Required(ErrorMessage = "Debe ingresar el Nombre del Cliente")]
        [StringLength(150, ErrorMessage = "No puede ingresar mas de 150 caracteres", MinimumLength = 1)]
        public string Nombre { get; set; }

        [RegularExpression(@"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$", ErrorMessage = "Debe ingresar un email, válido")]
        [Required(ErrorMessage = "Debe ingresar el Correo Electrónico")]
        [StringLength(50, ErrorMessage = "No se puede ingresar más de 50 caracteres")]
        public string eMail { get; set; }

        public string CampaniaAnterior { get; set; }

        public string CampaniaActual { get; set; }

        public string CampaniaSiguiente { get; set; }

        public string CodigoZona { get; set; }

        public string Telefono { get; set; }

        public string Celular { get; set; }
        public long CodigoCliente { get; set; }
        public short TieneTelefono { get; set; }

        public string NombreCliente { get; set; }
        public string ApellidoCliente { get; set; }

        public string Origen { get; set; }
    }
}