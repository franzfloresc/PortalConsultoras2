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
        public string Expresion { get; set; }

        public override object TypeId
        {
            get { return new object(); }
        }

        //To avoid multiple rules with same name
        public static Dictionary<string, int> CountPerField = null;

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
            if (validationContext == null) throw new ArgumentNullException("validationContext");

            var otherProperties = this.OtherProperty.Split('|');
            var otherValueProperties = OtherPropertyValue.ToString().Split('|');
            int validateCount = 0;

            for (int i = 0; i < otherProperties.Length; i++)
            {
                var itemProperty = otherProperties[i];
                PropertyInfo otherProperty = validationContext.ObjectType.GetProperty(itemProperty);
                if (otherProperty == null)
                {
                    return new ValidationResult(string.Format(CultureInfo.CurrentCulture, "Could not find a property named '{0}'.", this.OtherProperty));
                }

                object otherValue = otherProperty.GetValue(validationContext.ObjectInstance);
                if (otherValue != null) otherValue = otherValue.ToString();
                var itemValue = otherValueProperties[i];
                var listaValores = itemValue.Split(',');

                // check if this value is actually required and validate it
                if(listaValores.Contains(otherValue) != this.IsInverted) validateCount++;
            }

            if (validateCount == otherProperties.Length)
            {
                var expresionActual = Expresion;
                var mensajeErrorActual = ErrorMessage;
                var responseMatch = Regex.IsMatch((string)value ?? string.Empty, expresionActual);
                if (responseMatch == RegexNotMatch) return new ValidationResult(mensajeErrorActual);
            }
            return ValidationResult.Success;
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            string key = metadata.ContainerType.FullName + "." + metadata.GetDisplayName();

            int count = 0;
            CountPerField = CountPerField ?? new Dictionary<string, int>();

            if (CountPerField.ContainsKey(key))
            {
                count = ++CountPerField[key];
            }
            else
                CountPerField.Add(key, count);

            var rule = new ModelClientValidationRule();
            string tmp = count == 0 ? "" : char.ConvertFromUtf32(96 + count);

            rule.ErrorMessage = FormatErrorMessage(metadata.GetDisplayName());
            rule.ValidationParameters.Add("listvalues", OtherPropertyValue);
            rule.ValidationParameters.Add("otherproperty", OtherProperty);
            rule.ValidationParameters.Add("expresion", Expresion);
            rule.ValidationParameters.Add("regexnotmatch", RegexNotMatch ? 1 : 0);

            rule.ValidationType = "expressionrequiredif" + tmp;
            yield return rule;
        }
    }
}