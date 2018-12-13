using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Annotations;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models
{
    public class DetalleSolicitudPostulanteModel : SolicitudPostulanteModel
    {
        public bool ModoLectura { get; set; }
    }

    public class SolicitudPostulanteModel
    {
        public int SolicitudPostulanteID { get; set; }

        public int? EstadoPostulante { get; set; }

        public string CodigoConsultora { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(18, ErrorMessage = "Máximo 18 caractéres")]
        public string ApellidoPaterno { get; set; }

        [RequiredIf("CodigoPais", "CL,PE", ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(18, ErrorMessage = "Máximo 18 caractéres")]
        public string ApellidoMaterno { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(18, ErrorMessage = "Máximo 18 caractéres")]
        public string PrimerNombre { get; set; }

        [MaxLength(18, ErrorMessage = "Máximo 18 caractéres")]
        public string SegundoNombre { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [ExpressionRequiredIf("CodigoPais", "CL", Expresion = @"\d{8}\-[a-zA-Z0-9]", ErrorMessage = "Formato incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "CO", Expresion = @"^\d{4,10}$", ErrorMessage = "Formato incorrecto")]
        [ExpressionRequiredIf("TipoDocumento|CodigoPais", "1|PE", Expresion = @"^(?:[0-9]{8,10}|)$", ErrorMessage = "Formato incorrecto")]
        [ExpressionRequiredIf("TipoDocumento|CodigoPais", "2,3,5|PE", Expresion = @"^(?:[a-zA-Z0-9]{7,10}|)$", ErrorMessage = "Formato incorrecto")]
        [ExpressionRequiredIf("TipoDocumento|CodigoPais", "4|PE", Expresion = @"^(?:(20|10)[0-9]{10}|)$", ErrorMessage = "Formato incorrecto")]
        [ExpressionRequiredIf("TipoDocumento|CodigoPais", "1|EC", Expresion = @"^[0-9]{10}$", ErrorMessage = "Debe tener 10 dígitos")]
        [ExpressionRequiredIf("TipoDocumento|CodigoPais", "2|EC", Expresion = @"^[0-9]{13}$", ErrorMessage = "Debe tener 13 dígitos")]
        [ExpressionRequiredIf("TipoDocumento|CodigoPais", "3|EC", Expresion = @"^[a-zA-ZñáéíóúÑÁÉÍÓÚüÄÜ0-9]{6,15}$", ErrorMessage = "Debe tener 6 a 15 caracteres")]
        public string NumeroDocumento { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(1, ErrorMessage = "Máximo 1 caractér")]
        public string Sexo { get; set; }

        [Required(ErrorMessage = "Este campo es obligatorio")]
        public string FechaNacimiento { get; set; }

        [MaxLength(140, ErrorMessage = "Máximo 140 caractéres")]
        public string Direccion { get; set; }

        public string Referencia { get; set; }

        [RequiredIfPropertiesNotNull("CodigoPais", "CL,PE,EC", "Telefono,Celular", true, ErrorMessage = "Debe ingresar al menos un teléfono")]
        [RequiredIf("CodigoPais", "MX,EC", ErrorMessage = "Campo obligatorio")]
        [ExpressionRequiredIf("CodigoPais", "MX", Expresion = @"(\d)\1{5,}", RegexNotMatch = true, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "CO", Expresion = @"^(?:[0-9]{7}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "EC", Expresion = @"^(?:[0-9]{9}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "CR", Expresion = @"^(?:[0-9]{8}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "SV", Expresion = @"^(?:[0-9]{0}|[0-9]{8}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "PA", Expresion = @"^(?:[0-9]{0}|[0-9]{8}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "GT", Expresion = @"^(?:[0-9]{0}|[0-9]{8}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "CR", Expresion = @"^(?:[0-9]{0}|[0-9]{8}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "DO", Expresion = @"^(8[0-9]{9}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "PR", Expresion = @"^((787|939)[0-9]{6}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "BO", Expresion = @"^([0-9]{0}|[0-9]{7})$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        public string Telefono { get; set; }

        [RequiredIf("CodigoPais", "CO,MX,EC,BO", ErrorMessage = "Campo obligatorio")]
        [ExpressionRequiredIf("CodigoPais", "MX", Expresion = @"(\d)\1{5,}", RegexNotMatch = true, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "CO", Expresion = @"^(?:(3)[0-9]{9}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "CL", Expresion = @"^(9)[0-9]{8}$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "EC", Expresion = @"^(?:[0-9]{10})$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "SV", Expresion = @"^([0-9]{8})$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "PA", Expresion = @"^([0-9]{8})$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "GT", Expresion = @"^([0-9]{8})$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "CR", Expresion = @"^([0-9]{8})$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "DO", Expresion = @"^(8[0-9]{9})$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "PR", Expresion = @"^((787|939)[0-9]{7}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CodigoPais", "BO", Expresion = @"^([0-9]{8}|)$", RegexNotMatch = false, ErrorMessage = "Formato Incorrecto")]
        [ExpressionRequiredIf("CelularExiste", "2", Expresion = @"^[RegexThatDontMatch]$", ErrorMessage = "El celular ya se encuentra registrado.")]
        public string Celular { get; set; }
        public string CelularExiste { get; set; }

        [EmailAddress(ErrorMessage = "No es un correo válido")]
        [MaxLength(100, ErrorMessage = "Máximo 100 caractéres")]
        [RequiredIf("CodigoPais", "CL,PE,CO,MX,EC,PA,GT,CR,DO,PR", ErrorMessage = "Este campo es obligatorio")]
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

        public string NombreConsultoraRecomienda { get; set; }

        public string CodigoPais { get; set; }
        public string CodigoISO { get; set; }

        public string NombrePrefijoCelular { get; set; }

        public string NombreColonia { get; set; }

        public string DireccionMx { get; set; }

        [RequiredIf("CodigoPais", "PE", ErrorMessage = "Este campo es obligatorio")]
        public int TipoDocumento { get; set; }

        [RequiredIf("TipoDocumento", "4", ErrorMessage = "Este campo es obligatorio")]
        [MaxLength(150, ErrorMessage = "Máximo 150 caractéres")]
        public string RazonSocial { get; set; }

        [RequiredIf("TipoDocumento", "4", ErrorMessage = "Este campo es obligatorio")]
        public string TipoDocumentoLegal { get; set; }

        [RequiredIf("TipoDocumento", "4", ErrorMessage = "Este campo es obligatorio")]
        [ExpressionRequiredIf("TipoDocumentoLegal", "1", Expresion = @"^(?:[0-9]{8}|)$", ErrorMessage = "Formato incorrecto")]
        [ExpressionRequiredIf("TipoDocumentoLegal", "2,3,5", Expresion = @"^(?:[0-9]{12}|)$", ErrorMessage = "Formato incorrecto")]
        public string NumeroDocumentoLegal { get; set; }

        #region AVAL

        public string NombreFamiliar { get; set; }
        public string ApellidoFamiliar { get; set; }
        public int? TipoVinculoFamiliar { get; set; }
        public string CelularFamiliar { get; set; }
        public string TelefonoFamiliar { get; set; }

        public string NombreNoFamiliar { get; set; }
        public string ApellidoNoFamiliar { get; set; }
        public string CelularNoFamiliar { get; set; }
        public string TelefonoNoFamiliar { get; set; }

        public decimal? MontoMeta { get; set; }

        public string PrimerNombreAval { get; set; }
        public string SegundoNombreAval { get; set; }
        public string ApellidoPaternoAval { get; set; }
        public string ApellidoMaternoAval { get; set; }
        public string NumeroDocumentoAval { get; set; }
        public string DireccionAval { get; set; }
        public string CelularAval { get; set; }

        public string VinculoFamiliar { get; set; }
        public IEnumerable<BETablaLogicaDatos> ListaTipoVinculoFamiliar { get; set; }
        #endregion

        public string NumeroDocumentoRegex
        {
            get
            {
                return RegexUtilitiesUnete.GetDocumentoIdentidad(this.CodigoPais);
            }
        }

        public int LengthTelefonoFijo
        {
            get
            {
                return Dictionaries.LengthTelefonoFijo[this.CodigoPais];
            }
        }

        public int LengthTelefonoCelular
        {
            get
            {
                return Dictionaries.LengthTelefonoCelular[this.CodigoPais];
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
        public const string RUC = "";

        /// <summary>
        /// Documento de identidad por código de país
        /// </summary>
        private static Dictionary<string, string> DocumentoIdentidad = new Dictionary<string, string>
        {
            { Constantes.CodigosISOPais.Bolivia, CC },
            { Constantes.CodigosISOPais.Chile, RUT },
            { Constantes.CodigosISOPais.Colombia, CC },
            { Constantes.CodigosISOPais.CostaRica, "" },
            { Constantes.CodigosISOPais.Dominicana, "" },
            { Constantes.CodigosISOPais.Ecuador, "" },
            { Constantes.CodigosISOPais.Guatemala, "" },
            { Constantes.CodigosISOPais.Mexico, "" },
            { Constantes.CodigosISOPais.Panama, "" },
            { Constantes.CodigosISOPais.Peru, DNI },
            { Constantes.CodigosISOPais.PuertoRico, "" },
            { Constantes.CodigosISOPais.Salvador, "" },
            { Constantes.CodigosISOPais.Venezuela, "" },
        };

        public static string GetDocumentoIdentidad(string codigoPais)
        {
            return DocumentoIdentidad[codigoPais];
        }
    }

}