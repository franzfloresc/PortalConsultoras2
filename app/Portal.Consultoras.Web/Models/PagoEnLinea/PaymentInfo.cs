using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    public class PaymentInfo
    {
        [Required]
        [DataType(DataType.CreditCard)]
        [Display(Name = "Número de tarjeta")]
        [StringLength(16, MinimumLength = 13)]
        public string NumberCard { get; set; }
        [Required]
        [StringLength(2, MinimumLength = 2)]
        [Display(Name = "Mes")]
        public string ExpireMonth { get; set; }
        [Required]
        [StringLength(4, MinimumLength = 4)]
        [Display(Name = "Año")]
        public string ExpireYear { get; set; }
        [Required]
        [StringLength(3)]
        [Display(Name = "CVV")]
        public string Cvv { get; set; }
        [Required]
        [StringLength(15)]
        public string Titular { get; set; }
        [Display(Name = "Fecha de nacimiento")]
        public string Birthdate { get; set; }
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        [DataType(DataType.PhoneNumber)]
        [Display(Name = "Número de celular")]
        public string Phone { get; set; }
    }
}