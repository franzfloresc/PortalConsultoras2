using Portal.Consultoras.Common;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EscalaDescuentosController : BaseController
    {

        public ActionResult Index()
        {
            var fileName = "Landing_escala_dscto_" + UserData().CodigoISO + ".jpg";
            var carpetaPais = Globals.UrlEscalaDescuentos + "/" + UserData().CodigoISO;
            ViewBag.Ruta = ConfigS3.GetUrlFileS3(carpetaPais, fileName);

            return View();

        }


    }
}
