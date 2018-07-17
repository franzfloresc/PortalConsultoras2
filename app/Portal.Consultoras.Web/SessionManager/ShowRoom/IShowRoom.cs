using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.SessionManager.ShowRoom
{
    public interface IShowRoom
    {
        IBannerInferiorConfiguracion BannerInferiorConfiguracion { get; set; }

        string CargoOfertas { get; set; }
        List<EstrategiaPersonalizadaProductoModel> Ofertas { get; set; }
        List<EstrategiaPersonalizadaProductoModel> OfertasSubCampania { get; set; }
        List<EstrategiaPersonalizadaProductoModel> OfertasPerdio { get; set; }
        //List<EstrategiaPersonalizadaProductoModel> OfertasCompraPorCompra { get; set; }
    }
}
