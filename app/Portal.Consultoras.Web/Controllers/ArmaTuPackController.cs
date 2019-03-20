using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;

namespace Portal.Consultoras.Web.Controllers
{
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
            var area = EsDispositivoMovil() ? "mobile" : string.Empty;
            if (!(revistaDigital.TieneRevistaDigital() && revistaDigital.EsSuscrita))
            {
                return RedirectToAction("Index", "Ofertas", new { Area = area });
            }

            //var area = EsDispositivoMovil() ? "mobile" : string.Empty;
            var IsMobile = EsDispositivoMovil();

            var listaOfertasATP = _ofertaPersonalizadaProvider.ConsultarEstrategiasModel(IsMobile, userData.CodigoISO, userData.CampaniaID, userData.CampaniaID, Constantes.TipoEstrategiaCodigo.ArmaTuPack).ToList();

            if (listaOfertasATP == null || listaOfertasATP.Count() == 0) { return RedirectToAction("Index", "Ofertas", new { Area = area }); };

            var OfertaATP = listaOfertasATP.FirstOrDefault();
            var lstPedidoAgrupado = ObtenerPedidoWebSetDetalleAgrupado(false);
            var packAgregado = lstPedidoAgrupado!=null? lstPedidoAgrupado.Where(x => x.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack).FirstOrDefault() : null;

            var DetalleEstrategiaFichaModel = new DetalleEstrategiaFichaModel {

                CUV2 = OfertaATP.CUV2,
                TipoEstrategiaID = OfertaATP.TipoEstrategiaID,
                EstrategiaID = OfertaATP.EstrategiaID,
                FlagNueva = OfertaATP.FlagNueva,
                CodigoVariante = OfertaATP.CodigoEstrategia,
                EsEditable = packAgregado == null ? false : true,
                IsMobile = IsMobile,
                CampaniaID = userData.CampaniaID,
                CodigoEstrategia = Constantes.TipoEstrategiaCodigo.ArmaTuPack
            };
            return View(DetalleEstrategiaFichaModel);

        }

    }
}