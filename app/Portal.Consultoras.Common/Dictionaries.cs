using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Common
{
    public static class Dictionaries
    {
        private static readonly Dictionary<string, string> documentoIdentidad = new Dictionary<string, string>
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
        public static Dictionary<string, string> DocumentoIdentidad { get { return documentoIdentidad; } }

        private static readonly Dictionary<string, string> dicSexo = new Dictionary<string, string>
        {
            { "M", "Masculino"},
            { "F", "Femenino" }
        };
        public static Dictionary<string, string> DicSexo { get { return dicSexo; } }

        /// <summary>
        /// Prefijo de telefono fijo por código de país, key: Codigo del país, value: string
        /// </summary>
        private static readonly Dictionary<string, string> prefijoTelefonoFijo = new Dictionary<string, string>
        {
            { "BO", "+591" },
            { "CL", "+562" },
            { "CO", "+57" },
            { "CR", "+506" },
            { "DO", "+1(809)" },
            { "EC", "+593" },
            { "GT", "+502" },
            { "MX", "+01" },
            { "PA", "+595" },
            { "PE", "+51" },
            { "PR", "+1(787)" },
            { "SV", "+503" },
            { "VE", "+58" }
        };
        public static Dictionary<string, string> PrefijoTelefonoFijo { get { return prefijoTelefonoFijo; } }

        /// <summary>
        /// Longitud de texto del telefono fijo key: Codigo del país, value: int
        /// </summary>
        private static readonly Dictionary<string, int> lengthTelefonoFijo = new Dictionary<string, int>
        {
            { "BO", 0 },
            { "CL", 9 },
            { "CO", 7 },
            { "CR", 0 },
            { "DO", 0 },
            { "EC", 9 },
            { "GT", 0 },
            { "MX", 10 },
            { "PA", 0 },
            { "PE", 7 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };
        public static Dictionary<string, int> LengthTelefonoFijo { get { return lengthTelefonoFijo; } }

        private static readonly Dictionary<string, string> prefijoTelefonoCelular = new Dictionary<string, string>
        {
            { "BO", "+591" },
            { "CL", "+569" },
            { "CO", "+57" },
            { "CR", "+506" },
            { "DO", "+1(809)" },
            { "EC", "+593" },
            { "GT", "+502" },
            { "MX", "+52" },
            { "PA", "+595" },
            { "PE", "+51" },
            { "PR", "+1(787)" },
            { "SV", "+503" },
            { "VE", "+58" }
        };
        public static Dictionary<string, string> PrefijoTelefonoCelular { get { return prefijoTelefonoCelular; } }

        /// <summary>
        /// Longitud de texto del celular key: Codigo del país, value: int
        /// </summary>
        private static readonly Dictionary<string, int> lengthTelefonoCelular = new Dictionary<string, int>
        {
            { "BO", 0 },
            { "CL", 8 },
            { "CO", 13 },
            { "CR", 0 },
            { "DO", 0 },
            { "EC", 10 },
            { "GT", 0 },
            { "MX", 10 },
            { "PA", 0 },
            { "PE", 9 },
            { "PR", 0 },
            { "SV", 0 },
            { "VE", 0 }
        };
        public static Dictionary<string, int> LengthTelefonoCelular { get { return lengthTelefonoCelular; } }

        /// <summary>
        /// Formatos de los numeros de documento para guardar en BD, key: Codigo del país, value: Func<string, string> 
        /// </summary>
        private static readonly Dictionary<string, Func<string, string>> formatoNumeroDocumentoBD = new Dictionary<string, Func<string, string>>
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
        public static Dictionary<string, Func<string, string>> FormatoNumeroDocumentoBD { get { return formatoNumeroDocumentoBD; } }

        /// <summary>
        /// Labels de los numeros de documento, key: Codigo del país, value: string
        /// </summary>
        private static readonly Dictionary<string, string> labelDocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", "Doc. Identidad" },
            { "CL", "RUT" },
            { "CO", "Doc. Identidad" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "Doc. Identidad" },
            { "GT", "" },
            { "MX", "RFC" },
            { "PA", "" },
            { "PE", "DNI" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };
        public static Dictionary<string, string> LabelDocumentoIdentidad { get { return labelDocumentoIdentidad; } }

        private static readonly Dictionary<string, string> placeholderDocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "xxxxxxxx-y" },
            { "CO", "xxxxxxxxxx" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "xxxxxxxx" },
            { "GT", "" },
            { "MX", "xxxxxxxxxx" },
            { "PA", "" },
            { "PE", "xxxxxxxx" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };
        public static Dictionary<string, string> PlaceholderDocumentoIdentidad { get { return placeholderDocumentoIdentidad; } }

        private static readonly Dictionary<string, string> ejemploDocumentoIdentidad = new Dictionary<string, string>
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
        public static Dictionary<string, string> EjemploDocumentoIdentidad { get { return ejemploDocumentoIdentidad; } }

        private static readonly Dictionary<string, int> maxLengthDocumentoIdentidad = new Dictionary<string, int>
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
        public static Dictionary<string, int> MaxLengthDocumentoIdentidad { get { return maxLengthDocumentoIdentidad; } }

        private static readonly Dictionary<string, string> mensajeValidacionDocumentoIdentidad = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "valide la cantidad de dígitos ó guíon" },
            { "CO", "valide la cantidad de dígitos" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "valide la cantidad de dígitos" },
            { "GT", "" },
            { "MX", "valide la cantidad de dígitos"  },
            { "PA", "" },
            { "PE", "valide la cantidad de dígitos" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };
        public static Dictionary<string, string> MensajeValidacionDocumentoIdentidad { get { return mensajeValidacionDocumentoIdentidad; } }

        /// <summary>
        /// Longitud de texto del celular key: Codigo del país, value: int
        /// </summary>
        private static readonly Dictionary<string, int> lengthCodigoPostal = new Dictionary<string, int>
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
        public static Dictionary<string, int> LengthCodigoPostal { get { return lengthCodigoPostal; } }

        /// <summary>
        /// Formatos de los numeros de documento para mostrar, key: Codigo del país, value: Func<string, string> 
        /// </summary>
        private static readonly Dictionary<string, Func<string, string>> formatoNumeroDocumentoView = new Dictionary<string, Func<string, string>>
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
        public static Dictionary<string, Func<string, string>> FormatoNumeroDocumentoView { get { return formatoNumeroDocumentoView; } }

        /// <summary>
        /// Label para el primero combo de lugares, key: Codigo del país, value: string
        /// </summary>
        private static readonly Dictionary<string, string> labelLugar1 = new Dictionary<string, string>
        {
            { "BO", "Departamento" },
            { "CL", "Ciudad (Región)" },
            { "CO",  "Departamento" },
            { "CR", "Provincia" },
            { "DO", "Provincia" },
            { "EC", "Provincia" },
            { "GT", "Departamento" },
            { "MX", "Estado" },
            { "PA", "Provincia" },
            { "PE", "Departamento" },
            { "PR", "Municipio" },
            { "SV", "Departamento" },
            { "VE", "" }
        };
        public static Dictionary<string, string> LabelLugar1 { get { return labelLugar1; } }

        /// <summary>
        /// Label para el segundo combo de lugares, key: Codigo del país, value: string
        /// </summary>
        private static readonly Dictionary<string, string> labelLugar2 = new Dictionary<string, string>
        {
            { "BO", "Ciudad" },
            { "CL", "Comuna" },
            { "CO", "Ciudad" },
            { "CR", "Canton" },
            { "DO", "Municipio" },
            { "EC", "Ciudad" },
            { "GT", "Municipio" },
            { "MX", "Municipio" },
            { "PA", "Distrito" },
            { "PE", "Provincia" },
            { "PR", "Barrio" },
            { "SV", "Municipio" },
            { "VE", "" }
        };
        public static Dictionary<string, string> LabelLugar2 { get { return labelLugar2; } }

        /// <summary>
        /// Label para el segundo combo de lugares, key: Codigo del país, value: string
        /// </summary>
        private static readonly Dictionary<string, string> labelLugar3 = new Dictionary<string, string>
        {
            { "BO", "Barrio" },
            { "CL", "" },
            { "CO", "" },
            { "CR", "Distrito" },
            { "DO", "Barrio" },
            { "EC", "Barrio/Ciudadela" },
            { "GT", "Centro Poblado" },
            { "MX", "" },
            { "PA", "Corregimiento" },
            { "PE", "Distrito" },
            { "PR", "SubBarrio" },
            { "SV", "Canton" },
            { "VE", "" }
        };
        public static Dictionary<string, string> LabelLugar3 { get { return labelLugar3; } }

        /// <summary>
        /// Label para el segundo combo de lugares, key: Codigo del país, value: string
        /// </summary>
        private static readonly Dictionary<string, string> labelLugar4 = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "" },
            { "CO", "" },
            { "CR", "Barrio/Referencia" },
            { "DO", "" },
            { "EC", "Calle Principal" },
            { "GT", "Zona" },
            { "MX", "" },
            { "PA", "Barrio/Colonia" },
            { "PE", "Centro Poblado" },
            { "PR", "" },
            { "SV", "Barrio/Colonia" },
            { "VE", "" }
        };
        public static Dictionary<string, string> LabelLugar4 { get { return labelLugar4; } }

        /// <summary>
        /// Label para el segundo combo de lugares, key: Codigo del país, value: string
        /// </summary>
        private static readonly Dictionary<string, string> labelLugar5 = new Dictionary<string, string>
        {
            { "BO", "" },
            { "CL", "" },
            { "CO", "" },
            { "CR", "" },
            { "DO", "" },
            { "EC", "Calle Secundaria" },
            { "GT", "Barrio/Colonia" },
            { "MX", "" },
            { "PA", "" },
            { "PE", "" },
            { "PR", "" },
            { "SV", "" },
            { "VE", "" }
        };
        public static Dictionary<string, string> LabelLugar5 { get { return labelLugar5; } }

        private static readonly Dictionary<string, int> maxLengthCodigoConsultora = new Dictionary<string, int>
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
        public static Dictionary<string, int> MaxLengthCodigoConsultora { get { return maxLengthCodigoConsultora; } }

        private static readonly Dictionary<string, string> cabeceraNumeroDocumento = new Dictionary<string, string>
        {
            { "BO", "DNI" },
            { "CL", "RUT" },
            { "CO", "Cédula"},
            { "CR", "DNI/RUC" },
            { "DO", "" },
            { "EC", "DNI" },
            { "GT", "DNI/RUC" },
            { "MX", "IFE" },
            { "PA", "DNI/RUC" },
            { "PE", "DNI/RUC" },
            { "PR", "C" },
            { "SV", "DNI/RUC" },
            { "VE", "" }
        };
        public static Dictionary<string, string> CabeceraNumeroDocumento { get { return cabeceraNumeroDocumento; } }

        private static readonly Dictionary<string, string> cabeceraComprobanteDomicilio = new Dictionary<string, string>
        {
            { "BO", "Comprobante Domicilio" },
            { "CL", "Comprobante Domicilio" },
            { "CO", "Comprobante Domicilio"},
            { "CR", "Comprobante Domicilio" },
            { "DO", "" },
            { "EC", "Recibo de Pago" },
            { "GT", "Comprobante Domicilio" },
            { "MX", "Comprobante Domicilio" },
            { "PA", "Comprobante Domicilio" },
            { "PE", "Comprobante Domicilio" },
            { "PR", "Comprobante Domicilio" },
            { "SV", "Comprobante Domicilio" },
            { "VE", "" }
        };
        public static Dictionary<string, string> CabeceraComprobanteDomicilio { get { return cabeceraComprobanteDomicilio; } }

        private static readonly Dictionary<string, string> cabeceraDniAval = new Dictionary<string, string>
        {
            { "BO", "DNI Aval" },
            { "CL", "DNI Aval" },
            { "CO", "DNI Aval"},
            { "CR", "DNI Aval" },
            { "DO", "" },
            { "EC", "DNI Reverso" },
            { "GT", "DNI Aval" },
            { "MX", "DNI Aval" },
            { "PA", "DNI Aval" },
            { "PE", "DNI Aval" },
            { "PR", "" },
            { "SV", "DNI Aval" },
            { "VE", "" }
        };
        public static Dictionary<string, string> CabeceraDniAval { get { return cabeceraDniAval; } }

        private static readonly Dictionary<string, string> templateUbigeos = new Dictionary<string, string>
        {
            { "BO", "TemplatesUbigeos/_UbigeoGrupo8" },
            { "CL", "TemplatesUbigeos/_UbigeoGrupo1" },
            { "CO", "TemplatesUbigeos/_UbigeoGrupo1"},
            { "CR", "TemplatesUbigeos/_UbigeoGrupo4" },
            { "DO", "TemplatesUbigeos/_UbigeoGrupo7" },
            { "EC", "TemplatesUbigeos/_UbigeoGrupo5" },
            { "GT", "TemplatesUbigeos/_UbigeoGrupo4" },
            { "MX", "TemplatesUbigeos/_UbigeoGrupo2" },
            { "PA", "TemplatesUbigeos/_UbigeoGrupo4" },
            { "PE", "TemplatesUbigeos/_UbigeoGrupo3" },
            { "PR", "TemplatesUbigeos/_UbigeoGrupo9" },
            { "SV", "TemplatesUbigeos/_UbigeoGrupo4" },
            { "VE", "" }
        };
        public static Dictionary<string, string> TemplateUbigeos { get { return templateUbigeos; } }

        private static readonly Dictionary<string, RangoEdad> rangoEdadesPais = new Dictionary<string, RangoEdad>
        {
            {PaisesCodigoIso.Chile, new RangoEdad(18, 80)},
            {PaisesCodigoIso.Colombia, new RangoEdad(18, 80)},
            {PaisesCodigoIso.Mexico, new RangoEdad(18, 80)},
            {PaisesCodigoIso.Peru, new RangoEdad(18, 80)},
            {PaisesCodigoIso.Guatemala, new RangoEdad(18, 65, int.MaxValue)},
            {PaisesCodigoIso.Panama, new RangoEdad(18, 65, int.MaxValue)},
            {PaisesCodigoIso.CostaRica, new RangoEdad(16,18, 65, 80)},
            {PaisesCodigoIso.Salvador, new RangoEdad(18, 65, int.MaxValue)},
            {PaisesCodigoIso.Ecuador, new RangoEdad(18, 75)},
            {PaisesCodigoIso.Dominicana, new RangoEdad(18, 65)},
            {PaisesCodigoIso.PuertoRico, new RangoEdad(18, 75)},
            {PaisesCodigoIso.Bolivia, new RangoEdad(18, 65)}
        };
        public static Dictionary<string, RangoEdad> RangoEdadesPais { get { return rangoEdadesPais; } }

        private static readonly Dictionary<string, string> templatDatosGenerales = new Dictionary<string, string>
        {
            { "BO", "TemplatesDatosGenerales/_DatosGeneralesGrupo3" },
            { "CL", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "CO", "TemplatesDatosGenerales/_DatosGeneralesGrupo2"},
            { "CR", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "DO", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "EC", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "GT", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "MX", "TemplatesDatosGenerales/_DatosGeneralesGrupo1" },
            { "PA", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "PE", "TemplatesDatosGenerales/_DatosGeneralesGrupo3" },
            { "PR", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "SV", "TemplatesDatosGenerales/_DatosGeneralesGrupo2" },
            { "VE", "" }
        };
        public static Dictionary<string, string> TemplatDatosGenerales { get { return templatDatosGenerales; } }

        private static readonly Dictionary<string, string> incentivoProgramaNuevasNiveles = new Dictionary<string, string>
        {
            { "01", "PrimerPedido" },
            { "02", "SegundoPedido" },
            { "03", "TercerPedido" },
            { "04", "CuartoPedido" },
            { "05", "QuintoPedido" },
            { "06", "SextoPedido" }
        };
        public static Dictionary<string, string> IncentivoProgramaNuevasNiveles { get { return incentivoProgramaNuevasNiveles; } }

        private static readonly Dictionary<string, string> templatDatosAval = new Dictionary<string, string>
        {
            { "BO", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "CL", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "CO", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "CR", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "DO", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "EC", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "GT", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "MX", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "PA", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "PE", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "PR", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "SV", "TemplatesDatosAval/_DatosAvalGrupo1" },
            { "VE", "TemplatesDatosAval/_DatosAvalGrupo1" },
        };

        public static class FileManager
        {
            public static class TipoArchivo
            {
                public const string FotoPerfilConsultora = "01";
            }

            private static readonly Dictionary<string, string> configuracion = new Dictionary<string, string>
            {
                { TipoArchivo.FotoPerfilConsultora, "FotoPerfil" }
            };

            public static Dictionary<string, string> Configuracion { get { return configuracion; } }
        }

        public static Dictionary<string, string> TemplatDatosAval { get { return templatDatosAval; } }
    }

    public class RangoEdad
    {
        public int EdadMinima { get; set; }
        public int EdadMinimaLimite { get; set; }
        public int EdadMaxima { get; set; }

        public int EdadMinimaRiesgo { get; set; }

        public RangoEdad(int edadMinima, int edadMaxima)
        {
            EdadMinima = edadMinima;
            EdadMaxima = edadMaxima;
            EdadMinimaRiesgo = int.MaxValue;
        }

        public RangoEdad(int edadMinima, int edadMinimaRiesgo, int edadMaxima)
        {
            EdadMinima = edadMinima;
            EdadMaxima = edadMaxima;
            EdadMinimaRiesgo = edadMinimaRiesgo;
        }

        public RangoEdad(int edadMinima, int edadMinimaLimite, int edadMinimaRiesgo, int edadMaxima)
        {
            EdadMinima = edadMinima;
            EdadMinimaLimite = edadMinimaLimite;
            EdadMaxima = edadMaxima;
            EdadMinimaRiesgo = edadMinimaRiesgo;
        }

    }

    public static class PaisesCodigoIso
    {
        public const string Colombia = "CO";
        public const string Mexico = "MX";
        public const string Chile = "CL";
        public const string CostaRica = "CR";
        public const string Guatemala = "GT";
        public const string Salvador = "SV";
        public const string Panama = "PA";
        public const string Peru = "PE";
        public const string Ecuador = "EC";
        public const string Argentina = "AR";
        public const string Brasil = "BR";
        public const string Dominicana = "DO";
        public const string PuertoRico = "PR";
        public const string Bolivia = "BO";
    }
}