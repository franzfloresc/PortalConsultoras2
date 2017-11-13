using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ABCProductoController : BaseController
    {
        public ActionResult Index()
        {
            UrlModel url = new UrlModel();
            url.Nombre = System.Configuration.ConfigurationManager.AppSettings["URL_ABCProductos"] + UserData().PaisID;
            return View(url);
        }

    }
}
