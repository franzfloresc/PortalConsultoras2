using System.Collections.Generic;
using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Validator.Phone
{
    /// <summary>
    /// Valida que numero telefonico tenga la longitud valida segun el pais.
    /// </summary>
    public class MatchCountryPhone : IPhoneValidator
    {
        private int _length = -1;
        private readonly Dictionary<string, int> _contryCodes = new Dictionary<string, int>
        {
            {"PE", 9},
            {"MX", 15},
            {"EC", 10},
            {"CL", 15},
            {"BO", 15},
            {"PR", 15},
            {"DO", 15},
            {"CR", 8},
            {"GT", 8},
            {"PA", 8},
            {"SV", 8}
        };

        public string IsoPais
        {
            set
            {
                _length = _contryCodes.ContainsKey(value) ? _contryCodes[value] : -1;
            }
        }

        public Task<SimpleResult> Valid(string number)
        {
            var result = new SimpleResult {Success = false};

            if (_length == -1)
            {
                result.ErrorMessage = "Pais no configurado";

                return Task.FromResult(result);
            }

            if (number.Length != _length)
            {
                result.ErrorMessage = string.Format("El número debe tener {0} dígitos", number);

                return Task.FromResult(result);
            }

            result.Success = true;
            return Task.FromResult(result); 
        }
    }
}