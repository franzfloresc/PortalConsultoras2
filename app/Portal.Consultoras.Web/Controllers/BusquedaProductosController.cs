﻿using System.Web.Mvc;
using Portal.Consultoras.Web.Models.Buscador;

namespace Portal.Consultoras.Web.Controllers
{
    public class BusquedaProductosController : BaseController
    {
        public ActionResult Index(string textoBusqueda = "")
        {
            var model = new BusquedaProductoOutModel
            {
                TextoBusqueda = textoBusqueda
            };
            return View(model);
        }
        
        
    }
    
}