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

        public IEnumerable<PaisModel> DropDowListPaises(int rolId = 0)
        {
            if (rolId <= 0)
            {
                rolId = userData.RolID;
            }
            return _zonificacionProvider.GetPaises(userData.PaisID, rolId);
        }
        
        public IEnumerable<RegionModel> DropDownListRegiones(int paisId = 0)
        {
            if (paisId <= 0)
            {
                paisId = userData.PaisID;
            }
            return _zonificacionProvider.GetRegiones(paisId);
        }

    }
}