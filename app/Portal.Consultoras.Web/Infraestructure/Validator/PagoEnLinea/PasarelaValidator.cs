using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.PagoEnLinea;

namespace Portal.Consultoras.Web.Infraestructure.Validator.PagoEnLinea
{
    public class PasarelaValidator : IEntityValidator<PaymentInfo>
    {
        private const string NumberCardMessage = "El número de la tarjeta no coincide con el método de pago";
        private const string RequiredMessage = "Este campo es obligatorio";
        private const string DateMaxMessage = "La fecha no puede ser mayor a la fecha actual";

        private List<KeyValuePair<string, string>> _errors;
        public string PatternCard { get; set; }
        public string[] RequiredFields { get; set; }

        public IEnumerable<KeyValuePair<string, string>> Errors
        {
            get { return _errors; }
        }

        public bool IsValid(PaymentInfo info)
        {
            _errors = new List<KeyValuePair<string, string>>();

            if (!Regex.Match(info.NumberCard, PatternCard).Success)
            {
                AddError("NumberCard", NumberCardMessage);

                return false;
            }

            if (RequiredFields.Contains(Constantes.PagoEnLineaCampos.FechaNacimiento))
            {
                if (info.Birthdate == null)
                {
                    AddError("Birthdate", RequiredMessage);
                } else if (info.Birthdate.Value > DateTime.Now.Date)
                {
                    AddError("Birthdate", DateMaxMessage);
                }
            }

            if (RequiredFields.Contains(Constantes.PagoEnLineaCampos.Email)
                && string.IsNullOrEmpty(info.Email))
            {
                AddError("Email", RequiredMessage);
            }

            if (RequiredFields.Contains(Constantes.PagoEnLineaCampos.Celular)
                && string.IsNullOrEmpty(info.Phone))
            {
                AddError("Phone", RequiredMessage);
            }

            return _errors.Count == 0;
        }

        private void AddError(string key, string value)
        {
            _errors.Add(new KeyValuePair<string, string>(key, value));
        }
    }
}