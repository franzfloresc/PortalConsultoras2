using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Sms
{
    public interface ISmsConfirm
    {
        Task<SimpleResult> Confirm(string smsCode);
    }
}
