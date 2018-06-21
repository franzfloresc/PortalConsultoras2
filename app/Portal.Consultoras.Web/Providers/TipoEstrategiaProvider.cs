using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;

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