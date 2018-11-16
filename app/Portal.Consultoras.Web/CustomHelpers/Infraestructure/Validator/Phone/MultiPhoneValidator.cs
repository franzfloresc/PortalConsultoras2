using System.Collections.Generic;
using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Validator.Phone
{
    public class MultiPhoneValidator : IPhoneValidator
    {
        private readonly IEnumerable<IPhoneValidator> _validators;

        public MultiPhoneValidator(IEnumerable<IPhoneValidator> validators)
        {
            _validators = validators;
        }

        public async Task<SimpleResult> Valid(string number)
        {
            foreach (var validator in _validators)
            {
                var result = await validator.Valid(number);
                if (!result.Success)
                {
                    return result;
                }
            }

            return new SimpleResult
            {
                Success = true
            };
        }
    }
}