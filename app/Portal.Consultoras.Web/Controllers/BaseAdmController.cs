using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
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

        public JsonResult ObtenterCampaniasPorUsuario()
        {
            var lst = _zonificacionProvider.GetCampanias(userData.PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenterCampaniasPeru()
        {
            IEnumerable<CampaniaModel> lista = _zonificacionProvider.GetCampanias(Constantes.PaisID.Peru);

            return Json(new
            {
                lista = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCampaniasZonasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(PaisID);
            IEnumerable<ZonaModel> lstZonas = _zonificacionProvider.GetZonas(PaisID);

            return Json(new
            {
                lista = lst,
                listaZonas = lstZonas
            }, JsonRequestBehavior.AllowGet);
        }
    }
}