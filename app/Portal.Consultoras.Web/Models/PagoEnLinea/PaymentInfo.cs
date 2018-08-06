using System;
using System.ComponentModel.DataAnnotations;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Annotations;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    public class PaymentInfo
    {
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [Display(Name = "Número de tarjeta")]
        [StringLength(16, MinimumLength = 13, ErrorMessage = Constantes.MvcErrorMessages.RangeErrorMessage)]
        [LuhnCard(ErrorMessage = "No satisface el algoritmo de validación")]
        public string NumberCard { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [StringLength(2)]
        [RegularExpression(@"^\d+$", ErrorMessage = "No es un número válido")]
        [DateCard("ExpireYear", ErrorMessage = "La fecha es inválida")]
        [Display(Name = "Mes")]
        public string ExpireMonth { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [StringLength(4)]
        [RegularExpression(@"^\d+$", ErrorMessage = "No es un número válido")]
        [Display(Name = "Año")]
        public string ExpireYear { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [RegularExpression(@"^\d+$", ErrorMessage = "No es un número válido")]
        [StringLength(3, ErrorMessage = Constantes.MvcErrorMessages.MaxErrorMessage)]
        [Display(Name = "CVV")]
        public string Cvv { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [StringLength(15, ErrorMessage = Constantes.MvcErrorMessages.MaxErrorMessage)]
        [RegularExpression(@"^[A-Za-z\s]+$", ErrorMessage = "Solo se permite ingreso de caracteres del alfabeto, sin acentos.")]
        public string Titular { get; set; }
        [Display(Name = "Número de celular")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? Birthdate { get; set; }
        [StringLength(255, ErrorMessage = Constantes.MvcErrorMessages.MaxErrorMessage)]
        [DataType(DataType.EmailAddress, ErrorMessage = "No es un email válido")]
        public string Email { get; set; }
        [StringLength(20, ErrorMessage = Constantes.MvcErrorMessages.MaxErrorMessage)]
        [DataType(DataType.PhoneNumber, ErrorMessage = "No es un número válido")]
        [Display(Name = "Número de celular")]
        public string Phone { get; set; }
    }
}