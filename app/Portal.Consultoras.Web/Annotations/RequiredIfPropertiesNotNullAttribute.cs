using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Annotations
{
    /// <summary>
    /// Atributo que permite validar un conjunto de propiedades del modelo para determinar si alguna o todas son nulas.
    /// Se puede condicionar para que la validacion se active solo cuando una determinada propiedad del modelo tiene un valor especifico.
    /// </summary>
    public class RequiredIfPropertiesNotNullAttribute : ValidationAttribute, IClientValidatable
    {
        /// <summary>
        /// Lista de propiedades que se evaluaron si todas son nulas o solo alguna.
        /// Se puede separar una lista de propiedades por coma.
        /// </summary>
        public string Properties { get; private set; }

        /// <summary>
        /// Flag que indica que tipo de condicion se va a tener que cumplir, 
        /// True => Al menos una debe tener valor. 
        /// False => Todas deben tener valor
        /// </summary>
        public bool Condicion { get; private set; }

        /// <summary>
        /// Propiedad que indica si se activa o no la validacion de requerido multiple
        /// </summary>
        public string OtherProperty { get; private set; }

        /// <summary>
        /// Valor que debe tener la propiedad que indica si se activa o no la validacion. Se puede separar una lista de valores por coma.
        /// </summary>
        public object OtherPropertyValue { get; private set; }

        public RequiredIfPropertiesNotNullAttribute(string otherPrperty, string otherValue, string properties, bool todosNoNulos)
             : base("'{0}' is required because '{1}' has a value {3}'{2}'.")
        {
            Properties = properties;
            Condicion = todosNoNulos;
            OtherProperty = otherPrperty;
            OtherPropertyValue = otherValue;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var listaValoresPropiedadesConjunto = new List<object>();

            if (validationContext == null)
            {
                throw new ArgumentNullException("validationContext");
            }

            if (!string.IsNullOrEmpty(this.OtherProperty) && !string.IsNullOrEmpty(OtherPropertyValue.ToString()))
            {
                PropertyInfo propertyConditional = validationContext.ObjectType.GetProperty(this.OtherProperty);

                if (propertyConditional == null)
                {
                    return new ValidationResult(
                        string.Format(CultureInfo.CurrentCulture, "Could not find a property named '{0}'.", this.OtherProperty));
                }

                object propertyConditionalValue = propertyConditional.GetValue(validationContext.ObjectInstance);
                var listaValores = OtherPropertyValue.ToString().Split(',');

                if (!listaValores.Contains(propertyConditionalValue))
                {
                    return ValidationResult.Success;
                }
            }

            var listaPropiedadesEvaluar = Properties.Split(',');
            foreach (var propiedad in listaPropiedadesEvaluar)
            {
                PropertyInfo otherProperty = validationContext.ObjectType.GetProperty(propiedad);
                if (otherProperty == null)
                {
                    return new ValidationResult(
                        string.Format(CultureInfo.CurrentCulture, "Could not find a property named '{0}'.", propiedad));
                }

                object otherValue = otherProperty.GetValue(validationContext.ObjectInstance);
                listaValoresPropiedadesConjunto.Add(otherValue);
            }

            var cantidadTotal = listaValoresPropiedadesConjunto.Count;
            var cantidadNull = listaValoresPropiedadesConjunto.Count(p => p == null || p.ToString() == string.Empty);
            
            if (Condicion ? cantidadNull == cantidadTotal : cantidadNull > 0)
            {
                return new ValidationResult(this.FormatErrorMessage(validationContext.DisplayName));
            }

            return ValidationResult.Success;
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata,
            ControllerContext context)
        {
            var rule = new ModelClientValidationRule();
            rule.ErrorMessage = FormatErrorMessage(metadata.GetDisplayName());
            rule.ValidationParameters.Add("properties", Properties);
            rule.ValidationParameters.Add("condicion", Condicion);
            rule.ValidationParameters.Add("listvalues", OtherPropertyValue);
            rule.ValidationParameters.Add("otherproperty", OtherProperty);

            rule.ValidationType = "requiredifpropertiesnotnull";
            yield return rule;
        }
    }
}