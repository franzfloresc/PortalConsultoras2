using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class OfertasParaTiController : BaseEstrategiaController
    {
        [HttpGet]
        public JsonResult ConsultarEstrategiaSet(string cuv)
        {
            var modelo = EstrategiaGetDetalleCuv(cuv);
            return Json(modelo.Hermanos, JsonRequestBehavior.AllowGet);
        }
        
        [HttpGet]
        public JsonResult JsonConsultarEstrategias(string cuv)
        {
            List<BEEstrategia> lst = ConsultarEstrategias(cuv ?? "");
            var listModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(lst);

            var listaPedido = ObtenerPedidoWebDetalle();
            listModel.Update(estrategia => estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim()));
            listModel.Update(estrategia => estrategia.UrlCompartirFB = GetUrlCompartirFB());

            return Json(listModel, JsonRequestBehavior.AllowGet);
        }
    }
}