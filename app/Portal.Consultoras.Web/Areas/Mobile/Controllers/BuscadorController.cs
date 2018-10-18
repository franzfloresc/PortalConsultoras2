using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Buscador;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class BuscadorController : BaseMobileController
    {
        private readonly BuscadorYFiltrosProvider BuscadorYFiltrosProvider = new BuscadorYFiltrosProvider();
        // GET: Mobile/Buscador
        public ActionResult Index()
        {
            return View();
        }
    }
}