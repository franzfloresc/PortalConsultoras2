using System;
using System.ComponentModel.DataAnnotations;

namespace Portal.Consultoras.Web.Annotations
{
    public class DateCardAttribute : ValidationAttribute
    {
        private readonly string _yearProperty;

        public DateCardAttribute(string yearProperty)
        {
            _yearProperty = yearProperty;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var propertyName = validationContext.ObjectType.GetProperty(_yearProperty);
            if (propertyName == null || value == null)
            {
                return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
            }

            var propertyValue = propertyName.GetValue(validationContext.ObjectInstance, null);
            if (propertyValue == null)
            {
                return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
            }

            DateTime output;
            if (DateTime.TryParse(string.Format("{0}-{1}-01", propertyValue, value), out output)
                && output.AddMonths(1) > DateTime.Now.Date)
            {
                return ValidationResult.Success;
            }

            return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
        }
    }
}