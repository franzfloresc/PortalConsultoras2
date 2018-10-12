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
        [LuhnCard(ErrorMessage = "Número de tarjeta inválida")]
        public string NumberCard { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [StringLength(2)]
        [RegularExpression(@"^\d+$", ErrorMessage = Constantes.MvcErrorMessages.NumberErrorMessage)]
        [DateCard("ExpireYear", ErrorMessage = "La fecha es inválida")]
        [Display(Name = "Mes")]
        public string ExpireMonth { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [StringLength(4)]
        [RegularExpression(@"^\d+$", ErrorMessage = Constantes.MvcErrorMessages.NumberErrorMessage)]
        [Display(Name = "Año")]
        public string ExpireYear { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [RegularExpression(@"^\d+$", ErrorMessage = Constantes.MvcErrorMessages.NumberErrorMessage)]
        [StringLength(3, MinimumLength = 3, ErrorMessage = Constantes.MvcErrorMessages.LengthErrorMessage)]
        [Display(Name = "CVV")]
        public string Cvv { get; set; }
        [Required(ErrorMessage = Constantes.MvcErrorMessages.RequiredMessage)]
        [StringLength(255, ErrorMessage = Constantes.MvcErrorMessages.MaxErrorMessage)]
        [RegularExpression(@"^[A-Za-z\s]+$", ErrorMessage = "Solo se permite ingreso de caracteres del alfabeto, sin acentos.")]
        public string Titular { get; set; }
        [Display(Name = "Número de celular")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? Birthdate { get; set; }
        [StringLength(255, ErrorMessage = Constantes.MvcErrorMessages.MaxErrorMessage)]
        [RegularExpression(@"^[a-zA-Z0-9_.-]+@[a-zA-Z0-9]+[a-zA-Z0-9.-]+[a-zA-Z0-9]+.[a-z]{0,4}$", ErrorMessage = "No es un email válido")]
        public string Email { get; set; }
        [StringLength(20, ErrorMessage = Constantes.MvcErrorMessages.MaxErrorMessage)]
        [RegularExpression(@"^\d+$", ErrorMessage = Constantes.MvcErrorMessages.NumberErrorMessage)]
        [Display(Name = "Número de celular")]
        public string Phone { get; set; }
    }
}