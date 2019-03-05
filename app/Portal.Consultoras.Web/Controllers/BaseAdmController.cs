using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using System.Collections.Generic;
using System.Linq;
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
        
        public JsonResult ObtenerCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(PaisID);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCampaniasNemotecnicoPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(PaisID);
            string habilitarNemotecnico = _tablaLogicaProvider.GetTablaLogicaDatoCodigo(PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.BusquedaNemotecnicoProductoSugerido);
            return Json(new
            {
                lista = lst,
                habilitarNemotecnico = habilitarNemotecnico == "1"
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCampaniasPorPaisOUsuario(int PaisID)
        {
            PaisID = PaisID == 0 ? userData.PaisID : PaisID;
            IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(PaisID);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCampaniasPorUsuario()
        {
            var lst = _zonificacionProvider.GetCampanias(userData.PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCampaniasPeru()
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

        public JsonResult ObtenerCampaniasZonasRegionesPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(PaisID);
            IEnumerable<ZonaModel> lstZonas = _zonificacionProvider.GetZonas(PaisID);
            IEnumerable<RegionModel> lstRegiones = _zonificacionProvider.GetRegiones(PaisID);
            return Json(new
            {
                lstCampania = lst,
                lstZona = lstZonas.OrderBy(p => p.Codigo),
                lstRegion = lstRegiones.OrderBy(p => p.Codigo),
            }, JsonRequestBehavior.AllowGet);
        }
    }
}