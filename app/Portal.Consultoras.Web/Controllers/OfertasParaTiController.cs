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
        public JsonResult JsonConsultarEstrategias(string cuv, int top = 0)
        {
            List<BEEstrategia> lst = ConsultarEstrategias(cuv ?? "");
            var listModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(lst);

            var listaPedido = ObtenerPedidoWebDetalle();
            listModel.Update(estrategia => 
            {
                estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
                estrategia.UrlCompartirFB = GetUrlCompartirFB();
                estrategia.CodigoEstrategia = Util.Trim(estrategia.CodigoEstrategia);
            });
            
            top = top < listModel.Count() ? top : listModel.Count();

            if (top > 0)
            {
                var listaLanz = new EstrategiaPedidoModel();
                if (top == 1)
                {
                    listaLanz = listModel.FirstOrDefault(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento && e.CodigoEstrategia != "") ?? new EstrategiaPedidoModel();
                    listModel = new List<EstrategiaPedidoModel>();
                    listModel.Add(listaLanz);
                }
                else // if (top == 4)
                {
                    listaLanz = listModel.FirstOrDefault(e=>e.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento) ?? new EstrategiaPedidoModel();
                    var listaDemas = listModel.Where(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento && e.CodigoEstrategia != "").ToList() ?? new List<EstrategiaPedidoModel>();
                    listModel = new List<EstrategiaPedidoModel>();
                    if (listaLanz.CampaniaID > 0)
                    {
                        top--;
                        listModel.Add(listaLanz);
                    }
                    listaDemas.RemoveRange(top, listaDemas.Count() - top);
                    listModel.AddRange(listaDemas);
                }
                
                //listModel.RemoveRange(top, listModel.Count() - top);
            }

            return Json(listModel, JsonRequestBehavior.AllowGet);
        }
    }
}