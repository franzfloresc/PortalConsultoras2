using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class EditarDireccionModel
    {
        public int SolicitudPostulanteID { get; set; }

        public string CodigoPais { get; set; }

        [MaxLength(6, ErrorMessage = "Máximo 6 caractéres")]
        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Region { get; set; }

        public string NombreRegionEdicion { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Comuna { get; set; }

        public string NombreComunaEdicion { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string CalleOAvenida { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(8, ErrorMessage = "Máximo 8 caractéres")]
        public string Numero { get; set; }

        public string Referencia { get; set; }

        //Parámetros para Geo Colombia
        public string Departamento { get; set; }
        public string NombreDepartamento { get; set; }

        //[Required(ErrorMessage = MensajeError)]
        public string Ciudad { get; set; }
        public string NombreCiudad { get; set; }
        public string Barrio { get; set; }
        public string NombreBarrio { get; set; }
        public string DireccionColombia { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string NombreDireccionColombia { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string NombreDireccionEdicion { get; set; }
    }
}