using System.Collections.Generic;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;

namespace Portal.Consultoras.Web.SessionManager
{
    public class ShowRoom : IShowRoom
    {
        public IBannerInferiorConfiguracion BannerInferiorConfiguracion
        {
            get
            {
                return (BannerInferiorConfiguracion)HttpContext.Current.Session["ShowRoomBannerInferiorConfiguracion"];
            }
            set
            {
                HttpContext.Current.Session["ShowRoomBannerInferiorConfiguracion"] = value;
            }
        }

        public List<EstrategiaPedidoModel> Ofertas {
            get
            {
                return (List<EstrategiaPedidoModel>) HttpContext.Current.Session[Constantes.ConstSession.ListaProductoShowRoom];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaProductoShowRoom] = value;
            }
        }
    }
}
