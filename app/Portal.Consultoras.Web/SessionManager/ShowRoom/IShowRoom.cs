using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.SessionManager.ShowRoom
{
    public interface IShowRoom
    {
        IBannerInferiorConfiguracion BannerInferiorConfiguracion { get; set; }

        List<EstrategiaPedidoModel> Ofertas { get; set; }
        List<EstrategiaPedidoModel> OfertasSubCampania { get; set; }
        List<EstrategiaPedidoModel> OfertasPerdio { get; set; }
        List<EstrategiaPedidoModel> OfertasCompraPorCompra { get; set; }
    }
}
