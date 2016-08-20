using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Annotations;

namespace Portal.Consultoras.Web.Models
{
    public class HojaInscripcionPaso2Model : HojaInscripcionPaso1Model
    {

        public HojaInscripcionPaso2Model()
        {
            Puntos = new List<Tuple<decimal, decimal, string>>();
            //ColoniasMx = new SelectList();
        }
        
        
        [RequiredIfPropertiesNotNull("CodigoISO", "CL", "Telefono,Celular", true, ErrorMessage = "Debe ingresar al menos un teléfono")]
        [RequiredIf("CodigoISO", "MX", ErrorMessage = "Este campo es obligatorio")]
        [ExpressionRequiredIf("CodigoISO", "MX", Expresiones = new[] { @"(\d)\1{5,}" }, RegexNotMatch = true, ErrorMessage = "Formato Incorrecto")]
        public string Telefono { get; set; }

        [RequiredIf("CodigoISO", "CO,MX", ErrorMessage = "Este campo es obligatorio")]
        [ExpressionRequiredIf("CodigoISO", "MX", Expresiones = new[] { @"(\d)\1{5,}" }, RegexNotMatch = true, ErrorMessage = "Formato Incorrecto")]
        public string Celular { get; set; }

        [EmailAddress(ErrorMessage = "No es un correo válido")]
        [MaxLength(100, ErrorMessage = "Máximo 100 caractéres")]
        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string CorreoElectronico { get; set; }

        //[MaxLength(6, ErrorMessage = "Máximo 6 caractéres")]
        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Region { get; set; }

        public string NombreRegion { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string Comuna { get; set; }

        public string NombreComuna { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string CalleOAvenida { get; set; }

        [MaxLength(8, ErrorMessage = "Máximo 8 caractéres")]
        public string Numero { get; set; }

        [RequiredIf("CodigoISO", "CO,MX", ErrorMessage = "Este campo es obligatorio")]
        public string DptoCasa { get; set; }

        [MaxLength(5, ErrorMessage = "Máximo 5 caractéres")]
        [RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string CodigoPostal { get; set; }

        /// <summary>
        /// Item1: Latitud, Item2: Longitud, Item3: dirección obtenidad por el servicio
        /// </summary>
        public List<Tuple<decimal, decimal, string>> Puntos { get; set; }

        public char? DireccionCorrecta { get; set; }

        public string Latitud { get; set; }

        public string Longitud { get; set; }

        public bool ConsultoServicioGEO { get; set; }

        public string ResultadoZona { get; set; }


        public bool ZonaPreferencial { get; set; }

        //Parámetros para Geo Colombia
        public string Departamento { get; set; }
        public string NombreDepartamento { get; set; }

        //[Required(ErrorMessage = MensajeError)]
        public string Ciudad { get; set; }
        public string NombreCiudad { get; set; }
        public string Barrio { get; set; }
        public string NombreBarrio { get; set; }

        [RequiredIf("CodigoISO", "CO", ErrorMessage = "Este campo es obligatorio")]
        public string DireccionColombia { get; set; }
        public string NombreDireccionColombia { get; set; }

        //Campos Geo Mexico

        [RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string PrefijoCelular { get; set; }

        public string NombrePrefijoCelular { get; set; }

       // public SelectList ColoniasMx { get; set; }


        [RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string Colonia { get; set; }

        public string NombreColonia { get; set; }

        //[RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string DireccionMx { get; set; }
    }
}