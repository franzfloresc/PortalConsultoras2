using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
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
            var listModel = ConsultarEstrategiasModel(cuv ?? "");
           
            if (GetCodigoEstrategia() == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            {
                listModel = ConsultarEstrategiasSegunPantalla(listModel);
            }
            
            return Json(listModel, JsonRequestBehavior.AllowGet);
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasSegunPantalla(List<EstrategiaPedidoModel> listModel)
        {
            var top = listModel.Count();
            if (GetCodigoEstrategia() == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            {
                top = Math.Min(top, IsMobile() ? 1 : 4);
            }

            if (top <= 0)
                return new List<EstrategiaPedidoModel>();

            var listaLanz = new EstrategiaPedidoModel();
            if (top == 1)
            {
                listaLanz = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento) ?? new EstrategiaPedidoModel();
                listModel = new List<EstrategiaPedidoModel>();
                if (listaLanz == default(EstrategiaPedidoModel))
                {
                    listaLanz = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento) ?? new EstrategiaPedidoModel();
                }

                if (listaLanz != default(EstrategiaPedidoModel))
                    listModel.Add(listaLanz);
            }
            else
            {
                listaLanz = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento) ?? new EstrategiaPedidoModel();
                var listaDemas = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
                listModel = new List<EstrategiaPedidoModel>();
                if (listaLanz.EstrategiaID > 0)
                {
                    top--;
                    listModel.Add(listaLanz);
                }
                if (listaDemas.Count() > top)
                {
                    listaDemas.RemoveRange(top, listaDemas.Count() - top);
                }
                listModel.AddRange(listaDemas);
            }

            return listModel;
        }
    }
}