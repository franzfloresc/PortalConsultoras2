using System.Web.Mvc;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class ProgramaNuevasController : BaseViewController
    {
        // GET: ProgramaNuevas
        public ActionResult Index()
        {
            ViewBag.variableEstrategia = GetVariableEstrategia();
            ViewBag.CodPalanca = _programaNuevasProvider.TieneDuoPerfecto()
                                    ? Constantes.ConfiguracionPais.ElecMultiple
                                    : Constantes.ConfiguracionPais.ProgramaNuevas;

            var model = GetLandingModel(1);

            return View(model);
        }
    }
}