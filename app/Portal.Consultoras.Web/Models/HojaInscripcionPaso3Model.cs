using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.Annotations;

namespace Portal.Consultoras.Web.Models
{
    public class HojaInscripcionPaso3Model : HojaInscripcionPaso2Model
    {

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public char RecomendoConsultora { get; set; }

        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        [RequiredIf("RecomendoConsultora", "S", ErrorMessage = "Este campo es obligatorio")]
        public string CodigoConsultoraRecomienda { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string EstadoCivil { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string NivelEducativo { get; set; }

        [RequiredIf("CodigoISO", "CO,CL", ErrorMessage = "Este campo es obligatorio")]
        public string Nacionalidad { get; set; }

        //[Required(ErrorMessage = "Este campo es obligatorio")]
        //public int? CodigoOtrasMarcas { get; set; }

        public string DireccionCadena { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public int? TieneExperiencia { get; set; }

    }
}