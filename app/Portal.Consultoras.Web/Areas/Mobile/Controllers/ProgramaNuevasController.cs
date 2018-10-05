using System.Web.Mvc;
using Portal.Consultoras.Web.Controllers;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class ProgramaNuevasController : BaseViewController
    {
        // GET: ProgramaNuevas
        public ActionResult Index()
        {
            ViewBag.variableEstrategia = GetVariableEstrategia();
            var model = GetLandingModel(1);

            return View(model);
        }
    }
}