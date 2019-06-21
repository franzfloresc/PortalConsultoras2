using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Controllers
{
    public class ProgramaNuevasController : BaseViewController
    {
        // GET: ProgramaNuevas
        public ActionResult Index()
        {
            ViewBag.variableEstrategia = GetEstrategiaHabilitado();
            ViewBag.CodPalanca = _programaNuevasProvider.TieneDuoPerfecto()
                                    ? Constantes.ConfiguracionPais.ElecMultiple
                                    : Constantes.ConfiguracionPais.ProgramaNuevas;

            RevistaDigitalLandingModel model = GetLandingModel(1, Constantes.ConfiguracionPais.ProgramaNuevas);

            return View(model);
        }
    }
}