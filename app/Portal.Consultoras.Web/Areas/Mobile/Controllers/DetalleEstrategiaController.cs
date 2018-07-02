using AutoMapper;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class DetalleEstrategiaController : BaseEstrategiaController
    {

        public ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            if (!EnviaronParametrosValidos(palanca, campaniaId, cuv)) return RedirectToAction("Index", "Ofertas");

            if (!TienePermisoPalanca(palanca)) return RedirectToAction("Index", "Ofertas");

            DetalleEstrategiaFichaModel modelo;
            if (PalancasConSesion(palanca))
            {
                var estrategiaPresonalizada = ObtenerEstrategiaPersonalizada(palanca, cuv, campaniaId);
                if (estrategiaPresonalizada == null) return RedirectToAction("Index", "Ofertas");
                modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(estrategiaPresonalizada);
            }
            else
            {
                modelo = new DetalleEstrategiaFichaModel();
            }

            modelo.Origen = origen;
            modelo.Palanca = palanca;
            modelo.TieneSession = PalancasConSesion(palanca);
            modelo.Campania = campaniaId;
            modelo.Cuv = cuv;

            return View(modelo);
        }

    }
}