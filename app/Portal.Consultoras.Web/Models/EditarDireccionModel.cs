using Portal.Consultoras.Web.Annotations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Models
{
    public class EditarDireccionModel
    {
        public int SolicitudPostulanteID { get; set; }

        public string CodigoPais { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string CalleOAvenida { get; set; }

        //[Required(ErrorMessage = "Este campo es obligatorio")]
        [RequiredIf("CodigoPais", "MX", ErrorMessage = "Este campo es obligatorio")]
        //[MaxLength(8, ErrorMessage = "Máximo 8 caractéres")]
        [ExpressionRequiredIf("CodigoPais", "MX", Expresion = @"^[0-9]{5}$", ErrorMessage = "Máximo 5 caractéres")]
        public string Numero { get; set; }

        [RequiredIf("CodigoPais", "PE,MX", ErrorMessage = "Este campo es obligatorio")]
        public string Referencia { get; set; }

        //[Required(ErrorMessage = "Este campo es obligatorio")]
        [RequiredIf("CodigoPais", "CO", ErrorMessage = "Este campo es obligatorio")]
        public string NombreDireccionEdicion { get; set; }

        public bool ZonaPreferencial { get; set; }

        //Campos Geo Mexico

        //[RequiredIf("CodigoPais", "MX", ErrorMessage = "Este campo es obligatorio")]
        //public string PrefijoCelular { get; set; }

        public string NombrePrefijoCelular { get; set; }

        [MaxLength(6, ErrorMessage = "Máximo 6 caractéres")]
        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string LugarNivel1 { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string LugarNivel2 { get; set; }
        [RequiredIf("CodigoPais", "MX,CO,PE", ErrorMessage = "Este campo es obligatorio")]
        public string LugarNivel3 { get; set; }
        //[ExpressionRequiredIf("ContaValorNivel3", "1", Expresion = @"^(\s|\S)*(\S)+(\s|\S)*$", RegexNotMatch = false, ErrorMessage = "Campo obligatorio")]
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
        public int ContaValorNivel3 { get; set; }
    }
}