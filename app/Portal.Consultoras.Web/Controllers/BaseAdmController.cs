using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceZonificacion;
using System.Collections.Generic;
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

        public IEnumerable<PaisModel> DropDowListPaises(int rolid = 0)
        {
            if (rolid <= 0)
            {
                rolid = userData.RolID;
            }
            return _zonificacionProvider.GetPaises(userData.PaisID, rolid);
        }

    }
}