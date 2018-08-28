using Portal.Consultoras.Web.Models;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class EstrategiaProductoComentarioController : BaseMobileController
    {
        readonly Web.Controllers.EstrategiaProductoComentarioController controllerDesktop =
            new Web.Controllers.EstrategiaProductoComentarioController();

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult RegistrarComentario(EstrategiaProductoComentarioModel model)
        {

            model.CodigoConsultora = userData.CodigoConsultora;
            model.CampaniaID = userData.CampaniaID;
            return controllerDesktop.RegistrarComentario(model);
        }

        [HttpGet]
        public JsonResult ListarComentarios(string codigoSAP, int cantidadMostrar, int orden)
        {
            return controllerDesktop.ListarComentarios(codigoSAP, cantidadMostrar, orden);
        }
    }
}