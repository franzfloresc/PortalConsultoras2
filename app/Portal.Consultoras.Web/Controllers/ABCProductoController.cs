using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ABCProductoController : BaseController
    {
        public ActionResult Index()
        {
            UrlModel url = new UrlModel
            {
                Nombre = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.URL_ABCProductos) + userData.PaisID
            };
            return View(url);
        }

    }
}
