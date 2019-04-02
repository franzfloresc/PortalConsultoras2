using System.Web.Mvc;
using Portal.Consultoras.Web.Models.Layout;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class ProgramaNuevasController : BaseViewController
    {
        // GET: ProgramaNuevas
        public ActionResult Index()
        {
            ViewBag.variableEstrategia = GetVariableEstrategia();
            var model = GetLandingModel(1, Constantes.ConfiguracionPais.ProgramaNuevas);

            return View(model);
        }
    }
}