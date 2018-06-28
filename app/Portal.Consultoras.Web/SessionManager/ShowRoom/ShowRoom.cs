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

        public List<EstrategiaPersonalizadaProductoModel> Ofertas {
            get
            {
                return (List<EstrategiaPersonalizadaProductoModel>) HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertas];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertas] = value;
            }
        }

        public List<EstrategiaPersonalizadaProductoModel> OfertasSubCampania
        {
            get
            {
                return (List<EstrategiaPersonalizadaProductoModel>)HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomSubCampania];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomSubCampania] = value;
            }
        }

        public List<EstrategiaPersonalizadaProductoModel> OfertasPerdio
        {
            get
            {
                return (List<EstrategiaPersonalizadaProductoModel>)HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasPerdio];
            }
            set
            {
                HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasPerdio] = value;
            }
        }

        //public List<EstrategiaPersonalizadaProductoModel> OfertasCompraPorCompra {
        //    get
        //    {
        //        return (List<EstrategiaPersonalizadaProductoModel>)HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasCpc];
        //    }
        //    set
        //    {
        //        HttpContext.Current.Session[Constantes.ConstSession.ListaShowRoomOfertasCpc] = value;
        //    }
        //}
    }
}
