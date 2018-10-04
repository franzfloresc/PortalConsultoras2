using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
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