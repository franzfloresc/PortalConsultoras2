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
        public JsonResult JsonConsultarEstrategias(string cuv, string tipoOrigenEstrategia = "") 
        {
            var model =  new EstrategiaOutModel();

            var listModel = ConsultarEstrategiasModel(cuv ?? "");
           
            if (GetCodigoEstrategia() == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            {
                listModel = ConsultarEstrategiasSegunPantalla(listModel);
            }
            model.Lista = listModel;
            model.CodigoEstrategia = GetCodigoEstrategia();
            model.Consultora = userData.Sobrenombre;
            model.Titulo = userData.Sobrenombre + " LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
            model.TituloDescripcion = tipoOrigenEstrategia == "1" ? "ENCUENTRA MÁS OFERTAS, MÁS BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS Y AUMENTA TUS GANANCIAS" : 
                (tipoOrigenEstrategia == "2" ? "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS" 
                : "ENCUENTRA LOS PRODUCTOS QUE TUS CLIENTES BUSCAN HASTA 65% DE DSCTO.");

            return Json(model, JsonRequestBehavior.AllowGet);
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasSegunPantalla(List<EstrategiaPedidoModel> listModel)
        {
            listModel = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
            var top = listModel.Count();
            if (GetCodigoEstrategia() == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            {
                top = Math.Min(top, IsMobile() ? 1 : 4);
            }

            if (top <= 0)
                return new List<EstrategiaPedidoModel>();

            var listaAux = new EstrategiaPedidoModel();
            if (top == 1) // mobile
            {
                listaAux = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi) ?? new EstrategiaPedidoModel();
                listModel = new List<EstrategiaPedidoModel>();
                if (listaAux.EstrategiaID == 0)
                {
                    listaAux = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas) ?? new EstrategiaPedidoModel();
                }

                if (listaAux.EstrategiaID > 0)
                    listModel.Add(listaAux);
            }
            else // Desktop
            {
                listaAux = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas) ?? new EstrategiaPedidoModel();
                var listaDemas = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi).ToList() ?? new List<EstrategiaPedidoModel>();
                
                listModel = new List<EstrategiaPedidoModel>();
                if (listaAux.EstrategiaID > 0)
                {
                    top--;
                    listModel.Add(listaAux);
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