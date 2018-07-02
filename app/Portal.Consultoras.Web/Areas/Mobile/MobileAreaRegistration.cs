using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile
{
    public class MobileAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Mobile";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Mobile_default",
                "Mobile/{controller}/{action}/{id}",
                new { controller = "Bienvenida", action = "Index", id = UrlParameter.Optional },
                new[] { "Portal.Consultoras.Web.Areas.Mobile.Controllers" }
            );

            context.MapRoute(
                name: "DetalleEstrategiaFichaMobile",
                url: "Mobile/Detalle/{palanca}/{campaniaId}/{cuv}/{origen}",
                defaults: new { controller = "DetalleEstrategia", action = "Ficha", origen = UrlParameter.Optional },
                namespaces: new[] { "Portal.Consultoras.Web.Areas.Mobile.Controllers" }
            );
        }
    }
}
