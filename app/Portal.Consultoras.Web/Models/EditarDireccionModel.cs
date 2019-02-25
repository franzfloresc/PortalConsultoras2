using Portal.Consultoras.Web.Annotations;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Models
{
    public class EditarDireccionModel
    {
        public int SolicitudPostulanteID { get; set; }

        public string CodigoPais { get; set; }

        [RequiredIf("CodigoPais", "MX", ErrorMessage = "Este campo es obligatorio")]
        public string Colonia { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string CalleOAvenida { get; set; }

        [RequiredIf("CodigoPais", "MX,CL", ErrorMessage = "Este campo es obligatorio")]
        public string Numero { get; set; }

        [RequiredIf("CodigoPais", "PE,MX,EC", ErrorMessage = "Este campo es obligatorio")]
        public string Referencia { get; set; }

        [RequiredIf("CodigoPais", "CO", ErrorMessage = "Este campo es obligatorio")]
        public string NombreDireccionEdicion { get; set; }

        public bool ZonaPreferencial { get; set; }

        public string NombrePrefijoCelular { get; set; }

        [MaxLength(6, ErrorMessage = "Máximo 6 caractéres")]
        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string LugarNivel1 { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string LugarNivel2 { get; set; }
        [RequiredIf("CodigoPais", "MX,CO,PE,EC", ErrorMessage = "Este campo es obligatorio")]
        public string LugarNivel3 { get; set; }
        public string LugarNivel4 { get; set; }
        [RequiredIf("CodigoPais", "GT", ErrorMessage = "Este campo es obligatorio")]
        public string LugarNivel5 { get; set; }

        public string NombreLugarNivel1 { get; set; }
        public string NombreLugarNivel2 { get; set; }
        public string NombreLugarNivel3 { get; set; }
        public string NombreLugarNivel4 { get; set; }
        public string NombreLugarNivel5 { get; set; }

        public SelectList LugaresNivel1 { get; set; }
        public SelectList LugaresNivel3 { get; set; }

        public SelectList LugaresNivel2 { get; set; }
        public SelectList LugaresNivel4 { get; set; }
        public SelectList LugaresNivel5 { get; set; }
        public int ContaValorNivel3 { get; set; }

        public string CodigoPostal { get; set; }

    }
}