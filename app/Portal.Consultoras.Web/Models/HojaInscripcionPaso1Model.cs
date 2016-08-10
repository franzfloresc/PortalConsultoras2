using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class HojaInscripcionPaso1Model
    {
        public string Token { get; set; }
        public string CodigoISO { get; set; }

        public int PaisID { get; set; }

        public string UsuarioCreacion { get; set; }

        public string FuenteIngreso { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(10, ErrorMessage = "Máximo 10 caractéres")]
        public string NumeroDocumento { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string PrimerNombre { get; set; }

        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string SegundoNombre { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string ApellidoPaterno { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string ApellidoMaterno { get; set; }

        //[Required(ErrorMessage = "Este campo es obligatorio")]
        public string FechaNacimiento { get; set; }

        public string Anio { get; set; }

        public string Mes { get; set; }

        public string Dia { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(1, ErrorMessage = "Máximo 1 caractér")]
        public string Sexo { get; set; }

        public int EstadoPostulante { get; set; }

        public bool? PostulanteRegistrada { get; set; }

        public bool? SolicitudRegistrada { get; set; }

        public string CodigoConsultora { get; set; }

        public string TipoSolicitud { get; set; }
    }
}