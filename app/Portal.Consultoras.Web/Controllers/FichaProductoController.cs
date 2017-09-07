using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class FichaProductoController : BaseController
    {
        [HttpGet]
        public JsonResult ObtenerFichaProducto(string cuv = "", int campanaId = 0)
        {
            var lst = ConsultarFichaProductoPorCuv(cuv, campanaId);
            var producto = FichaProductoFormatearModelo(lst).SingleOrDefault();
            producto = FichaProductoHermanos(producto);
            Session[Constantes.SessionNames.FichaProductoTemporal] = producto;
            return Json(producto, JsonRequestBehavior.AllowGet);
        }

    }
}