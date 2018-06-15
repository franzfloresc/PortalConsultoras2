using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Validator.Phone
{
    /// <summary>
    /// Valida que numero telefonico tenga la longitud valida segun el pais.
    /// </summary>
    public class MatchCountryPhone : IPhoneValidator
    {
        public int PaisId { get; set; }

        public Task<SimpleResult> Valid(string number)
        {
            var result = new SimpleResult {Success = false};
            int _, max;

            Util.GetLimitNumberPhone(PaisId, out _, out max);
            if (number == null || number.Length != max)
            {
                result.Message = string.Format("El número debe tener {0} dígitos", number);

                return Task.FromResult(result);
            }
            
            if (!Regex.IsMatch(number, "^\\d+$"))
            {
                result.Message = "No es un número válido";

                return Task.FromResult(result);
            }

            result.Success = true;
            return Task.FromResult(result); 
        }
    }
}