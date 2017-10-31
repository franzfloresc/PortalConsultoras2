using System.Threading.Tasks;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers.Interfaces;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Providers
{
    public class RevistaDigitalProvider : IRevistaDigitalProvider
    {
        public async Task<RevistaDigitalSuscripcionModel> ObtenerSuscripcionAsync(int paisId, string codigoConsultora, int campaniaId)
        {
            using (var serviceClient = new PedidoServiceClient())
            {
                var result = await serviceClient.RDGetSuscripcionAsync(new BERevistaDigitalSuscripcion
                {
                    PaisID = paisId,
                    CodigoConsultora = codigoConsultora,
                    CampaniaID = campaniaId
                });

                if (result == null)
                    return null; //todo: throw?

                return Mapper.Map<RevistaDigitalSuscripcionModel>(result);
            }
        }
    }
}
