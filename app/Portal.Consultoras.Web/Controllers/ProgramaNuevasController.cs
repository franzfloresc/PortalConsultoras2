using System.Web.Mvc;
using Portal.Consultoras.Web.Models.Layout;

namespace Portal.Consultoras.Web.Controllers
{
    public class ProgramaNuevasController : BaseViewController
    {
        // GET: ProgramaNuevas
        public ActionResult Index()
        {
            ViewBag.variableEstrategia = GetVariableEstrategia();
            var model = GetLandingModel(1);
            CargarTituloDesdeMenuActivo();

            return View(model);
        }

        private void CargarTituloDesdeMenuActivo()
        {
            var menu = (MenuContenedorModel) ViewBag.MenuContenedorActivo;
            if (menu == null || menu.ConfiguracionPais == null)
            {
                return;
            }

            ViewBag.Title = menu.ConfiguracionPais.DesktopTituloMenu;
        }
    }
}