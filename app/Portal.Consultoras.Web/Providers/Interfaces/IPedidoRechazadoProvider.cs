using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Pedido;

namespace Portal.Consultoras.Web.Providers.Interfaces
{
    public interface IPedidoRechazadoProvider
    {
        Task<PedidoRechazadoBannerModel> OptenerMotivoAsync(PedidoRechazoUsuarioModel usuario);
    }
}
