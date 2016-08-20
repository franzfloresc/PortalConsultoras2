using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Annotations
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = true)]
    public class ExpressionRequiredIfAttribute : ValidationAttribute, IClientValidatable
    {
        public string OtherProperty { get; private set; }
        public string OtherPropertyDisplayName { get; set; }
        public object OtherPropertyValue { get; private set; }
        public bool IsInverted { get; set; }
        public bool RegexNotMatch { get; set; }
        public string[] Expresiones { get; set; }
        public string[] Mensajes { get; set; }

        public ExpressionRequiredIfAttribute(string otherProperty, object otherPropertyValue)
            : base("'{0}' is required because '{1}' has a value {3}'{2}'.")
        {
            this.OtherProperty = otherProperty;
            this.OtherPropertyValue = otherPropertyValue;
            this.IsInverted = false;
        }

        public override bool RequiresValidationContext
        {
            get { return true; }
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (validationContext == null)
            {
                throw new ArgumentNullException("validationContext");
            }

            PropertyInfo otherProperty = validationContext.ObjectType.GetProperty(this.OtherProperty);
            if (otherProperty == null)
            {
                return new ValidationResult(
                    string.Format(CultureInfo.CurrentCulture, "Could not find a property named '{0}'.", this.OtherProperty));
            }

            object otherValue = otherProperty.GetValue(validationContext.ObjectInstance);

            var listaValores = OtherPropertyValue.ToString().Split(',');

            // check if this value is actually required and validate it
            if (!this.IsInverted && listaValores.Contains(otherValue) ||
                this.IsInverted && !listaValores.Contains(otherValue))
            {
                for (int i = 0; i < Expresiones.Length; i++)
                {
                    var expresionActual = Expresiones[i];
                    var mensajeErrorActual = Mensajes != null && Mensajes.Length > i ? Mensajes[i] : ErrorMessage;

                    var responseMatch = Regex.IsMatch((string) value ?? string.Empty, expresionActual);

                    if ((!responseMatch && !RegexNotMatch) || (responseMatch && RegexNotMatch))
                    {
                        return new ValidationResult(mensajeErrorActual);
                    }
                }
            }

            return ValidationResult.Success;
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var rule = new ModelClientValidationRule();
            rule.ErrorMessage = FormatErrorMessage(metadata.GetDisplayName());
            rule.ValidationParameters.Add("listvalues", OtherPropertyValue);
            rule.ValidationParameters.Add("otherproperty", OtherProperty);
            rule.ValidationParameters.Add("expresiones", string.Join("|", Expresiones ?? new string[] { }));
            rule.ValidationParameters.Add("mensajes", string.Join("|", Mensajes ?? new string[] {}));
            rule.ValidationParameters.Add("regexnotmatch", RegexNotMatch ? 1 : 0);

            rule.ValidationType = "expressionrequiredif";
            yield return rule;
        }
    }
}