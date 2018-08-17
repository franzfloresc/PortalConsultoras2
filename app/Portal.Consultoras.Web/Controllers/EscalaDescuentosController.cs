using Portal.Consultoras.Common;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EscalaDescuentosController : BaseController
    {

        public ActionResult Index()
        {
            var fileName = "Landing_escala_dscto_" + userData.CodigoISO + "_2.jpg";
            var carpetaPais = Globals.UrlEscalaDescuentos + "/" + userData.CodigoISO;
            ViewBag.Ruta = ConfigCdn.GetUrlFileCdn(carpetaPais, fileName);

            return View();

        }


    }
}
