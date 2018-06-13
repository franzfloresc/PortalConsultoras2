using System.Collections.Generic;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;

namespace Portal.Consultoras.Web.SessionManager.ShowRoom
{
    public interface IShowRoom
    {
        IBannerInferiorConfiguracion BannerInferiorConfiguracion { get; set; }

        List<EstrategiaPedidoModel> Ofertas { get; set; }
        List<EstrategiaPedidoModel> OfertasCompraPorCompra { get; set; }
    }
}
