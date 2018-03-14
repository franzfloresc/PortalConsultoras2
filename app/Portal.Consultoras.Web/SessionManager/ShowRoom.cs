using System.Web;
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
    }
}
