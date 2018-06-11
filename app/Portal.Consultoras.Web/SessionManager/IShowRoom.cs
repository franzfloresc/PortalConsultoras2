using System.Collections.Generic;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;

namespace Portal.Consultoras.Web.SessionManager
{
    public interface IShowRoom
    {
        IBannerInferiorConfiguracion BannerInferiorConfiguracion { get; set; }

        List<ServiceOferta.BEShowRoomOferta> Ofertas { get; set; }
    }
}
