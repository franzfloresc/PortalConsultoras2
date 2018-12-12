using Portal.Consultoras.Web.Providers;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public partial class BaseAdmController : BaseController
    {
        public readonly ZonificacionProvider _zonificacionProvider;

        public BaseAdmController()
        {
            _zonificacionProvider = new ZonificacionProvider();
        }
    }
}