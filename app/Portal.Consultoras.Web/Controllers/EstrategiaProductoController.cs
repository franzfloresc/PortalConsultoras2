using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaProductoController : BaseController
    {
        // GET: EstrategiaProducto
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DetalleProducto(EstrategiaPedidoModel item)
        {
            EstrategiaOutModel model = new EstrategiaOutModel {Item = item};
            return View(model);
        }
    }
}