﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceUsuario;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [Authorize]
    public partial class BaseAdmController : BaseController
    {
        public readonly ZonificacionProvider _zonificacionProvider;
        protected readonly AdministrarEstrategiaProvider administrarEstrategiaProvider;
        protected readonly CaminoBrillanteProvider _caminoBrillanteProvider;

        public BaseAdmController()
        {
            _zonificacionProvider = new ZonificacionProvider();
            administrarEstrategiaProvider = new AdministrarEstrategiaProvider();
            _caminoBrillanteProvider = new CaminoBrillanteProvider();
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

        public IEnumerable<CampaniaModel> ObtenerCampaniasPorPaisPoput(int PaisID)
        {
            return _zonificacionProvider.GetCampanias(PaisID);
        }


        public JsonResult ObtenerCampaniasNemotecnicoPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(PaisID);
            string habilitarNemotecnico = _tablaLogicaProvider.GetTablaLogicaDatoCodigo(PaisID, ConsTablaLogica.Plan20.TablaLogicaId, ConsTablaLogica.Plan20.BusquedaNemotecnicoProductoSugerido);
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
        [HttpGet]
        public async Task<JsonResult> GetZonasByRegion(int PaisID ,int RegionID)

        {
            IEnumerable<ZonaModel> lstZonas;
            if (RegionID == -1)
            {
                 lstZonas = await _zonificacionProvider.GetZonasAsync(PaisID);
            }
            else
            {

                lstZonas = await _zonificacionProvider.GetZonasByRegionAsync(PaisID, RegionID);

            }

            
            
            return Json(new
            {

                listaZonas = lstZonas.OrderBy(p => p.Codigo),
           
            }, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        [OutputCache(Duration = 3000, VaryByParam = "*", Location = System.Web.UI.OutputCacheLocation.Server)]
        public async Task<JsonResult> ObtenerCampaniasZonasRegionesPorPaisAsync(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = await _zonificacionProvider.GetCampaniasAsync(PaisID);
            IEnumerable<ZonaModel> lstZonas = await _zonificacionProvider.GetZonasAsync(PaisID);
            IEnumerable<RegionModel> lstRegiones = await _zonificacionProvider.GetRegionesAsync(PaisID);
            return Json(new
            {
                lstCampania = lst,
                lstZona = lstZonas.OrderBy(p => p.Codigo),
                lstRegion = lstRegiones.OrderBy(p => p.Codigo),
            }, JsonRequestBehavior.AllowGet);
        }
        #region CaminoBrillante
        public IEnumerable<NivelCaminoBrillanteModel> DropDowListNivelesCaminoBrillante()
        {
            return _caminoBrillanteProvider.GetListaNiveles();
        }

        public List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel> GetListaBeneficiosByNivel(int paisID, string codigoNivel)
        {
            return _caminoBrillanteProvider.GetListaBeneficiosByNivel(paisID, codigoNivel);
        }

        public List<NivelCaminoBrillanteModel.IconoBeneficioCaminoBrillante> DropDowListIconosBeneficios()
        {
            int cantidad = Constantes.CaminoBrillante.Beneficios.Iconos.Count();
            var lstIconos = new List<NivelCaminoBrillanteModel.IconoBeneficioCaminoBrillante>();
            for (int i = 1; i <= cantidad; i++)
            {
                string index = i < 10 ? "0" + i.ToString() : i.ToString();
                lstIconos.Add(new NivelCaminoBrillanteModel.IconoBeneficioCaminoBrillante
                {
                    CodigoIcono = Constantes.CaminoBrillante.Beneficios.Iconos[index],
                    NombreIcono = index,
                    UrlIcono = Constantes.CaminoBrillante.Beneficios.Iconos[index]
                });
            }
            return lstIconos;
        }
        #endregion

    }
}