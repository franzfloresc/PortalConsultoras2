using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;
using System.Web;

namespace Portal.Consultoras.Web.SessionManager.OfertaDelDia
{
    public class OfertaDelDia : IOfertaDelDia
    {
        public DataModel Estrategia
        {
            get
            {
                return (DataModel)HttpContext.Current.Session["EstrategiaODD"];
            }
            set
            {
                HttpContext.Current.Session["EstrategiaODD"] = value;
            }
        }
    }
}