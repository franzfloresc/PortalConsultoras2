using System.Collections.Generic;
using System.Web;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia;

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