using System.Threading.Tasks;
using Portal.Consultoras.Web.Providers.Interfaces;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Providers
{
    public class NotificacionProvider : INotificacionProvider
    {
        public async Task<int> ObtenerSinLeerAsync(int paisId, long consultoraId, int indicadorBloqueoCDR)
        {
            using (var serviceClient = new UsuarioServiceClient())
            {
                return await serviceClient.GetNotificacionesSinLeerAsync(paisId, consultoraId, indicadorBloqueoCDR);
            }
        }
    }
}
