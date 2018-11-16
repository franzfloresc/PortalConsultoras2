using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;

namespace Portal.Consultoras.Web.Infraestructure.Sms
{
    public interface ISmsSender
    {
        Task<SimpleResult> Send(string celular);
    }
}
