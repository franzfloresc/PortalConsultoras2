using System;
using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Validator.Phone
{
    public class MatchCountryPhone : IPhoneValidator
    {
        public string IsoPais { get; set; }

        public Task<SimpleResult> Valid(string number)
        {
            throw new NotImplementedException();
        }
    }
}