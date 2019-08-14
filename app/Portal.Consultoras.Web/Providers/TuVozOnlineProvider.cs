using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;

namespace Portal.Consultoras.Web.Providers
{
    public class TuVozOnlineProvider
    {
        public async Task<string> CreateUrl(UsuarioModel user)
        {
            var beUser = AutoMapper.Mapper.Map<BEUsuario>(user);
            using (var service = new ContenidoServiceClient())
            {
                return await service.GetTvoUrlAsync(beUser);
            }
        }
    }
}