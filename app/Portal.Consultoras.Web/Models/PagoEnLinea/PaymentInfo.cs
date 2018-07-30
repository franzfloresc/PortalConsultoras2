using System;
using System.ComponentModel.DataAnnotations;
using Portal.Consultoras.Web.Annotations;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    public class PaymentInfo
    {
        [Required(ErrorMessage = "Este campo es obligatorio")]
        [DataType(DataType.CreditCard)]
        [Display(Name = "Número de tarjeta")]
        [StringLength(16, MinimumLength = 13)]
        [LuhnCard(ErrorMessage = "No satisface el algoritmo de validación")]
        public string NumberCard { get; set; }
        [Required(ErrorMessage = "Este campo es obligatorio")]
        [StringLength(2)]
        [Display(Name = "Mes")]
        [DateCard("ExpireYear", ErrorMessage = "La fecha es inválida")]
        public string ExpireMonth { get; set; }
        [Required(ErrorMessage = "Este campo es obligatorio")]
        [StringLength(4)]
        [Display(Name = "Año")]
        public string ExpireYear { get; set; }
        [Required(ErrorMessage = "Este campo es obligatorio")]
        [StringLength(3)]
        [Display(Name = "CVV")]
        public string Cvv { get; set; }
        [Required(ErrorMessage = "Este campo es obligatorio")]
        [StringLength(15)]
        [RegularExpression(@"^[A-Za-z\s]+$", ErrorMessage = "Solo se permite ingreso de caracteres del alfabeto, sin acentos.")]
        public string Titular { get; set; }
        [Display(Name = "Fecha de nacimiento")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? Birthdate { get; set; }
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        [DataType(DataType.PhoneNumber)]
        [Display(Name = "Número de celular")]
        public string Phone { get; set; }
    }
}