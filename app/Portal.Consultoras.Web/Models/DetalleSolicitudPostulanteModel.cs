using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceUnete;
using System.ComponentModel.DataAnnotations;
using Portal.Consultoras.Web.Annotations;

namespace Portal.Consultoras.Web.Models
{
    public class DetalleSolicitudPostulanteModel
    {
        public SolicitudPostulanteModel Solicitud { get; set; }

        public bool ModoLectura { get; set; }

        public string CodigoISO { get; set; }
    }

    public class SolicitudPostulanteModel
    {
        public int SolicitudPostulanteID { get; set; }

        public int? EstadoPostulante { get; set; }

        public string CodigoConsultora { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string ApellidoPaterno { get; set; }

        [RequiredIf("CodigoISO", "CL", ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string ApellidoMaterno { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string PrimerNombre { get; set; }

        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]
        public string SegundoNombre { get; set; }

        //[RequiredIf("CodigoISO", "CL", @"\d{8}\-[a-zA-Z0-9]", ErrorMessage = "Formato incorrecto")]
        //[RequiredIf("CodigoISO", "CO", @"^\d{4,10}$", ErrorMessage = "Formato incorrecto")]
        //[Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(10, ErrorMessage = "Máximo 10 caractéres")]
        public string NumeroDocumento { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(1, ErrorMessage = "Máximo 1 caractér")]
        public string Sexo { get; set; }

        //[RequiredIfPropertiesNotNull("Anio,Mes,Dia", false, ErrorMessage = "Este campo es obligatorio")]
        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string FechaNacimiento { get; set; }

       // [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(140, ErrorMessage = "Máximo 140 caractéres")]
        public string Direccion { get; set; }

        public string Referencia { get; set; }

        public string Telefono { get; set; }

        //[RequiredIf("CodigoISO", "CO", ErrorMessage = "Este campo es obligatorio")]
        public string Celular { get; set; }

        [EmailAddress(ErrorMessage = "No es un correo válido")]
        [MaxLength(100, ErrorMessage = "Máximo 100 caractéres")]
        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string CorreoElectronico { get; set; }

        public string CodigoZona { get; set; }

        public string CodigoSeccion { get; set; }

        public string CodigoTerritorio { get; set; }

        public string EstadoCivil { get; set; }

        public string NivelEducativo { get; set; }

        public string TipoNacionalidad { get; set; }

        public int? TipoContacto { get; set; }

        [MaxLength(15, ErrorMessage = "Máximo 15 caractéres")]        
        public string CodigoConsultoraRecomienda { get; set; }

        public string CodigoPais { get; set; }
        public string CodigoISO { get; set; }

        //Campos Geo Mexico

        [RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string PrefijoTelefono { get; set; }

        [RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string PrefijoCelular { get; set; }

        public string NombrePrefijoCelular { get; set; }

        // public SelectList ColoniasMx { get; set; }


        [RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string Colonia { get; set; }

        public string NombreColonia { get; set; }

        //[RequiredIf("CodigoISO", "MX", ErrorMessage = "Campo obligatorio")]
        public string DireccionMx { get; set; }

        public string NumeroDocumentoRegex
        {
            get
            {
                return RegexUtilitiesUnete.DocumentoIdentidad[this.CodigoPais];
            }
        }

        public int LengthTelefonoFijo
        {
            get
            {
                return DictionariesUnete.LengthTelefonoFijo[this.CodigoPais];
            }
        }

        public int LengthTelefonoCelular
        {
            get
            {
                return DictionariesUnete.LengthTelefonoCelular[this.CodigoPais];
            }
        }
    }

    public static class RegexUtilitiesUnete
    {
        public const string LettersAndWhiteSpaceOnly = "/^[a-zA-ZñáéíóúÑÁÉÍÓÚäëïöüÄËÏÖÜ\\s]*$/";
        public const string RUT = "^$|^[0-9]{8}-[a-zA-Z0-9]{1}$";
        public const string DNI = "^$|^[0-9]{8}$";
        public const string CC = "^$|^[0-9]{4,10}$";
        public const string RFC = "^$|^[0-9][a-zA-Z0-9]{10}$";

        /// <summary>
        /// Documento de identidad por código de país
        /// </summary>
        public static Dictionary<string, string> DocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", CC },
            { "CL", RUT },
            { "CO", CC },
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "" },
            { "PA", "" },
            { "PE", DNI },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" },
        };
    }

    public static class DictionariesUnete
    {
        /// <summary>
        /// Longitud de texto del telefono fijo key: Codigo del país, value: int
        /// </summary>
        public static Dictionary<string, int> LengthTelefonoFijo = new Dictionary<string, int>
        {
            { "BO", 0 },
            { "CL", 9 },
            { "CO", 7 },
            { "CR", 0 },
            { "DO", 0 },
            { "EC", 0 },
            { "GT", 0 },
            { "MX", 12 },
            { "PA", 0 },
            { "PE", 7 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };

        /// <summary>
        /// Longitud de texto del celular key: Codigo del país, value: int
        /// </summary>
        public static Dictionary<string, int> LengthTelefonoCelular = new Dictionary<string, int>
        {
            { "BO", 0 },
            { "CL", 8 },
            { "CO", 13 },
            { "CR", 0 },
            { "DO", 0 },
            { "EC", 0 },
            { "GT", 0 },
            { "MX", 13 },
            { "PA", 0 },
            { "PE", 9 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };

        /// <summary>
        /// Formatos de los numeros de documento para guardar en BD, key: Codigo del país, value: Func<string, string> 
        /// </summary>
        public static Dictionary<string, Func<string, string>> FormatoNumeroDocumentoBD = new Dictionary<string, Func<string, string>>
        {
            { "BO", null },
            { "CL", t => t.Replace("-", string.Empty) },
            { "CO", t=>t },
            { "CR", null },
            { "DO", null },
            { "EC", null },
            { "GT", null },
            { "MX", t=> t},
            { "PA", null },
            { "PE", t => t },
            { "PR", null },
            { "SV", null },
            { "VE", null }
        };

        /// <summary>
        /// Formatos de los numeros de documento para mostrar, key: Codigo del país, value: Func<string, string> 
        /// </summary>
        public static Dictionary<string, Func<string, string>> FormatoNumeroDocumentoView = new Dictionary<string, Func<string, string>>
        {
            { "BO", null },
            { "CL", t => t.Insert(8, "-") },
            { "CO", t=> t},
            { "CR", null },
            { "DO", null },
            { "EC", null },
            { "GT", null },
            { "MX", t=> t },
            { "PA", null },
            { "PE", t => t },
            { "PR", null },
            { "SV", null },
            { "VE", null }
        };

        /// <summary>
        /// Label para el primero combo de lugares, key: Codigo del país, value: string
        /// </summary>
        public static Dictionary<string, string> LabelLugar1 = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "Ciudad (Región)" },
            { "CO", "Departamento" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "Estado" },
            { "PA", "" },
            { "PE", "Departamento" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };

        /// <summary>
        /// Label para el segundo combo de lugares, key: Codigo del país, value: string
        /// </summary>
        public static Dictionary<string, string> LabelLugar2 = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "Comuna" },
            { "CO", "Municipio" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "Municipio" },
            { "PA", "" },
            { "PE", "Distrito" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };
    }
}