using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class TipoEstrategiaProvider
    {
        public List<ServicePedido.BETipoEstrategia> GetTipoEstrategias(int paisID, int TipoEstrategiaID)
        {
            List<ServicePedido.BETipoEstrategia> tiposEstrategia;
            var entidad = new ServicePedido.BETipoEstrategia
            {
                PaisID = paisID,
                TipoEstrategiaID = TipoEstrategiaID
            };
            using (var pedidoServiceClient = new PedidoServiceClient())
            {
                tiposEstrategia = pedidoServiceClient.GetTipoEstrategias(entidad).ToList();
            }

            return tiposEstrategia;
        }
    }
}