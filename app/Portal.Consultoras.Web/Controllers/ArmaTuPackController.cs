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
            return RedirectToAction("Detalle", "ArmaTuPack");
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
            var lstPedidoAgrupado = ObtenerPedidoWebSetDetalleAgrupado();
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
                CodigoEstrategia = Constantes.TipoEstrategiaCodigo.ArmaTuPack,
                CodigoUbigeoPortal = CodigoUbigeoPortal.GuionContenedorArmaTuPackGuion,
                Precio = OfertaATP.Precio,
                Precio2 =  OfertaATP.Precio2,
                DescripcionResumen = OfertaATP.DescripcionResumen,
                DescripcionMarca =  OfertaATP.DescripcionMarca,
                DescripcionCategoria = OfertaATP.DescripcionCategoria
            };
            return View(DetalleEstrategiaFichaModel);
        }
    }
}