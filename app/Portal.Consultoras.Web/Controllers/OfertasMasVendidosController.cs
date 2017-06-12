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
    public class OfertasMasVendidosController : BaseEstrategiaController
    {
               
        [HttpGet]
        public JsonResult ObtenerOfertas(string cuv) 
        {
            var model =  new EstrategiaOutModel();

            var listModel = ConsultarMasVendidosModel();
           
            model.Lista = listModel;
            //model.CodigoEstrategia = GetCodigoEstrategia();
            //model.Consultora = userData.Sobrenombre;
            //model.Titulo = userData.Sobrenombre + " LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA";
            //model.TituloDescripcion = tipoOrigenEstrategia == "1" ? "ENCUENTRA MÁS OFERTAS, MÁS BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS Y AUMENTA TUS GANANCIAS" : 
            //    (tipoOrigenEstrategia == "2" ? "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS" 
            //    : "ENCUENTRA LOS PRODUCTOS QUE TUS CLIENTES BUSCAN HASTA 65% DE DSCTO.");

            //if (model.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            //{
            //    model.OrigenPedidoWeb = tipoOrigenEstrategia == "1" ? Constantes.OrigenPedidoWeb.RevistaDigitalDesktopHomeSeccion
            //        : tipoOrigenEstrategia == "11" ? Constantes.OrigenPedidoWeb.RevistaDigitalDesktopPedidoSeccion
            //        : tipoOrigenEstrategia == "2" ? Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion
            //        : tipoOrigenEstrategia == "22" ? Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion : 0;
            //}
            //else
            //{
            //    model.OrigenPedidoWeb = tipoOrigenEstrategia == "1" ? Constantes.OrigenPedidoWeb.DesktopHomeOfertasParaTi
            //        : tipoOrigenEstrategia == "11" ? Constantes.OrigenPedidoWeb.DesktopPedidoOfertasParaTi
            //        : tipoOrigenEstrategia == "2" ? Constantes.OrigenPedidoWeb.MobileHomeOfertasParaTi
            //        : tipoOrigenEstrategia == "22" ? Constantes.OrigenPedidoWeb.MobilePedidoOfertasParaTi : 0;
            //}

            return Json(model, JsonRequestBehavior.AllowGet);
        }
    }
}