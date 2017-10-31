using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers.Interfaces;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Providers
{
    public class FlexiPagoProvider : IFlexiPagoProvider
    {
        public async Task<OfertaFlexipagoModel> ObtenerLineaCreditoFlexipagoAsync(int paisId, string codigoConsultora, int campaniaId)
        {
            using (var serviceClient = new PedidoServiceClient())
            {
                var data = await serviceClient.GetLineaCreditoFlexipagoAsync(paisId, codigoConsultora, campaniaId);
                if (data == null)
                    return null;

                return Mapper.Map<OfertaFlexipagoModel>(data);
            }
        }
    }
}
