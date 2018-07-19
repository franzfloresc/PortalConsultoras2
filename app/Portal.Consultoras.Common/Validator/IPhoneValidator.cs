using System.Threading.Tasks;

namespace Portal.Consultoras.Common.Validator
{
    public interface IPhoneValidator
    {
        Task<SimpleResult> Valid(string number);
    }
}
