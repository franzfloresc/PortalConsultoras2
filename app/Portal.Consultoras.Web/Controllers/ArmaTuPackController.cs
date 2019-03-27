using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;

namespace Portal.Consultoras.Web.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    [RoutePrefix("ArmaTuPack")]
    public class ArmaTuPackController : BaseController
    {
        public ActionResult Index()
        {
            var cuv = Request.QueryString["cuv"];

            if (String.IsNullOrEmpty(cuv))
            {
                //var estrategia = PreparListaModel(
                //    new BusquedaProductoModel()
                //    {
                //        CampaniaID = userData.CampaniaID
                //    },
                //    Constantes.TipoConsultaOfertaPersonalizadas.ATPObtenerProductos);

                return Json(new { respuesta = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Detalle", "ArmaTuPack", new { cuv = cuv });
            }
        }

        [HttpGet()]
        public ActionResult Detalle()
        {
            var esMobile = EsDispositivoMovil() || IsMobile();
            var area = esMobile ? "mobile" : string.Empty;
            if (!(revistaDigital.TieneRevistaDigital() && revistaDigital.EsSuscrita))
            {
                return RedirectToAction("Index", "Ofertas", new { Area = area });
            }

            var listaOfertasATP = _ofertaPersonalizadaProvider.ConsultarEstrategiasModel(esMobile, userData.CodigoISO, userData.CampaniaID, userData.CampaniaID, Constantes.TipoEstrategiaCodigo.ArmaTuPack).ToList();

            if (listaOfertasATP == null || !listaOfertasATP.Any())
            {
                return RedirectToAction("Index", "Ofertas", new { Area = area });
            }

            var OfertaATP = listaOfertasATP.FirstOrDefault();
            var lstPedidoAgrupado = ObtenerPedidoWebSetDetalleAgrupado(false);
            var packAgregado = lstPedidoAgrupado != null ? lstPedidoAgrupado.FirstOrDefault(x => x.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack) : null;

            var DetalleEstrategiaFichaModel = new DetalleEstrategiaFichaModel
            {

                CUV2 = OfertaATP.CUV2,
                TipoEstrategiaID = OfertaATP.TipoEstrategiaID,
                EstrategiaID = OfertaATP.EstrategiaID,
                FlagNueva = OfertaATP.FlagNueva,
                CodigoVariante = OfertaATP.CodigoEstrategia,
                EsEditable = packAgregado != null,
                IsMobile = esMobile,
                CampaniaID = userData.CampaniaID,
                CodigoEstrategia = Constantes.TipoEstrategiaCodigo.ArmaTuPack
            };
            return View(DetalleEstrategiaFichaModel);
        }
    }
}