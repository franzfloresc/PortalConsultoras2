using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using System.Globalization;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class EstrategiaProductoController : BaseMobileController
    {
        // GET: Mobile/EstrategiaProducto
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult ObtenerDetalleProducto(EstrategiaPedidoModel item)
        {
            Portal.Consultoras.Web.Controllers.EstrategiaProductoController controllerDesktop = new Web.Controllers.EstrategiaProductoController();
            return controllerDesktop.ObtenerDetalleProducto(item);
        }

        public ActionResult DetalleProducto()
        {
            return View();
        }
    }
}