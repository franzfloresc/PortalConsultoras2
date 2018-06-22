using System.Collections.Generic;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;

namespace Portal.Consultoras.Web.SessionManager.ShowRoom
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
                return (List<EstrategiaPedidoModel>) HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertas];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertas] = value;
            }
        }

        public List<EstrategiaPedidoModel> OfertasSubCampania
        {
            get
            {
                return (List<EstrategiaPedidoModel>)HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomSubCampania];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomSubCampania] = value;
            }
        }

        public List<EstrategiaPedidoModel> OfertasPerdio
        {
            get
            {
                return (List<EstrategiaPedidoModel>)HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasPerdio];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasPerdio] = value;
            }
        }

        public List<EstrategiaPedidoModel> OfertasCompraPorCompra {
            get
            {
                return (List<EstrategiaPedidoModel>)HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasCpc];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasCpc] = value;
            }
        }
    }
}
