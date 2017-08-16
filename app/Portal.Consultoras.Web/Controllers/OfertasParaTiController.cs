using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
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
        public JsonResult ConsultarEstrategiaCuv(string cuv)
        {
            var modelo = EstrategiaGetDetalleCuv(cuv);
            return Json(modelo, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult JsonConsultarEstrategias(string cuv, string tipoOrigenEstrategia = "") 
        {
            // solo se llama en Home y Pedido, desktop y mobile, para los carruseles de opt o rd
      
            var codAgrupa = userData.RevistaDigital.TieneRDR || 
                (userData.RevistaDigital.TieneRDC && userData.RevistaDigital.SuscripcionAnterior2Model.EstadoRegistro == 1) ? 
                Constantes.TipoEstrategiaCodigo.RevistaDigital : "";

            var listModel = ConsultarEstrategiasFiltrarSegunTipo(cuv, codAgrupa);

            var model = new EstrategiaOutModel();
            model.CodigoEstrategia = GetCodigoEstrategia();
            model.Consultora = userData.Sobrenombre;
            model.Titulo = userData.Sobrenombre + " LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
            model.TituloDescripcion = tipoOrigenEstrategia == "1" ? "ENCUENTRA MÁS OFERTAS, MÁS BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS Y AUMENTA TUS GANANCIAS" : 
                (tipoOrigenEstrategia == "2" ? "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS" 
                : "ENCUENTRA LOS PRODUCTOS QUE TUS CLIENTES BUSCAN HASTA 65% DE DSCTO.");

            if (model.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            {
                model.OrigenPedidoWeb = tipoOrigenEstrategia == "1" ? Constantes.OrigenPedidoWeb.RevistaDigitalDesktopHomeSeccion
                    : tipoOrigenEstrategia == "11" ? Constantes.OrigenPedidoWeb.RevistaDigitalDesktopPedidoSeccion
                    : tipoOrigenEstrategia == "2" ? Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion
                    : tipoOrigenEstrategia == "22" ? Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion : 0;
            }
            else
            {
                model.OrigenPedidoWeb = tipoOrigenEstrategia == "1" ? Constantes.OrigenPedidoWeb.DesktopHomeOfertasParaTi
                    : tipoOrigenEstrategia == "11" ? Constantes.OrigenPedidoWeb.DesktopPedidoOfertasParaTi
                    : tipoOrigenEstrategia == "2" ? Constantes.OrigenPedidoWeb.MobileHomeOfertasParaTi
                    : tipoOrigenEstrategia == "22" ? Constantes.OrigenPedidoWeb.MobilePedidoOfertasParaTi : 0;
            }

            model.ListaLan = ConsultarEstrategiasFormatearModelo(listModel.Where(l => l.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList());
            model.ListaModelo = ConsultarEstrategiasFormatearModelo(listModel.Where(l => l.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList());

            return Json(model, JsonRequestBehavior.AllowGet);
        }

       
    }
}