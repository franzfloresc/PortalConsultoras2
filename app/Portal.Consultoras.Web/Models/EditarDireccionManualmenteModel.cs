using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class EditarDireccionManualmenteModel
    {
        public int SolicitudPostulanteID { get; set; }

        public string CodigoPais { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Region { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Zona { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Seccion { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Territorio { get; set; }

        public string CodigoZona { get; set; }

        public string CodigoSeccion { get; set; }

        public string CodigoTerritorio { get; set; }
    }
}