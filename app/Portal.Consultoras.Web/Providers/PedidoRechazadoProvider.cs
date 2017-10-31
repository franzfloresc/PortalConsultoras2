using Portal.Consultoras.Web.Providers.Interfaces;
using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Pedido;
using Portal.Consultoras.Web.ServicePedidoRechazado;

namespace Portal.Consultoras.Web.Providers
{
    public class PedidoRechazadoProvider : IPedidoRechazadoProvider
    {
        public async Task<PedidoRechazadoBannerModel> OptenerMotivoAsync(PedidoRechazoUsuarioModel usuario)
        {
            using (var serviceClient = new PedidoRechazadoServiceClient())
            {
                var usuarioMotivoRechazo = Mapper.Map<BEGPRUsuario>(usuario);
                var banner = await serviceClient.GetMotivoRechazoAsync(usuarioMotivoRechazo);
                if (banner == null)
                    return null;

                return Mapper.Map<PedidoRechazadoBannerModel>(banner);
            }
        }
    }
}
