using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Validator.Phone
{
    public class NotSamePhoneValidator : IPhoneValidator
    {
        private const string ErrorMessage = "El número no puede ser el mismo.";
        public string OriginalPhone { get; set; }
        public Task<SimpleResult> Valid(string number)
        {
            var result = new SimpleResult
            {
                Success = number != OriginalPhone
            };

            if (!result.Success)
            {
                result.Message = ErrorMessage;
            }

            return Task.FromResult(result);
        }
    }
}