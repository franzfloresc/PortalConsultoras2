﻿using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Common
{
    public class Dictionaries
    {
        public static Dictionary<string, string> DocumentoIdentidad = new Dictionary<string, string>
        {
            {"BO", ""},
            {"CL", "^$|^[0-9]{8}-[a-zA-Z0-9]{1}$"},
            {"CO", "^$|^[0-9]{10}$"},
            {"CR", ""},
            {"DO", ""},
            {"EC", ""},
            {"GT", ""},
            {"MX", ""},
            {"PA", ""},
            {"PE", "^$|^[0-9]{8}$"},
            {"PR", ""},
            {"SV", ""},
            {"VE", ""},
        };

        public static Dictionary<string, string> DicSexo = new Dictionary<string, string>
        {
            { "M", "Masculino"},
            { "F", "Femenino" }
        };

        /// <summary>
        /// Prefijo de telefono fijo por código de país, key: Codigo del país, value: string
        /// </summary>
        public static Dictionary<string, string> PrefijoTelefonoFijo = new Dictionary<string, string>
        {
            { "BO", "+591" },
            { "CL", "+562" },
            { "CO", "+57" },
            { "CR", "+506" },
            { "DO", "+1" },
            { "EC", "+593" },
            { "GT", "+502" },
            { "MX", "+01" },
            { "PA", "+595" },
            { "PE", "+51" },
            { "PR", "+1" },
            { "SV", "+503" },
            { "VE", "+58" }
        };

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
            { "MX", 10 },
            { "PA", 0 },
            { "PE", 7 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };

        public static Dictionary<string, string> PrefijoTelefonoCelular = new Dictionary<string, string>
        {
            { "BO", "+591" },
            { "CL", "+569" },
            { "CO", "+57" },
            { "CR", "+506" },
            { "DO", "+1" },
            { "EC", "+593" },
            { "GT", "+502" },
            { "MX", "+52" },
            { "PA", "+595" },
            { "PE", "+51" },
            { "PR", "+1" },
            { "SV", "+503" },
            { "VE", "+58" }
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
            { "MX", 10 },
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
            { "CO", t => t },
            { "CR", null },
            { "DO", null },
            { "EC", null },
            { "GT", null },
            { "MX", t => t  },
            { "PA", null },
            { "PE", t => t },
            { "PR", null },
            { "SV", null },
            { "VE", null }
        };

        /// <summary>
        /// Labels de los numeros de documento, key: Codigo del país, value: string
        /// </summary>
        public static Dictionary<string, string> LabelDocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "RUT" },
            { "CO", "Doc. Identidad" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "RFC" },
            { "PA", "" },
            { "PE", "DNI" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };

        public static Dictionary<string, string> PlaceholderDocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "xxxxxxxx-y" },
            { "CO", "xxxxxxxxxx" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "xxxxxxxxxx" },
            { "PA", "" },
            { "PE", "xxxxxxxx" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };

        public static Dictionary<string, string> EjemploDocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "12345678-K" },
            { "CO", "5256478965" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "" },
            { "PA", "" },
            { "PE", "45671234" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };

        public static Dictionary<string, int> MaxLengthDocumentoIdentidad = new Dictionary<string, int>
        {
            { "BO", 0 },
            { "CL", 10 },
            { "CO", 10 },
            { "CR", 0 },
            { "DO", 0 },
            { "EC", 0 },
            { "GT", 0 },
            { "MX", 10 },
            { "PA", 0 },
            { "PE", 0 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };

        public static Dictionary<string, string> MensajeValidacionDocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "valide la cantidad de dígitos ó guíon" },
            { "CO", "valide la cantidad de dígitos" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "valide la cantidad de dígitos"  },
            { "PA", "" },
            { "PE", "valide la cantidad de dígitos" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };

        /// <summary>
        /// Longitud de texto del celular key: Codigo del país, value: int
        /// </summary>
        public static Dictionary<string, int> LengthCodigoPostal = new Dictionary<string, int>
        {
            { "BO", 0 },
            { "CL", 8 },
            { "CO", 13 },
            { "CR", 0 },
            { "DO", 0 },
            { "EC", 0 },
            { "GT", 0 },
            { "MX", 5 },
            { "PA", 0 },
            { "PE", 9 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };

        /// <summary>
        /// Label para el primero combo de lugares, key: Codigo del país, value: string
        /// </summary>
        public static Dictionary<string, string> LabelLugar1 = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "Ciudad (Región)" },
            { "CO",  "Departamento" },
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
            { "CO", "Ciudad" },
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

        public static Dictionary<string, int> MaxLengthCodigoConsultora = new Dictionary<string, int>
        {
            { "BO", 0 },
            { "CL", 7 },
            { "CO", 10},
            { "CR", 0 },
            { "DO", 0 },
            { "EC", 0 },
            { "GT", 0 },
            { "MX", 7 },
            { "PA", 0 },
            { "PE", 9 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };

        public static Dictionary<string, string> CabeceraNumeroDocumento = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "RUT" },
            { "CO", "Cédula"},
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "IFE" },
            { "PA", "" },
            { "PE", "" },
            { "PR", "DNI/RUC" },
            { "SV", "" },
            { "VE", "" }
        };

        public static Dictionary<string, string> TemplateUbigeos = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "TemplatesUbigeos/_UbigeoGrupo1" },
            { "CO", "TemplatesUbigeos/_UbigeoGrupo1"},
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "TemplatesUbigeos/_UbigeoGrupo2" },
            { "PA", "" },
            { "PE", "TemplatesUbigeos/_UbigeoGrupo3" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };

        public static Dictionary<string, string> TemplatDatosGenerales = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "CO", "TemplatesDatosGenerales/_DatosGeneralesGrupo2"},
            { "CR", "" },
            { "DO", "" },
            { "EC", "" },
            { "GT", "" },
            { "MX", "TemplatesDatosGenerales/_DatosGeneralesGrupo1" },
            { "PA", "" },
            { "PE", "TemplatesDatosGenerales/_DatosGeneralesGrupo3" },

            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };
    }
}