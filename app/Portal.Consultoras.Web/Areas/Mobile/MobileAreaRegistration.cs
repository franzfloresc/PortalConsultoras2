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
                new { action = "Index", id = UrlParameter.Optional },
                new[] { "Portal.Consultoras.Web.Areas.Mobile.Controllers" }
            );
        }
    }
}
