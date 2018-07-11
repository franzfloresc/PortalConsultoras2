using System.Threading.Tasks;
using Portal.Consultoras.Common.Validator;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Infraestructure.Sms
{
    public class SmsProcess: ISmsSender, ISmsConfirm
    {
        public UsuarioModel User { get; set; }
        public bool Mobile { get; set; }

        public async Task<SimpleResult> Send(string celular)
        {
            using (var sv = new UsuarioServiceClient())
            {
                var response = await sv.RegistrarEnvioSmsAsync(
                    User.PaisID,
                    User.CodigoUsuario,
                    User.CodigoConsultora,
                    User.CampaniaID,
                    Mobile,
                    User.Celular,
                    celular);

                return new SimpleResult
                {
                    Success = response.Succcess,
                    Message = response.Message
                };
            }
        }

        public async Task<SimpleResult> Confirm(string smsCode)
        {
            using (var sv = new UsuarioServiceClient())
            {
                var response = await sv.ConfirmarCelularPorCodigoSmsAsync(
                    User.PaisID,
                    User.CodigoUsuario,
                    smsCode,
                    User.CampaniaID);

                return new SimpleResult
                {
                    Success = response.Succcess,
                    Message = response.Message
                };
            }
        }
    }
}