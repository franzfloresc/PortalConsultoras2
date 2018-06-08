using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Validator.Phone
{
    public class NotExistingPhone : IPhoneValidator
    {
        public Task<SimpleResult> Valid(string number)
        {
            return Task.FromResult(new SimpleResult
            {
                Success = true
            });
        }
    }
}