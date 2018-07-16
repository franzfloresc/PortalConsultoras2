using Portal.Consultoras.Common;

using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class DescargarAppController : BaseMobileController
    {
        public async Task<ActionResult> Index()
        {
            var lstComunicados = await ObtenerComunicadoPorConsultoraAsync();
            var oComunicado = lstComunicados.FirstOrDefault(x => x.Descripcion == Constantes.Comunicado.BannerDescargarAppNuevas);

            if (oComunicado != null) ViewBag.Url = oComunicado.DescripcionAccion;
            else return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });

            ViewBag.ComunicadoId = oComunicado.ComunicadoId;
            ViewBag.EsPaisEsika = ConfigurationManager.AppSettings.Get("PaisesEsika").Contains(userData.CodigoISO) ? "1" : "0";

            sessionManager.SetConsultoraNuevaBannerAppMostrar(true);

            return View();
        }
    }
}